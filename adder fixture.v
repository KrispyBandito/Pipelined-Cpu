`timescale 1 ns / 1 ps
`include "adder.v";
module adder_fixture;

reg [15:0] a, b;
wire [15:0] result;

initial $monitor($time, " a = %h, b = %h, result = %h", a, b, result);

adder uut(a, b, result);

initial
begin    
        
        a = 16'h0022; b = 16'h10A4; #20;
        a = 16'h0020; b = 16'h0101; #20;
        a = 16'hEE00; b = 16'h00FF; #20;
        a = 16'h1100; b = 16'h1001; #20;
        
        #10; $finish;
end
endmodule