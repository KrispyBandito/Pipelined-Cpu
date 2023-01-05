`timescale 1ns / 1ps

module instructionMemory(
    input clk, input [15:0] pc, 
	output reg [15:0] instruction 
	);
	reg [15:0] instrMemory [0:1024];
							
initial 
begin
	instrMemory[00] = 16'hFE21;		//ADD
	instrMemory[02] = 16'hFB22;		//SUB
	instrMemory[04] = 16'h2388;		//ORI
	instrMemory[06] = 16'h149A;		//ANDI
	instrMemory[08] = 16'hF564;		//MULTI
	instrMemory[10] = 16'hF168;		//DIV
	instrMemory[12] = 16'hD59A;		//SW
	instrMemory[14] = 16'h2802;		//ORI
	instrMemory[16] = 16'hCE9A;		//LW
	instrMemory[18] = 16'hF002;		//SUB
	instrMemory[20] = 16'hF121;		//ADD
	instrMemory[22] = 16'hF122;		//SUB
	instrMemory[24] = 16'h1802;		//ANDI
	instrMemory[26] = 16'hA694;		//LBU
	instrMemory[28] = 16'hB696;		//SB
	instrMemory[30] = 16'hC696;		//LW
	instrMemory[32] = 16'hF7D2;		//SUB
	instrMemory[34] = 16'h6704;		//BEQ
	instrMemory[36] = 16'hFB11;		//ADD
	instrMemory[38] = 16'h5705;		//BLT
	instrMemory[40] = 16'hFB21;		//ADD
	instrMemory[42] = 16'h4702;		//BGT
	instrMemory[44] = 16'hF111;		//ADD
	instrMemory[46] = 16'hF111;		//ADD
	instrMemory[48] = 16'hC890;		//LW
	instrMemory[50] = 16'hF881;		//ADD
	instrMemory[52] = 16'hD892;		//SW
	instrMemory[54] = 16'hCA92;		//LW
	instrMemory[56] = 16'hFCC1;		//ADD
	instrMemory[58] = 16'hFDD2;		//SUB
	instrMemory[60] = 16'hFCD1;		//ADD
	instrMemory[62] = 16'h0000;		//HALT
end

always@(*)	
begin
	instruction <= instrMemory[pc];
end
endmodule
