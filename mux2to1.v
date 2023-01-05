`timescale 1 ns / 1 ps
module mux2to1(input [15:0] d0, d1,
		input sel,
		output reg [15:0]  y);

always@(d0 or d1 or sel)
begin
	if(sel == 0)
		y <= d0;
	else
		y <= d1;
end
endmodule