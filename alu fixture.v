`timescale 1 ns / 1 ps
`include "alu.v";
module alu_fixture;

reg signed [15:0] A,B;
reg [3:0] ctrl;
wire  signed [32:0] result;

initial $monitor($time, " A = %h, B = %h, ctrl = %b, result = %h", A, B, ctrl, result);

alu uut(A, B, ctrl, result);

initial 
begin
	A = 16'h0001; B = 16'h0002; ctrl = 0; #10; 
	A = 16'hA120; B = 16'h0774; ctrl = 1; #10;
  A = 16'hAB01; B = 16'h0A01; ctrl = 2; #10;
  A = 16'h0A00; B = 16'h0003; ctrl = 3; #10;
  A = 16'hA126; B = 16'h0245; ctrl = 3; #10;
  A = 16'h54AB; B = 16'h1234; ctrl = 4; #10;
  A = 16'hABCD; B = 16'hFFAA; ctrl = 5; #10;
  A = 16'hABCD; B = 16'h00AA; ctrl = 6; #10;
	#10; $finish;
end
endmodule