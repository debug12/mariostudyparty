/*
 * Copyright (c) 2006, Peter M. Chen.  All rights reserved.  This software is
 * supplied as is without expressed or implied warranties of any kind.
 */

/*
 * LCD controller for Crystalfontz CFAH1602B-TMC-JP.
 */
module lcd(
    input wire clock_12_5m,
    input wire clock_23_8,
    input wire clock_valid,
    input wire reset_12_5m,

    output reg LCD_ON,
    output reg LCD_BLON,
    inout reg [7:0] LCD_DATA,
    output reg LCD_EN,
    output reg LCD_RS,
    output reg LCD_RW,

    input wire lcd_command,
    output reg lcd_response,
    input wire [3:0] lcd_x,
    input wire lcd_y,
    input wire [7:0] lcd_ascii);

    parameter state_reset =    5'h0;
    parameter state_init1 =    5'h1;
    parameter state_init2 =    5'h2;
    parameter state_init3 =    5'h3;
    parameter state_init4 =    5'h4;
    parameter state_init5 =    5'h5;
    parameter state_init6 =    5'h6;
    parameter state_init7 =    5'h7;
    parameter state_init8 =    5'h8;
    parameter state_init9 =    5'h9;
    parameter state_init10 =   5'ha;
    parameter state_init11 =   5'hb;
    parameter state_init12 =   5'hc;
    parameter state_init13 =   5'hd;
    parameter state_init14 =   5'he;
    parameter state_init15 =   5'hf;
    parameter state_init16 =   5'h10;
    parameter state_init17 =   5'h11;
    parameter state_on1 =      5'h12;
    parameter state_on2 =      5'h13;
    parameter state_busy1 =    5'h14;
    parameter state_busy2 =    5'h15;
    parameter state_idle =     5'h16;
    parameter state_cursor1 =  5'h17;
    parameter state_cursor2 =  5'h18;
    parameter state_busyc1 =   5'h19;
    parameter state_busyc2 =   5'h1a;
    parameter state_char1 =    5'h1b;
    parameter state_char2 =    5'h1c;
    parameter state_char3 =    5'h1d;
    parameter state_response = 5'h1e;

    reg [4:0] state;
    reg [4:0] next_state;
    reg [7:0] lcd_data_out;
    reg [7:0] lcd_data_in;
    reg [3:0] count;
    reg next_lcd_response;

    always @* begin
        if (LCD_RW == 1'b0) begin
            LCD_DATA = lcd_data_out;
        end else begin
            LCD_DATA = {8{1'bz}};
        end
    end

    always @* begin
        // default values for control signals
        LCD_ON = 1'b1;
        LCD_BLON = 1'b1;
        lcd_data_out = 8'h00;
        LCD_EN = 1'b0;
        LCD_RS = 1'b0;
        LCD_RW = 1'b0;
        next_lcd_response = 1'b0;
        next_state = state_reset;

	case (state)

	    state_reset: begin
		next_state = state_init1;
	    end

	    // initialize the LCD

	    // get to a known clock edge

	    state_init1: begin
		// wait for clock_23_8 to be high (in the worst case, this
		// state will last 1 cycle)
		if (clock_23_8 == 1'b0) begin
		    next_state = state_init1;
		end else begin
		    next_state = state_init2;
		end
	    end

	    state_init2: begin
		// wait for clock_23_8 to be low (in the worst case, this state
		// will last 1 cycle)
		if (clock_23_8 == 1'b1) begin
		    next_state = state_init2;
		end else begin
		    next_state = state_init3;
		end
	    end

	    state_init3: begin
		// clock_23_8 has just become low
		// power-up: wait at least 15 ms
		if (clock_23_8 == 1'b0) begin
		    next_state = state_init3;
		end else begin
		    next_state = state_init4;
		end
	    end

	    // 1st function set (clock_23_8 has just become high)

	    state_init4: begin
		// LCD_RS, LCD_RW already set up
		LCD_EN = 1'b1;
		lcd_data_out = 8'b00111000;	// latched on falling edge of
						// LCD_EN
		next_state = state_init5;
	    end

	    state_init5: begin
		// wait at least 4.1 ms
		lcd_data_out = 8'b00111000;	// latched on falling edge of
						// LCD_EN
		if (clock_23_8 == 1'b1) begin
		    next_state = state_init5;
		end else begin
		    next_state = state_init6;
		end
	    end

	    // 2nd function set (clock_23_8 has just become low)

	    state_init6: begin
		// LCD_RS, LCD_RW already set up
		LCD_EN = 1'b1;
		lcd_data_out = 8'b00111000;	// latched on falling edge of
						// LCD_EN
		next_state = state_init7;
	    end

	    state_init7: begin
		// wait at least 100 us
		lcd_data_out = 8'b00111000;	// latched on falling edge of
						// LCD_EN
		if (clock_23_8 == 1'b0) begin
		    next_state = state_init7;
		end else begin
		    next_state = state_init8;
		end
	    end

	    // 3rd function set (clock_23_8 has just become high)

	    state_init8: begin
		// LCD_RS, LCD_RW already set up
		LCD_EN = 1'b1;
		lcd_data_out = 8'b00111000;	// latched on falling edge of
						// LCD_EN
		next_state = state_init9;
	    end

	    state_init9: begin
		// wait at least 39 us (is a sleep is missing from the spec?)
		lcd_data_out = 8'b00111000;	// latched on falling edge of
						// LCD_EN
		if (clock_23_8 == 1'b1) begin
		    next_state = state_init9;
		end else begin
		    next_state = state_init10;
		end
	    end

	    // 4th function set (clock_23_8 has just become low)

	    state_init10: begin
		// LCD_RS, LCD_RW already set up
		LCD_EN = 1'b1;
		lcd_data_out = 8'b00111000;	// latched on falling edge of
						// LCD_EN
		next_state = state_init11;
	    end

	    state_init11: begin
		// wait at least 39 us
		lcd_data_out = 8'b00111000;	// latched on falling edge of
						// LCD_EN
		if (clock_23_8 == 1'b0) begin
		    next_state = state_init11;
		end else begin
		    next_state = state_init12;
		end
	    end

	    // display off (clock_23_8 has just become high)

	    state_init12: begin
		// LCD_RS, LCD_RW already set up
		LCD_EN = 1'b1;
		lcd_data_out = 8'b00001000;	// latched on falling edge of
						// LCD_EN
		next_state = state_init13;
	    end

	    state_init13: begin
		// wait at least 39 us
		lcd_data_out = 8'b00001000;	// latched on falling edge of
						// LCD_EN
		if (clock_23_8 == 1'b1) begin
		    next_state = state_init13;
		end else begin
		    next_state = state_init14;
		end
	    end

	    // clear display (clock_23_8 has just become low)

	    state_init14: begin
		// LCD_RS, LCD_RW already set up
		LCD_EN = 1'b1;
		lcd_data_out = 8'b00000001;	// latched on falling edge of
						// LCD_EN
		next_state = state_init15;
	    end

	    state_init15: begin
		// wait at least 39 us
		lcd_data_out = 8'b00000001;	// latched on falling edge of
						// LCD_EN
		if (clock_23_8 == 1'b0) begin
		    next_state = state_init15;
		end else begin
		    next_state = state_init16;
		end
	    end

	    // entry mode set (clock_23_8 has just become high)

	    state_init16: begin
		// LCD_RS, LCD_RW already set up
		LCD_EN = 1'b1;
		lcd_data_out = 8'b00000110;	// latched on falling edge of
						// LCD_EN
		next_state = state_init17;
	    end

	    state_init17: begin
		// wait at least 39 us
		lcd_data_out = 8'b00000110;	// latched on falling edge of
						// LCD_EN
		if (clock_23_8 == 1'b1) begin
		    next_state = state_init17;
		end else begin
		    next_state = state_on1;
		end
	    end

	    // display on

	    state_on1: begin
		// LCD_RS, LCD_RW already set up
		LCD_EN = 1'b1;
		lcd_data_out = 8'b00001100;	// latched on falling edge of
						// LCD_EN
		next_state = state_on2;
	    end

	    state_on2: begin
		lcd_data_out = 8'b00001100;	// latched on falling edge of
						// LCD_EN
		next_state = state_busy1;
	    end

	    // wait for busy flag to be low

	    state_busy1: begin
		LCD_RW = 1'b1;
		next_state = state_busy2;
	    end

	    state_busy2: begin
		LCD_RW = 1'b1;
		LCD_EN = 1'b1;
		if (lcd_data_in[7] == 1'b1) begin
		    next_state = state_busy1;
		end else begin
		    next_state = state_idle;
		end
	    end

	    // wait for command from E100

	    state_idle: begin
		if (lcd_command == 1'b1) begin
		    next_state = state_cursor1;
		end else begin
		    next_state = state_idle;
		end
	    end

	    // write cursor position

	    state_cursor1: begin
		// LCD_RS, LCD_RW already set up
		LCD_EN = 1'b1;
		lcd_data_out = {1'b1, lcd_y, 2'b00, lcd_x};
					    // latched on falling edge of
					    // LCD_EN
		next_state = state_cursor2;
	    end

	    state_cursor2: begin
		lcd_data_out = {1'b1, lcd_y, 2'b00, lcd_x};
					    // latched on falling edge of
					    // LCD_EN
		next_state = state_busyc1;
	    end

	    // wait for busy flag to be low (for cursor command)

	    state_busyc1: begin
		LCD_RW = 1'b1;
		next_state = state_busyc2;
	    end

	    state_busyc2: begin
		LCD_RW = 1'b1;
		LCD_EN = 1'b1;
		if (lcd_data_in[7] == 1'b1) begin
		    next_state = state_busyc1;
		end else begin
		    next_state = state_char1;
		end
	    end

	    // write character

	    state_char1: begin
		LCD_RS = 1'b1;
		next_state = state_char2;
	    end

	    state_char2: begin
		LCD_RS = 1'b1;
		LCD_EN = 1'b1;
		lcd_data_out = lcd_ascii; // latched on falling edge of LCD_EN
		next_state = state_char3;
	    end

	    state_char3: begin
		LCD_RS = 1'b1;
		lcd_data_out = lcd_ascii; // latched on falling edge of LCD_EN
		next_state = state_response;
	    end

	    // respond to the E100 (must first be done using lcd_x, lcd_y,
            // lcd_ascii)

	    state_response: begin
		next_lcd_response = 1'b1;
		if (lcd_command == 1'b1) begin
		    next_state = state_response;
		end else begin
		    next_state = state_busy1;
		end
	    end

        endcase

    end

    always @(posedge clock_12_5m) begin
        // Only advance the state every 16 cycles.  A cleaner solution is to
	// use a 16x slower clock, but this broke the lcd controller (I'm not
	// sure why), even when using synchronizers.  The synchronizers
	// also caused lots of extra warnings, but I think we could have
	// solved these by assigning cut paths, ref Quartus II handbook,
	// Volume 3 (Verification), Section II (Timing Analysis), Cut Paths
	// Between Unrelated Clock Domains.
	
	if (clock_valid == 1'b1) begin
	    count <= count + 4'b1;
	end

        if (clock_valid == 1'b0 || count != 4'b0) begin
        end else if (reset_12_5m == 1'b1) begin
            state <= state_reset;
        end else begin
            state <= next_state;
        end

	// LCD_DATA is prone to glitching.  This caused a bizarre error in
	// which next_state got set to an illegal value.  Register LCD_DATA
	// to solve this error.
	lcd_data_in <= LCD_DATA;

	// register lcd_response to prevent glitches
	lcd_response <= next_lcd_response;
    end

endmodule
