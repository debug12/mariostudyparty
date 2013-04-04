/*
 * Copyright (c) 2006, Peter M. Chen.  All rights reserved.  This software is
 * supplied as is without expressed or implied warranties of any kind.
 */
module top(
    input wire OSC_50,
    input wire OSC_27,
    input wire [3:0] KEY,               // ~KEY[0] toggles reset
    input wire [17:0] SW,               // SW[15:0] is port 0
    output wire [17:0] LED_RED,         // port 1
    output wire [8:0] LED_GREEN,        // LED_GREEN[8] shows reset
                                        // LED_GREEN[7:0] is port 2
    output wire [6:0] HEX0,             // port 3 (HEX3-HEX0)
    output wire [6:0] HEX1,
    output wire [6:0] HEX2,
    output wire [6:0] HEX3,
    output wire [6:0] HEX4,             // port 4 (HEX7-HEX4)
    output wire [6:0] HEX5,
    output wire [6:0] HEX6,
    output wire [6:0] HEX7,

    output wire LCD_ON,
    output wire LCD_BLON,
    inout wire [7:0] LCD_DATA,
    output wire LCD_EN,
    output wire LCD_RS,
    output wire LCD_RW,

    input wire PS2_DAT,
    input wire PS2_CLK,

    output wire AUD_ADCLRCK,
    input wire AUD_ADCDAT,
    output wire AUD_DACLRCK,
    output wire AUD_DACDAT,
    output wire AUD_XCK,
    output wire AUD_BCLK,
    inout wire I2C_SDAT,
    output wire I2C_SCLK,
    input [7:0] TD_DATA,
    input wire TD_CLK,
    output wire TD_RESET,

    output wire [9:0] VGA_R,
    output wire [9:0] VGA_G,
    output wire [9:0] VGA_B,
    output wire VGA_CLK,
    output wire VGA_BLANK,
    output wire VGA_HS,
    output wire VGA_VS,
    output wire VGA_SYNC,

    inout wire [15:0] SRAM_DQ,
    output wire SRAM_CE_N,
    output wire SRAM_OE_N,
    output wire SRAM_LB_N,
    output wire SRAM_UB_N,
    output wire SRAM_WE_N,
    output wire [17:0] SRAM_ADDR,

    output wire [11:0] DRAM_ADDR,
    output wire DRAM_BA_0,
    output wire DRAM_BA_1,
    output wire DRAM_CS_N,
    output wire DRAM_RAS_N,
    output wire DRAM_CAS_N,
    output wire DRAM_WE_N,
    output wire DRAM_CKE,
    output wire DRAM_CLK,
    inout wire [15:0] DRAM_DQ,
    output wire DRAM_LDQM,
    output wire DRAM_UDQM,

    output wire [1:0] OTG_ADDR,         // OTG_ADDR[0] is A0; OTG_ADDR[1] is A1
    inout wire [15:0] OTG_DATA,
    output wire OTG_CS_N,
    output wire OTG_RD_N,
    output wire OTG_WR_N,
    output wire OTG_RST_N,

    inout wire SD_CMD,
    inout wire SD_DAT3,
    inout wire SD_DAT,
    inout wire SD_CLK,

    input wire UART_RXD,
    output wire UART_TXD);

    wire reset_edge;                    // reset signal (after edge detection)
    wire reset;                         // reset signal, synchronized to E100 clock
    wire reset_100m;                    // reset signal, synchronized to clock_100m
    wire reset_50m;                     // reset signal, synchronized to OSC_50
    wire reset_25m;                     // reset signal, synchronized to clock_25m
    wire reset_12_5m;                   // reset signal, synchronized to clock_12_5m

    wire [15:0] bus;

    wire clock, clock_valid;            // main E100 clock
    wire clock_100m;                    // 100 MHz clock
    wire clock_25m;                     // 25 MHz clock
    wire clock_12_5m;                   // 12.5 MHz clock
    wire clock_98k;                     // 98 KHz clock
    wire clock_8_1k;                    // 8.1 KHz clock
    wire clock_23_8;                    // 23.8 Hz clock

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

    wire [15:0] hexdigit_out;
    wire [15:0] hexdigit_out1;
    wire [15:0] timer_out;

    wire [15:0] unused_port2;
    wire [15:0] unused_port10;
    wire [15:0] unused_port12;
    wire [15:0] unused_port13;
    wire [15:0] unused_port14;
    wire [15:0] unused_port20;
    wire [15:0] unused_port30;
    wire [15:0] unused_port32;
    wire [15:0] unused_port33;
    wire [15:0] unused_port34;
    wire [15:0] unused_port40;
    wire [15:0] unused_port50;
    wire [15:0] unused_port60;
    wire [15:0] unused_port62;
    wire [15:0] unused_port63;
    wire [15:0] unused_port64;
    wire [15:0] unused_port65;
    wire [15:0] unused_port66;
    wire [15:0] unused_port67;
    wire [15:0] unused_port70;
    wire [15:0] unused_port80;
    wire [15:0] unused_port82;
    wire [15:0] unused_port83;
    wire [15:0] unused_port84;
    wire [15:0] unused_port90;
    wire [15:0] unused_port100;
    wire [15:0] unused_port102;
    wire [15:0] unused_port110;
    wire [15:0] unused_port114;
    wire [15:0] unused_port115;
    wire [15:0] unused_port120;
    wire [15:0] unused_port130;
    wire [15:0] unused_port132;
    wire [15:0] unused_port133;
    wire [15:0] unused_port134;
    wire [15:0] unused_port135;

    wire lcd_command;
    wire lcd_response;
    wire [3:0] lcd_x;
    wire lcd_y;
    wire [7:0] lcd_ascii;

    wire ps2_command;
    wire ps2_response;
    wire ps2_pressed;
    wire [7:0] ps2_ascii;

    wire sdram_command;
    wire sdram_write;
    wire [10:0] sdram_x;
    wire [10:0] sdram_y;
    wire [15:0] sdram_data_write;
    wire sdram_response;
    wire [15:0] sdram_data_read;

    wire i2c_audio_done;
    wire i2c_video_done;

    wire speaker_command;
    wire speaker_response;
    wire [15:0] speaker_sample;

    wire microphone_command;
    wire microphone_response;
    wire [15:0] microphone_sample;

    wire vga_command;
    wire vga_response;
    wire vga_write;
    wire [9:0] vga_x1;
    wire [8:0] vga_y1;
    wire [9:0] vga_x2;
    wire [8:0] vga_y2;
    wire [7:0] vga_color_write;
    wire [7:0] vga_color_read;

    wire camera_to_vga_valid;
    wire camera_to_vga_ack;
    wire [9:0] camera_to_vga_x;
    wire [8:0] camera_to_vga_y;
    wire [7:0] camera_to_vga_color;

    wire mouse_command;
    wire mouse_response;
    wire [15:0] mouse_deltax;
    wire [15:0] mouse_deltay;
    wire mouse_button1;
    wire mouse_button2;
    wire mouse_button3;

    wire sd_command;
    wire sd_response;
    wire sd_write;
    wire [14:0] sd_address_low;
    wire [14:0] sd_address_high;
    wire [15:0] sd_data_write;
    wire [15:0] sd_data_read;

    wire serial_receive_command;
    wire serial_receive_response;
    wire [7:0] serial_receive_data;

    wire serial_send_command;
    wire serial_send_response;
    wire [7:0] serial_send_data;
    
    wire fft_send_command;
    wire fft_send_response;
    wire fft_send_inverse;
    wire [15:0] fft_send_data_real;
    wire [15:0] fft_send_data_imag;
    wire fft_send_data_end;
    
    wire fft_receive_command;
    wire fft_receive_response;
    wire [15:0] fft_receive_data_real;
    wire [15:0] fft_receive_data_imag;
    wire fft_receive_data_end;

    wire camera_command, camera_response;
    wire [9:0] camera_x;
    wire [8:0] camera_y;
    wire [1:0] camera_scale;
    wire camera_flip;

    clocks u1 (OSC_50, clock, clock_100m, clock_25m, clock_12_5m,
               clock_98k, clock_8_1k, clock_23_8, clock_valid);

    reset_toggle u2 (OSC_50, ~KEY[0], reset_edge, LED_GREEN[8]); // maintains the reset signal

    // Synchronize reset_edge to various clocks to get rid of metastability.
    synchronizer u3 (clock, reset_edge, reset);
    synchronizer u4 (clock_100m, reset_edge, reset_100m);
    synchronizer u5 (OSC_50, reset_edge, reset_50m);
    synchronizer u6 (clock_25m, reset_edge, reset_25m);
    synchronizer u7 (clock_12_5m, reset_edge, reset_12_5m);

    register u8 (clock, clock_valid, reset, pc_write, bus, pc_out);
    register u9 (clock, clock_valid, reset, op1_write, bus, op1_out);
    register u10 (clock, clock_valid, reset, op2_write, bus, op2_out);
    register u11 (clock, clock_valid, reset, opcode_write, bus, opcode_out);
    register u12 (clock, clock_valid, reset, addr0_write, bus, addr0_out);
    register u13 (clock, clock_valid, reset, addr1_write, bus, addr1_out);
    register u14 (clock, clock_valid, reset, addr2_write, bus, addr2_out);

    plus1 u15 (pc_out, plus1_out);

    add u16 (op1_out, op2_out, add_out);
    sub u17 (op1_out, op2_out, sub_out);
    mult u18 (clock, op1_out, op2_out, mult_out);
    div u19 (clock, op1_out, op2_out, div_out);
    bit_and u20 (op1_out, op2_out, bit_and_out);
    bit_or u21 (op1_out, op2_out, bit_or_out);
    bit_not u22 (op1_out, bit_not_out);
    sl u23 (op1_out, op2_out, sl_out);
    sr u24 (op1_out, op2_out, sr_out);
    equal u25 (op1_out, op2_out, equal_out);
    lt u26 (op1_out, op2_out, lt_out);

    ram u27 (bus[13:0], ~address_write, clock_valid, clock, bus, memory_write,
         memory_out);

    // Possible drivers of the main bus
    tristate u28 (pc_out, bus, pc_drive);
    tristate u29 (add_out, bus, add_drive);
    tristate u30 (sub_out, bus, sub_drive);
    tristate u31 (mult_out, bus, mult_drive);
    tristate u32 (div_out, bus, div_drive);
    tristate u33 (bit_and_out, bus, bit_and_drive);
    tristate u34 (bit_or_out, bus, bit_or_drive);
    tristate u35 (bit_not_out, bus, bit_not_drive);
    tristate u36 (sl_out, bus, sl_drive);
    tristate u37 (sr_out, bus, sr_drive);
    tristate u38 (plus1_out, bus, plus1_drive);
    tristate u39 (addr0_out, bus, addr0_drive);
    tristate u40 (addr1_out, bus, addr1_drive);
    tristate u41 (addr2_out, bus, addr2_drive);
    tristate u42 (memory_out, bus, memory_drive);

    // switch port (port 0)
    in_port u43 (16'd0, clock, clock_valid, reset, in, bus, SW[15:0]);

    // led_red port (port 1)
    out_port u44 (16'd1, clock, clock, clock_valid, reset, out, bus,
              LED_RED[15:0]);

    // led_green port (port 2)
    out_port u45 (16'd2, clock, clock, clock_valid, reset, out, bus,
            {
            unused_port2[7:0],
            LED_GREEN[7:0]
            }
        );

    // 7-segment LED port (port 3)
    hexdigit u46 (hexdigit_out[3:0], HEX0);
    hexdigit u47 (hexdigit_out[7:4], HEX1);
    hexdigit u48 (hexdigit_out[11:8], HEX2);
    hexdigit u49 (hexdigit_out[15:12], HEX3);
    out_port u50 (16'd3, clock, clock, clock_valid, reset, out, bus,
              hexdigit_out[15:0]);

    // 7-segment LED port (port 4)
    hexdigit u51 (hexdigit_out1[3:0], HEX4);
    hexdigit u52 (hexdigit_out1[7:4], HEX5);
    hexdigit u53 (hexdigit_out1[11:8], HEX6);
    hexdigit u54 (hexdigit_out1[15:12], HEX7);
    out_port u55 (16'd4, clock, clock, clock_valid, reset, out, bus,
              hexdigit_out1[15:0]);

    // timer port (port 5)
    timer u56 (clock, clock_23_8, clock_valid, reset, timer_out);
    in_port u57 (16'd5, clock, clock_valid, reset, in, bus, timer_out);

    // LCD controller (port 10-14)
    lcd u58 (clock_12_5m, clock_23_8, clock_valid, reset_12_5m, LCD_ON, LCD_BLON,
         LCD_DATA, LCD_EN, LCD_RS, LCD_RW, lcd_command, lcd_response, lcd_x,
         lcd_y, lcd_ascii);
    out_port u59 (16'd10, clock, clock_12_5m, clock_valid, reset, out, bus,
            {
            unused_port10[14:0],
            lcd_command
            }
        );
    in_port u60 (16'd11, clock, clock_valid, reset, in, bus,
            {
            15'h0,
            lcd_response
            }
        );
    out_port u61 (16'd12, clock, clock_12_5m, clock_valid, reset, out, bus,
            {
            unused_port12[11:0],
            lcd_x[3:0]
            }
        );
    out_port u62 (16'd13, clock, clock_12_5m, clock_valid, reset, out, bus,
            {
            unused_port13[14:0],
            lcd_y,
            }
        );
    out_port u63 (16'd14, clock, clock_12_5m, clock_valid, reset, out, bus,
            {
            unused_port14[7:0],
            lcd_ascii[7:0]
            }
        );
    
    // ps/2 controller (port 20-23)
    ps2_keyboard u64 (clock_25m, clock_valid, reset_25m, PS2_CLK, PS2_DAT,
                      ps2_command, ps2_response, ps2_pressed, ps2_ascii);
    out_port u65 (16'd20, clock, clock_25m, clock_valid, reset, out, bus,
            {
            unused_port20[14:0],
            ps2_command
            }
        );
    in_port u66 (16'd21, clock, clock_valid, reset, in, bus,
            {
            15'h0,
            ps2_response
            }
        );
    in_port u67 (16'd22, clock, clock_valid, reset, in, bus,
            {
            15'h0,
            ps2_pressed
            }
        );
    in_port u68 (16'd23, clock, clock_valid, reset, in, bus,
            {
            8'h0,
            ps2_ascii
            }
        );

    // sdram controller (port 30-36)
    sdram u69 (OSC_50, clock_98k, clock_valid, reset_50m, sdram_command,
           sdram_response, sdram_write, sdram_x, sdram_y, sdram_data_write,
           sdram_data_read, DRAM_ADDR, DRAM_BA_0, DRAM_BA_1, DRAM_CS_N,
           DRAM_RAS_N, DRAM_CAS_N, DRAM_WE_N, DRAM_CKE, DRAM_CLK, DRAM_DQ,
           DRAM_LDQM, DRAM_UDQM);
    out_port u70 (16'd30, clock, OSC_50, clock_valid, reset, out, bus, 
            {
            unused_port30[14:0],
            sdram_command
            }
        );
    in_port u71 (16'd31, clock, clock_valid, reset, in, bus,
            {
            15'h0,
            sdram_response
            }
        );
    out_port u72 (16'd32, clock, OSC_50, clock_valid, reset, out, bus, 
            {
            unused_port32[14:0],
            sdram_write
            }
        );
    out_port u73 (16'd33, clock, OSC_50, clock_valid, reset, out, bus,
            {
            unused_port33[4:0],
            sdram_x
            }
        );
    out_port u74 (16'd34, clock, OSC_50, clock_valid, reset, out, bus,
            {
            unused_port34[4:0],
            sdram_y
            }
        );
    out_port u75 (16'd35, clock, OSC_50, clock_valid, reset, out, bus,
             sdram_data_write);
    in_port u76 (16'd36, clock, clock_valid, reset, in, bus, sdram_data_read);

    // I2C configuration
    i2c_config u77 (OSC_50, clock_8_1k, clock_valid, reset_50m, I2C_SDAT,
                I2C_SCLK, i2c_audio_done, i2c_video_done);

    // speaker controller (port 40-42)
    speaker u78 (clock_25m, clock_8_1k, clock_valid, reset_25m, i2c_audio_done,
             speaker_command, speaker_response, speaker_sample, AUD_XCK, AUD_BCLK,
             AUD_DACLRCK, AUD_DACDAT);

    out_port u79 (16'd40, clock, clock_25m, clock_valid, reset, out, bus,
            {
            unused_port40[14:0],
            speaker_command
            }
        );
    in_port u80 (16'd41, clock, clock_valid, reset, in, bus,
            {
            15'h0,
            speaker_response
            }
        );
    out_port u81 (16'd42, clock, clock_25m, clock_valid, reset, out, bus,
            speaker_sample);

    // microphone controller (port 50-52)
    microphone u82 (clock_25m, clock_8_1k, clock_valid, reset_25m,
                i2c_audio_done, microphone_command, microphone_response,
                microphone_sample, AUD_BCLK, AUD_ADCLRCK, AUD_ADCDAT);

    out_port u83 (16'd50, clock, clock_25m, clock_valid, reset, out, bus,
            {
            unused_port50[14:0],
            microphone_command
            }
        );
    in_port u84 (16'd51, clock, clock_valid, reset, in, bus,
            {
            15'h0,
            microphone_response
            }
        );
    in_port u85 (16'd52, clock, clock_valid, reset, in, bus, microphone_sample);

    // VGA controller (ports 60-68)
    vga u86 (OSC_50, clock_100m, clock_valid, reset_50m, reset_100m,
         vga_command, vga_response, vga_write, vga_x1, vga_y1, vga_x2, vga_y2,
         vga_color_write, vga_color_read, camera_to_vga_valid,
         camera_to_vga_ack, camera_to_vga_x, camera_to_vga_y,
         camera_to_vga_color, VGA_R, VGA_G, VGA_B, VGA_CLK, VGA_BLANK,
         VGA_HS, VGA_VS, VGA_SYNC, SRAM_DQ, SRAM_CE_N, SRAM_OE_N,
         SRAM_LB_N, SRAM_UB_N, SRAM_WE_N, SRAM_ADDR);

    out_port u87 (16'd60, clock, OSC_50, clock_valid, reset, out, bus, 
            {
            unused_port60[14:0],
            vga_command
            }
        );
    in_port u88 (16'd61, clock, clock_valid, reset, in, bus,
            {
            15'h0,
            vga_response
            }
        );
    out_port u89 (16'd62, clock, OSC_50, clock_valid, reset, out, bus, 
            {
            unused_port62[14:0],
            vga_write
            }
        );
    out_port u90 (16'd63, clock, OSC_50, clock_valid, reset, out, bus,
            {
            unused_port63[5:0],
            vga_x1
            }
        );
    out_port u91 (16'd64, clock, OSC_50, clock_valid, reset, out, bus,
            {
            unused_port64[6:0],
            vga_y1
            }
        );
    out_port u92 (16'd65, clock, OSC_50, clock_valid, reset, out, bus,
            {
            unused_port65[5:0],
            vga_x2
            }
        );
    out_port u93 (16'd66, clock, OSC_50, clock_valid, reset, out, bus,
            {
            unused_port66[6:0],
            vga_y2
            }
        );
    out_port u94 (16'd67, clock, OSC_50, clock_valid, reset, out, bus,
            {
            unused_port67[7:0],
            vga_color_write
            }
        );
    in_port u95 (16'd68, clock, clock_valid, reset, in, bus,
            {
            8'h0,
            vga_color_read
            }
        );

    // USB mouse controller (ports 70-76)
    usbmouse u96 (OSC_50, clock_valid, reset_50m, OTG_ADDR, OTG_DATA, OTG_CS_N,
              OTG_RD_N, OTG_WR_N, OTG_RST_N, mouse_command, mouse_response,
              mouse_deltax, mouse_deltay, mouse_button1, mouse_button2,
              mouse_button3);

    out_port u97 (16'd70, clock, OSC_50, clock_valid, reset, out, bus,
            {
            unused_port70[14:0],
            mouse_command
            }
        );
    in_port u98 (16'd71, clock, clock_valid, reset, in, bus,
            {
            15'h0,
            mouse_response
            }
        );
    in_port u99 (16'd72, clock, clock_valid, reset, in, bus, mouse_deltax);
    in_port u100 (16'd73, clock, clock_valid, reset, in, bus, mouse_deltay);

    in_port u101 (16'd74, clock, clock_valid, reset, in, bus,
            {
            15'h0,
            mouse_button1
            }
        );
    in_port u102 (16'd75, clock, clock_valid, reset, in, bus,
            {
            15'h0,
            mouse_button2
            }
        );
    in_port u103 (16'd76, clock, clock_valid, reset, in, bus,
            {
            15'h0,
            mouse_button3
            }
        );

    // SD controller (port 80-86)
    sd u104 (OSC_50, clock_valid, reset_50m, SD_CMD, SD_DAT3, SD_DAT,
        SD_CLK, sd_command, sd_response, sd_write, sd_address_low,
        sd_address_high, sd_data_write, sd_data_read);

    out_port u105 (16'd80, clock, OSC_50, clock_valid, reset, out, bus,
            {
            unused_port80[14:0],
            sd_command
            }
        );
    in_port u106 (16'd81, clock, clock_valid, reset, in, bus,
            {
            15'h0,
            sd_response
            }
        );
    out_port u107 (16'd82, clock, OSC_50, clock_valid, reset, out, bus, 
            {
            unused_port82[14:0],
            sd_write
            }
        );
    out_port u108 (16'd83, clock, OSC_50, clock_valid, reset, out, bus,
            {
            unused_port83[0],
            sd_address_low
            }
        );
    out_port u109 (16'd84, clock, OSC_50, clock_valid, reset, out, bus,
            {
            unused_port84[0],
            sd_address_high
            }
        );
    out_port u110 (16'd85, clock, OSC_50, clock_valid, reset, out, bus,
                  sd_data_write);
    in_port u111 (16'd86, clock, clock_valid, reset, in, bus, sd_data_read);

    // serial port receive controller (port 90-92)
    serial_receive u112 (OSC_50, clock_valid, reset_50m, UART_RXD,
                    serial_receive_command, serial_receive_response,
                    serial_receive_data);

    out_port u113 (16'd90, clock, OSC_50, clock_valid, reset, out, bus,
            {
            unused_port90[14:0],
            serial_receive_command
            }
        );
    in_port u114 (16'd91, clock, clock_valid, reset, in, bus,
            {
            15'h0,
            serial_receive_response
            }
        );
    in_port u115 (16'd92, clock, clock_valid, reset, in, bus,
            {
            8'h0,
            serial_receive_data
            }
        );

    // serial port send controller (port 100-102)
    serial_send u116 (OSC_50, clock_valid, reset_50m, UART_TXD,
                 serial_send_command, serial_send_response, serial_send_data);

    out_port u117 (16'd100, clock, OSC_50, clock_valid, reset, out, bus,
            {
            unused_port100[14:0],
            serial_send_command
            }
        );
    in_port u118 (16'd101, clock, clock_valid, reset, in, bus,
            {
            15'h0,
            serial_send_response
            }
        );
    out_port u119 (16'd102, clock, OSC_50, clock_valid, reset, out, bus,
            {
            unused_port102[7:0],
            serial_send_data
            }
        );

    // fft controller (port 110-113, 120-124)
    fft u120 (OSC_50, clock_valid, reset_50m, fft_send_command, fft_send_response,
        fft_send_inverse, fft_send_data_real, fft_send_data_imag,
        fft_send_data_end, fft_receive_command, fft_receive_response,
        fft_receive_data_real, fft_receive_data_imag, fft_receive_data_end);
    out_port u121 (16'd110, clock, OSC_50, clock_valid, reset, out, bus,
            {
            unused_port110[14:0],
            fft_send_command
            }
        );
    in_port u122 (16'd111, clock, clock_valid, reset, in, bus,
            {
            15'h0,
            fft_send_response
            }
        );
    out_port u123 (16'd112, clock, OSC_50, clock_valid, reset, out, bus,
        fft_send_data_real);
    out_port u124 (16'd113, clock, OSC_50, clock_valid, reset, out, bus,
        fft_send_data_imag);
    out_port u125 (16'd114, clock, OSC_50, clock_valid, reset, out, bus,
            {
            unused_port114[14:0],
            fft_send_inverse
            }
        );
    out_port u126 (16'd115, clock, OSC_50, clock_valid, reset, out, bus,
            {
            unused_port115[14:0],
            fft_send_data_end
            }
        );
    out_port u127 (16'd120, clock, OSC_50, clock_valid, reset, out, bus,
            {
            unused_port120[14:0],
            fft_receive_command
            }
        );
    in_port u128 (16'd121, clock, clock_valid, reset, in, bus,
            {
            15'h0,
            fft_receive_response
            }
        );
    in_port u129 (16'd122, clock, clock_valid, reset, in, bus,
        fft_receive_data_real);
    in_port u130 (16'd123, clock, clock_valid, reset, in, bus,
        fft_receive_data_imag);

    // camera controller (ports 130-133)
    camera u131 (clock_100m, clock_valid, reset_100m, i2c_video_done, OSC_27,
                TD_RESET, TD_CLK, TD_DATA, camera_to_vga_valid, camera_to_vga_ack,
                camera_to_vga_x, camera_to_vga_y, camera_to_vga_color,
                camera_command, camera_response, camera_x, camera_y, camera_scale,
                camera_flip);
    out_port u132 (16'd130, clock, clock_100m, clock_valid, reset, out, bus, 
            {
            unused_port130[14:0],
            camera_command
            }
        );
    in_port u133 (16'd131, clock, clock_valid, reset, in, bus,
            {
            15'h0,
            camera_response
            }
        );

    out_port u134 (16'd132, clock, clock_100m, clock_valid, reset, out, bus,
            {
            unused_port132[5:0],
            camera_x
            }
        );
    out_port u135 (16'd133, clock, clock_100m, clock_valid, reset, out, bus,
            {
            unused_port133[6:0],
            camera_y
            }
        );
    out_port u136 (16'd134, clock, clock_100m, clock_valid, reset, out, bus,
            {
            unused_port134[13:0],
            camera_scale
            }
        );
    out_port u137 (16'd135, clock, clock_100m, clock_valid, reset, out, bus,
            {
            unused_port135[14:0],
            camera_flip
            }
        );

    control u138 (clock, clock_valid, reset, opcode_out, equal_out, lt_out,
        pc_write, pc_drive, plus1_drive, op1_write, op2_write, add_drive,
        sub_drive, mult_drive, div_drive, bit_and_drive, bit_or_drive,
        bit_not_drive, sl_drive, sr_drive, opcode_write, addr0_write,
        addr0_drive, addr1_write, addr1_drive, addr2_write, addr2_drive,
        address_write, memory_write, memory_drive, in, out);

endmodule
