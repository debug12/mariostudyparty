/*
 * Copyright (c) 2006, Peter M. Chen.  All rights reserved.  This software is
 * supplied as is without expressed or implied warranties of any kind.
 */

/*
 * The USB controller is implemented as a device driver running on a
 * general-purpose CPU (separate from the main E100 CPU).
 */
module usbmouse(
    input wire clock,
    input wire clock_valid,
    input wire reset,

    output wire [1:0] OTG_ADDR,         // OTG_ADDR[0] is A0; OTG_ADDR[1] is A1
    inout wire [15:0] OTG_DATA,
    output wire OTG_CS_N,
    output wire OTG_RD_N,
    output wire OTG_WR_N,
    output wire OTG_RST_N,

    input wire mouse_command,
    output wire mouse_response,
    output wire [15:0] mouse_deltax,
    output wire [15:0] mouse_deltay,
    output wire mouse_button1,
    output wire mouse_button2,
    output wire mouse_button3);

    wire [15:0] bus;

    wire [15:0] pc_out;
    wire pc_write, pc_drive;

    wire [15:0] op1_out;
    wire op1_write;

    wire [15:0] op2_out;
    wire op2_write;

    wire [15:0] add_out;
    wire add_drive;

    wire [15:0] sub_out;
    wire sub_drive;

    wire [15:0] mult_out;
    wire mult_drive;

    wire [15:0] div_out;
    wire div_drive;

    wire [15:0] bit_and_out;
    wire bit_and_drive;

    wire [15:0] bit_or_out;
    wire bit_or_drive;

    wire [15:0] bit_not_out;
    wire bit_not_drive;

    wire [15:0] sl_out;
    wire sl_drive;

    wire [15:0] sr_out;
    wire sr_drive;

    wire [15:0] plus1_out;
    wire plus1_drive;

    wire equal_out;
    wire lt_out;

    wire [15:0] opcode_out;
    wire opcode_write;

    wire [15:0] addr0_out;
    wire addr0_write, addr0_drive;

    wire [15:0] addr1_out;
    wire addr1_write, addr1_drive;

    wire [15:0] addr2_out;
    wire addr2_write, addr2_drive;

    wire address_write;

    wire memory_write;
    wire [15:0] memory_out;
    wire memory_drive;

    wire in, out;

    wire [15:0] unused_port71;
    wire [15:0] unused_port74;
    wire [15:0] unused_port75;
    wire [15:0] unused_port76;
    wire [15:0] unused_port1000;
    wire [15:0] unused_port1002;
    wire [15:0] unused_port1003;
    wire [15:0] unused_port1004;
    wire [15:0] unused_port1005;

    register u3 (clock, clock_valid, reset, pc_write, bus, pc_out);
    register u4 (clock, clock_valid, reset, op1_write, bus, op1_out);
    register u5 (clock, clock_valid, reset, op2_write, bus, op2_out);
    register u6 (clock, clock_valid, reset, opcode_write, bus, opcode_out);
    register u7 (clock, clock_valid, reset, addr0_write, bus, addr0_out);
    register u8 (clock, clock_valid, reset, addr1_write, bus, addr1_out);
    register u9 (clock, clock_valid, reset, addr2_write, bus, addr2_out);

    plus1 u10 (pc_out, plus1_out);

    add u11 (op1_out, op2_out, add_out);
    sub u12 (op1_out, op2_out, sub_out);
    mult u13 (clock, op1_out, op2_out, mult_out);
    div u14 (clock, op1_out, op2_out, div_out);
    bit_and u15 (op1_out, op2_out, bit_and_out);
    bit_or u16 (op1_out, op2_out, bit_or_out);
    bit_not u17 (op1_out, bit_not_out);
    sl u18 (op1_out, op2_out, sl_out);
    sr u19 (op1_out, op2_out, sr_out);
    equal u20 (op1_out, op2_out, equal_out);
    lt u21 (op1_out, op2_out, lt_out);

    usbram u22 (bus[10:0], ~address_write, clock_valid, clock, bus, memory_write,
         memory_out);

    // Possible drivers of the main bus
    tristate u23 (pc_out, bus, pc_drive);
    tristate u24 (add_out, bus, add_drive);
    tristate u25 (sub_out, bus, sub_drive);
    tristate u26 (mult_out, bus, mult_drive);
    tristate u27 (div_out, bus, div_drive);
    tristate u28 (bit_and_out, bus, bit_and_drive);
    tristate u29 (bit_or_out, bus, bit_or_drive);
    tristate u30 (bit_not_out, bus, bit_not_drive);
    tristate u31 (sl_out, bus, sl_drive);
    tristate u32 (sr_out, bus, sr_drive);
    tristate u33 (plus1_out, bus, plus1_drive);
    tristate u34 (addr0_out, bus, addr0_drive);
    tristate u35 (addr1_out, bus, addr1_drive);
    tristate u36 (addr2_out, bus, addr2_drive);
    tristate u37 (memory_out, bus, memory_drive);

    // interface to main CPU (port 70-76)
    in_port u38 (16'd70, clock, clock_valid, reset, in, bus,
            {
            15'h0,
            mouse_command
            }
        );
    out_port u39 (16'd71, clock, clock, clock_valid, reset, out, bus,
            {
            unused_port71[14:0],
            mouse_response
            }
        );
    out_port u40 (16'd72, clock, clock, clock_valid, reset, out, bus, mouse_deltax);
    out_port u41 (16'd73, clock, clock, clock_valid, reset, out, bus, mouse_deltay);
    out_port u42 (16'd74, clock, clock, clock_valid, reset, out, bus,
            {
            unused_port74[14:0],
            mouse_button1
            }
        );
    out_port u43 (16'd75, clock, clock, clock_valid, reset, out, bus,
            {
            unused_port75[14:0],
            mouse_button2
            }
        );
    out_port u44 (16'd76, clock, clock, clock_valid, reset, out, bus,
            {
            unused_port76[14:0],
            mouse_button3
            }
        );

    // interface to USB device driver (ports 1000-1005)
    out_port u45 (16'd1000, clock, clock, clock_valid, reset, out, bus,
            {
            unused_port1000[13:0],
            OTG_ADDR
            }
        );
    inout_port u46 (16'd1001, clock, clock, clock_valid, reset, in, out, bus,
                OTG_DATA);
    out_port u47 (16'd1002, clock, clock, clock_valid, reset, out, bus,
            {
            unused_port1002[14:0],
            OTG_CS_N
            }
        );
    out_port u48 (16'd1003, clock, clock, clock_valid, reset, out, bus,
            {
            unused_port1003[14:0],
            OTG_RD_N
            }
        );
    out_port u49 (16'd1004, clock, clock, clock_valid, reset, out, bus,
            {
            unused_port1004[14:0],
            OTG_WR_N
            }
        );
    out_port u50 (16'd1005, clock, clock, clock_valid, reset, out, bus,
            {
            unused_port1005[14:0],
            OTG_RST_N
            }
        );
    
    control u51 (clock, clock_valid, reset, opcode_out, equal_out, lt_out,
        pc_write, pc_drive, plus1_drive, op1_write, op2_write, add_drive,
        sub_drive, mult_drive, div_drive, bit_and_drive, bit_or_drive,
        bit_not_drive, sl_drive, sr_drive, opcode_write, addr0_write,
        addr0_drive, addr1_write, addr1_drive, addr2_write, addr2_drive,
        address_write, memory_write, memory_drive, in, out);

endmodule
