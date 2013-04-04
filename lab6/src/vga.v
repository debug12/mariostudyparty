/*
 * Copyright (c) 2006, Peter M. Chen and Steven Lieberman.  All rights
 * reserved.  This software is supplied as is without expressed or implied
 * warranties of any kind.
 */

/*
 * VGA controller for Analog Devices ADV7123 Video DAC (fmax 140 MHz).
 * Uses ISSI IS61LV25616 (10 ns) SRAM.  vga.{fm,pdf} has a timing diagram
 * that shows how I pipeline the accesses through the SRAM.
 */
module vga(
    input wire OSC_50,
    input wire clock_100m,              // used to generate camera_to_vga_ack
                                        // since camera controller runs at
                                        // 100 MHz
    input wire clock_valid,
    input wire reset_50m,
    input wire reset_100m,

    /*
     * Interface to E100
     */
    input wire vga_command,
    output reg vga_response,
    input wire vga_write,
    input wire [9:0] vga_x1,
    input wire [8:0] vga_y1,
    input wire [9:0] vga_x2,
    input wire [8:0] vga_y2,
    input wire [7:0] vga_color_write,   // write color data to screen
    output reg [7:0] vga_color_read,    // read color data from screen

    /*
     * Interface to camera controller.  Unlike the normal I/O protocol,
     * this is a synchronous interface: e.g., camera_to_vga_ack is asserted for
     * exactly one cycle (to pop the top element off the camera FIFO).
     */
    input wire camera_to_vga_valid,
    output reg camera_to_vga_ack,       // Tell camera controller that
                                        // vga has gotten the data.  This can
                                        // serve as a pop for the camera
                                        // controller's FIFO.
    input wire [9:0] camera_to_vga_x,
    input wire [8:0] camera_to_vga_y,
    input wire [7:0] camera_to_vga_color,

    /*
     * Interface to video DAC
     */
    output reg [9:0] VGA_R,
    output reg [9:0] VGA_G,
    output reg [9:0] VGA_B,
    output reg VGA_CLK,
    output reg VGA_BLANK,
    output reg VGA_HS,
    output reg VGA_VS,
    output reg VGA_SYNC,

    inout reg [15:0] SRAM_DQ,
    output reg SRAM_CE_N,
    output reg SRAM_OE_N,
    output reg SRAM_LB_N,
    output reg SRAM_UB_N,
    output reg SRAM_WE_N,
    output reg [17:0] SRAM_ADDR);

    reg [9:0] vga_horiz;
    reg [9:0] vga_vert;
    reg vga_horiz_incr;
    reg next_vga_clk;

    reg next_sram_we_n;
    reg vga_rgb_write;

    reg [18:0] sram_address;
    reg [9:0] vga_address_x;
    reg [9:0] vga_address_y;
    reg [9:0] cpu_address_x;
    reg [8:0] cpu_address_y;
    reg [1:0] address_select;
    reg [7:0] sram_color;               // color to write to the SRAM
    reg sram_color_select;              // 0: write sram_color from E100
                                        // 1: write sram_color from camera

    reg cpu_address_load;               // load the CPU address registers
    reg cpu_address_incr;               // increment the CPU address registers
    reg doublewrite;                    // can I write 2 pixels at once

    reg vga_response_clear;
    reg vga_response_set;
    reg vga_color_read_write;

    reg [7:0] sram_out;

    reg camera_to_vga_ack_50m;

    reg write_active;                   // carrying out CPU's write request to
                                        // SRAM.  The camera states use this to
                                        // figure out which state to return to.
    reg write_active_set;
    reg write_active_clear;

    reg [3:0] state;
    reg [3:0] next_state;

    /*
     * VGA parameters: from Altera's DE2_Default
     */
    parameter H_SYNC_CYC     = 10'd96;
    parameter H_SYNC_BACK    = 10'd45 + 10'd3;
    parameter H_SYNC_ACT     = 10'd640;    // 646
    parameter H_SYNC_TOTAL   = 10'd800;
    parameter V_SYNC_CYC     = 10'd2;
    parameter V_SYNC_BACK    = 10'd30 + 10'd2;
    parameter V_SYNC_ACT     = 10'd480;    // 484
    parameter V_SYNC_TOTAL   = 10'd525;
    parameter X_START  = H_SYNC_CYC+H_SYNC_BACK;
    parameter Y_START  = V_SYNC_CYC+V_SYNC_BACK;

    /*
     * VGA path.
     */
    always @(posedge OSC_50) begin
        if (reset_50m == 1'b1) begin
            vga_horiz <= 10'd0;
            vga_vert <= 10'd0;

        end else begin
            /*
             * VGA horizontal and vertical counters.
             */
            if (vga_horiz_incr == 1'b1) begin
                if (vga_horiz >= H_SYNC_TOTAL) begin

                    vga_horiz <= 10'd0; 

                    if (vga_vert >= V_SYNC_TOTAL) begin
                        vga_vert <= 10'd0;
                    end else begin
                        vga_vert <= vga_vert + 10'd1;
                    end

                end else begin
                    vga_horiz <= vga_horiz + 10'd1;
                end
            end

            /*
             * Calculate color and control signals.
             */
            if (vga_rgb_write == 1'b1) begin
                if (vga_horiz >= X_START && vga_horiz < X_START+H_SYNC_ACT &&
                    vga_vert >= Y_START && vga_vert < Y_START+V_SYNC_ACT) begin

                    /*
                     * Red:   bits 7-5
                     * Green: bits 4-2
                     * Blue:  bits 1-0.  Only 2 bits because the eye is
                     *        less sensitive to blue, acc. to
                     *        http://en.wikipedia.org/wiki/List_of_color_palettes.
                     * Convert to 10-bit value by repeating the bits.
                     */
                    VGA_R <= { {3{sram_out[7:5]}}, sram_out[7] };
                    VGA_G <= { {3{sram_out[4:2]}}, sram_out[4] };
                    VGA_B <= {5{sram_out[1:0]}};

                end else begin
                    VGA_R <= 10'b0;
                    VGA_G <= 10'b0;
                    VGA_B <= 10'b0;
                end

                if (vga_horiz < H_SYNC_CYC) begin
                    VGA_HS <= 1'b0; 
                end else begin
                    VGA_HS <= 1'b1; 
                end

                if (vga_vert < V_SYNC_CYC) begin
                    VGA_VS <= 1'b0; 
                end else begin
                    VGA_VS <= 1'b1; 
                end

                if (vga_horiz < H_SYNC_CYC || vga_vert < V_SYNC_CYC) begin
                    VGA_BLANK <= 1'b0;
                end else begin
                    VGA_BLANK <= 1'b1;
                end

            end

            /*
             * Remember the color to write to SRAM.  Capture this data in
             * the same cycle that I decide to write the sram (the write takes
             * place 1 cycle later).
             */
            if (next_sram_we_n == 1'b0) begin
                if (sram_color_select == 1'b0) begin
                    sram_color <= vga_color_write;
                end else begin
                    sram_color <= camera_to_vga_color;
                end
            end

            VGA_CLK <= next_vga_clk;

        end
    end

    always @* begin
        VGA_SYNC = 1'b0;
        vga_address_x = vga_horiz - X_START;
        vga_address_y = vga_vert - Y_START;
    end

    /*
     * SRAM
     */
    always @* begin
        SRAM_CE_N = 1'b0; // chip is always enabled
        SRAM_OE_N = 1'b0; // chip is always driving output (maybe set
                          // SRAM_OE_N=1'b1 when writing)

        if (address_select == 2'd0) begin
            sram_address = {vga_address_y[8:0], vga_address_x[9:0]};
        end else if (address_select == 2'd1) begin
            sram_address = {cpu_address_y[8:0], cpu_address_x[9:0]};
        end else begin
            sram_address = {camera_to_vga_y[8:0], camera_to_vga_x[9:0]};
        end

        /*
         * Can I write two pixels at once?
         */
        if (cpu_address_x[0] == 1'b0 && cpu_address_x != vga_x2) begin
            doublewrite = 1'b1;
        end else begin
            doublewrite = 1'b0;
        end

        /*
         * Get the data being read from the sram.  If we're not reading
         * the sram, sram_out is undefined and should be ignored.
         */
        if (SRAM_LB_N == 1'b0) begin
            sram_out = SRAM_DQ[7:0];  // lower byte
        end else begin
            sram_out = SRAM_DQ[15:8]; // upper byte
        end
    end

    /*
     * SRAM_DQ needs to be in a separate always @* block from the one used
     * to compute sram_out.  Otherwise the assignment of zzzz will affect the
     * value assigned to sram_out.
     */
    always @* begin
        if (SRAM_WE_N == 1'b0) begin
            SRAM_DQ = {sram_color, sram_color};
        end else begin
            SRAM_DQ = {16{1'bz}};
        end
    end

    always @(posedge OSC_50) begin
        SRAM_ADDR[17:0] <= sram_address[18:1];
        SRAM_WE_N <= next_sram_we_n;

        if (address_select == 2'd1 && doublewrite == 1'b1) begin
            /*
             * Write two pixels at once.
             */
            SRAM_LB_N <= 1'b0;
            SRAM_UB_N <= 1'b0;
        end else begin
            /*
             * Enable lower or upper byte based on sram_address[0].
             * Signals are active low.
             * sram_address[0] == 0 ==> enable lower byte
             * sram_address[0] == 1 ==> enable upper byte
             */
            SRAM_LB_N <= sram_address[0];
            SRAM_UB_N <= ~sram_address[0];
        end
    end

    /*
     * CPU path
     */
    always @(posedge OSC_50) begin
        if (clock_valid == 1'b0) begin
        end else if (cpu_address_load == 1'b1) begin
            cpu_address_x <= vga_x1;
            cpu_address_y <= vga_y1;
        end else if (cpu_address_incr == 1'b1) begin
            if (doublewrite == 1'b1) begin
                if (cpu_address_x + 10'd1 == vga_x2) begin
                    if (cpu_address_y != vga_y2) begin
                        cpu_address_x <= vga_x1;
                        cpu_address_y <= cpu_address_y + 9'd1;
                    end
                end else begin
                    cpu_address_x <= cpu_address_x + 10'd2;
                end
            end else begin
                if (cpu_address_x == vga_x2) begin
                    if (cpu_address_y != vga_y2) begin
                        cpu_address_x <= vga_x1;
                        cpu_address_y <= cpu_address_y + 9'd1;
                    end
                end else begin
                    cpu_address_x <= cpu_address_x + 10'd1;
                end
            end
        end

        if (vga_color_read_write == 1'b1) begin
            vga_color_read <= sram_out;
        end

        // register vga_response to prevent glitches
        if (reset_50m == 1'b1 || vga_response_clear == 1'b1) begin
            vga_response <= 1'b0;
        end else if (vga_response_set == 1'b1) begin
            vga_response <= 1'b1;
        end

        if (reset_50m == 1'b1 || write_active_clear == 1'b1) begin
            write_active <= 1'b0;
        end else if (write_active_set == 1'b1) begin
            write_active <= 1'b1;
        end
    end

    /*
     * Generate 100 MHz ack for camera controller.
     * camera_to_vga_ack will be asserted at the falling edge of OSC_50
     * in state_camera1, and this should pop the camera FIFO at the next
     * rising edge of OSC_50 (at which edge we'll have already latched
     * the data at the top of the FIFO).
     */
    always @(posedge clock_100m) begin
        if (clock_valid == 1'b0) begin
        end else if (reset_100m == 1'b1) begin
            camera_to_vga_ack <= 1'b0;

        /*
         * Only leave camera_to_vga_ack high for one 100 MHz cycle.
         */
        end else if (camera_to_vga_ack_50m == 1'b1 && camera_to_vga_ack == 1'b0) begin
            camera_to_vga_ack <= 1'b1;
        end else begin
            camera_to_vga_ack <= 1'b0;
        end
    end

    /*
     * Main state machine.
     */
    parameter state_reset =     4'h0;
    parameter state_idle0 =     4'h1;
    parameter state_idle1 =     4'h2;
    parameter state_write1 =    4'h3;
    parameter state_write0 =    4'h4;
    parameter state_read1 =     4'h5;
    parameter state_read0 =     4'h6;
    parameter state_response1 = 4'h7;
    parameter state_response0 = 4'h8;
    parameter state_camera1 =   4'h9;
    parameter state_camera0 =   4'ha;

    always @* begin
        next_state = state_idle0;
        next_vga_clk = 1'b0;
        vga_horiz_incr = 1'b0;
        cpu_address_load = 1'b0;
        cpu_address_incr = 1'b0;
        address_select = 2'd0;
        vga_rgb_write = 1'b0;
        next_sram_we_n = 1'b1;
        sram_color_select = 1'b0;
        vga_response_clear = 1'b0;
        vga_response_set = 1'b0;
        vga_color_read_write = 1'b0;
        camera_to_vga_ack_50m = 1'b0;
        write_active_clear = 1'b0;
        write_active_set = 1'b0;

        case (state)

            state_reset: begin
                next_state = state_idle0;
            end

            state_idle0: begin                  // VGA_CLK=0
                next_vga_clk = 1'b1;
                vga_response_clear = 1'b1;
                cpu_address_load = 1'b1;    // get ready in case it's needed

                if (camera_to_vga_valid == 1'b1) begin
                    next_state = state_camera1;
                end else if (vga_command == 1'b0) begin
                    next_state = state_idle1;
                end else if (vga_write == 1'b0) begin
                    next_state = state_read1;
                end else if (vga_x1 > vga_x2 || vga_y1 > vga_y2) begin
                    /*
                     * Don't change any pixels for negatively sized rectangle,
                     * but do finish the I/O protocol.
                     */
                    next_state = state_response1;
                end else begin
                    next_state = state_write1;
                end
            end

            state_idle1: begin                  // VGA_CLK=1
                vga_horiz_incr = 1'b1;
                cpu_address_load = 1'b1;    // get ready in case it's needed
                address_select = 2'd1;
                vga_rgb_write = 1'b1;
                next_state = state_idle0;
            end

            /*
             * Write data to SRAM from E100.
             */
            state_write1: begin                 // VGA_CLK=1
                vga_horiz_incr = 1'b1;
                address_select = 2'd1;
                vga_rgb_write = 1'b1;
                next_sram_we_n = 1'b0;
                write_active_set = 1'b1;
                next_state = state_write0;
            end

            state_write0: begin                 // VGA_CLK=0
                next_vga_clk = 1'b1;
                cpu_address_incr = 1'b1;
                /*
                 * First check for end of write, so camera states don't
                 * need to check for end of write.  Camera data can wait
                 * until the ack states.
                 */
                if (cpu_address_y == vga_y2 &&
                    ((doublewrite == 1'b0 && cpu_address_x == vga_x2) ||
                      (doublewrite == 1'b1 && cpu_address_x + 10'd1 == vga_x2))
                    ) begin
                    next_state = state_response1;
                end else if (camera_to_vga_valid == 1'b1) begin
                    next_state = state_camera1;
                end else begin
                    next_state = state_write1;
                end
            end

            /*
             * Read data from SRAM to E100.  No need to check for camera
             * input while reading data--just wait until we get back to
             * state_response (which adds finite delay).
             */
            state_read1: begin                  // VGA_CLK=1
                vga_horiz_incr = 1'b1;
                address_select = 2'd1;
                vga_rgb_write = 1'b1;
                next_state = state_read0;
            end

            state_read0: begin                  // VGA_CLK=0
                next_vga_clk = 1'b1;
                vga_color_read_write = 1'b1;
                next_state = state_response1;
            end

            /*
             * Respond to E100.
             */
            state_response1: begin               // VGA_CLK=1
                vga_horiz_incr = 1'b1;
                address_select = 2'd1;
                vga_rgb_write = 1'b1;
                vga_response_set = 1'b1;
                write_active_clear = 1'b1;
                if (vga_command == 1'b0) begin
                    next_state = state_idle0;
                end else begin
                    next_state = state_response0;
                end
            end

            state_response0: begin               // VGA_CLK=0
                next_vga_clk = 1'b1;
                if (camera_to_vga_valid == 1'b1) begin
                    next_state = state_camera1;
                end else begin
                    next_state = state_response1;
                end
            end

            /*
             * Write data to SRAM from camera controller.
             */
            state_camera1: begin                // VGA_CLK=1
                vga_horiz_incr = 1'b1;
                address_select = 2'd2;
                vga_rgb_write = 1'b1;
                next_sram_we_n = 1'b0;
                sram_color_select = 1'b1;
                camera_to_vga_ack_50m = 1'b1;
                next_state = state_camera0;
            end

            state_camera0: begin                // VGA_CLK=0
                next_vga_clk = 1'b1;
                if (camera_to_vga_valid == 1'b1) begin
                    next_state = state_camera1;
                end else if (write_active == 1'b1) begin
                    next_state = state_write1;
                end else if (vga_response == 1'b1) begin
                    next_state = state_response1;
                end else begin
                    next_state = state_idle1;
                end
            end

        endcase
    end

    always @(posedge OSC_50) begin
        if (clock_valid == 1'b0) begin
        end else if (reset_50m == 1'b1) begin
            state <= state_reset;
        end else begin
            state <= next_state;
        end
    end

endmodule
