/*
 * Copyright (c) 2006, Peter M. Chen.  All rights reserved.  This software is
 * supplied as is without expressed or implied warranties of any kind.
 */
module in_port(
    input wire [15:0] port_number,
    input wire clock,
    input wire clock_valid,
    input wire reset,
    input wire in,
    inout wire [15:0] bus,
    input wire [15:0] port_pins);

    reg bus_drive;                      // drive port data onto bus

    wire [15:0] port_pins_sync;

    synchronizer16 u1 (clock, port_pins, port_pins_sync);
    tristate u2 (port_pins_sync, bus, bus_drive);

    always @(posedge clock) begin
        if (clock_valid == 1'b0) begin

        end else if (reset == 1'b1) begin
            bus_drive <= 1'b0;

        end else if (in == 1'b1 && bus == port_number) begin
            // drive the port data onto the bus (this takes place in the
            // next cycle)
            bus_drive <= 1'b1;

        end else begin
            bus_drive <= 1'b0;

        end
    end

endmodule
