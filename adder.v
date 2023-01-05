`timescale 1 ns / 1 ps
module adder(input [15:0] a, b,
                output [15:0] result);

always@(*)
begin
        result = a + b;
end
endmodule
        