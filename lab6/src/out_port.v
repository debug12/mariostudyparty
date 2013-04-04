/*
 * Copyright (c) 2006, Peter M. Chen.  All rights reserved.  This software is
 * supplied as is without expressed or implied warranties of any kind.
 */
module out_port(
    input wire [15:0] port_number,
    input wire clock,
    input wire clock_io,
    input wire clock_valid,
    input wire reset,
    input wire out,
    input wire [15:0] bus,
    output wire [15:0] port_pins_sync);

    reg out_delayed;                    // out value, delayed by 1 cycle
    reg [15:0] bus_delayed;             // bus value, delayed by 1 cycle
    reg [15:0] port_pins;

    synchronizer16 u2 (clock_io, port_pins, port_pins_sync);

    always @(posedge clock) begin
        if (clock_valid == 1'b0) begin
        end else if (reset == 1'b1) begin
            port_pins <= 16'h0;
        end else begin
            if (out_delayed == 1'b1 && bus_delayed == port_number) begin
                // update the port register
                port_pins <= bus;
            end

            out_delayed <= out;
            bus_delayed <= bus;
        end
    end

endmodule
