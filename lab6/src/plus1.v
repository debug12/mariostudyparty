/*
 * Copyright (c) 2006, Peter M. Chen.  All rights reserved.  This software is
 * supplied as is without expressed or implied warranties of any kind.
 */
module plus1(
    input wire [15:0] in,
    output reg [15:0] out);

    always @* begin
        out = in + 16'h1;
    end

endmodule
