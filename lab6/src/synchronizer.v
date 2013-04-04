/*
 * Copyright (c) 2006, Peter M. Chen.  All rights reserved.  This software is
 * supplied as is without expressed or implied warranties of any kind.
 */

/*
 * Synchronize to get rid of metastability.
 */
module synchronizer(
    input wire clock,
    input wire in,
    output reg out);

    reg sync_reg_out;

    always @(posedge clock) begin
        sync_reg_out <= in;
	out <= sync_reg_out;
    end

endmodule
