`timescale 1ns / 1ps

module mux32bit3to1 (input [31:0] d0, d1, d2,
		input [1:0] sel,
		output reg [31:0] y);

always@(d0 or d1 or d2)
begin
	if(sel == 2'b00)
		y <= d0;
	else if(sel == 2'b01)
		y <= d1;
	else
		y <= d2;
end
endmodule