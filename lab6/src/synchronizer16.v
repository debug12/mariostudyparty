/*
 * Copyright (c) 2006, Peter M. Chen.  All rights reserved.  This software is
 * supplied as is without expressed or implied warranties of any kind.
 */

/*
 * Synchronize to get rid of metastability.
 */
module synchronizer16(
    input wire clock,
    input wire [15:0] in,
    output reg [15:0] out);

    reg [15:0] sync_reg_out;

    always @(posedge clock) begin
        sync_reg_out <= in;
	out <= sync_reg_out;
    end

endmodule
