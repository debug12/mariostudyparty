/*
 * Copyright (c) 2006, Peter M. Chen.  All rights reserved.  This software is
 * supplied as is without expressed or implied warranties of any kind.
 */
module bit_not(
    input wire [15:0] in1,
    output reg [15:0] out);

    always @* begin
        out = ~in1;
    end

endmodule
