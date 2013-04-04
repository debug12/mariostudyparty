module inout_port(
    input wire [15:0] port_number,
    input wire clock,
    input wire clock_io,
    input wire clock_valid,
    input wire reset,
    input wire in,
    input wire out,
    inout wire [15:0] bus,
    inout wire [15:0] port_pins);

    reg [15:0] port_data;

    reg pin_drive;              // drive port register onto I/O pins
    reg bus_drive;              // drive port data onto bus

    wire [15:0] port_data_sync;
    wire [15:0] port_pins_sync;

    reg out_delayed;                    // out value, delayed by 1 cycle
    reg [15:0] bus_delayed;             // bus value, delayed by 1 cycle

    // control output to the bus
    synchronizer16 u1 (clock, port_pins, port_pins_sync);
    tristate u2 (port_pins_sync, bus, bus_drive);

    // control output to the I/O pins
    synchronizer16 u3 (clock_io, port_data, port_data_sync);
    tristate u4 (port_data_sync, port_pins, pin_drive);

    always @(posedge clock) begin
        if (clock_valid == 1'b0) begin

        end else if (reset == 1'b1) begin
            port_data <= 16'h0;
            bus_drive <= 1'b0;

        end else begin
            if (in == 1'b1 && bus == port_number) begin
                // Stop driving the I/O pins (until the next OUT instruction).
                pin_drive <= 1'b0;

                // drive the port data onto the bus (this takes place in the
                // next cycle)
                bus_drive <= 1'b1;

            end else begin
                bus_drive <= 1'b0;
            
                if (out_delayed == 1'b1 && bus_delayed == port_number) begin
                    // update the port register
                    port_data <= bus;

                    // start driving the I/O pins (until the next IN instruction)
                    pin_drive <= 1'b1;
                end
            end

            out_delayed <= out;
            bus_delayed <= bus;
        end
    end
endmodule
