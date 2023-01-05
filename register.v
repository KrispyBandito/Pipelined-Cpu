`timescale 1ns / 1ps

module #(parameter n = 16) register(
	input clk,
	input rst,
	
	input regWrite,
	input[3:0] WA,
	input[15:0] WD1, WD0,
	
	input[3:0] RR1, RR2,
	output reg[15:0] RD0, RD1, RD2
	);
	
    reg[15:0] regFile [0:15];
    
initial begin
	regFile[0] = 16'h0000;		//R0=0000
	regFile[1] = 16'h7B18;		//R1=7B18
	regFile[2] = 16'h245B;		//R2=245B
	regFile[3] = 16'hFF0F;		//R3=FF0F
	regFile[4] = 16'hF0FF;		//R4=F0FF
	regFile[5] = 16'h0051;		//R5=0051
	regFile[6] = 16'h6666;		//R6=6666
	regFile[7] = 16'h00FF;		//R7=00FF
	regFile[8] = 16'hFF88;		//R8=FF88
	regFile[9] = 16'h0000;		//R9=0000
	regFile[10] = 16'h0000;	//R10=0000
	regFile[11] = 16'h3099;	//R11=3099
	regFile[12] = 16'hCCCC;	//R12=CCCC
	regFile[13] = 16'h0002;	//R13=0002
	regFile[14] = 16'h0011;	//R14=0011
	regFile[15] = 16'h0000;	//R15=0000
end
	
	
	always@(*)
	begin
		if (!rst)                        		//if reset then all register values to initial
		begin
			regFile[0] = 16'h0000;		//R0=0000
			regFile[1] = 16'h7B18;		//R1=7B18
			regFile[2] = 16'h245B;		//R2=245B
			regFile[3] = 16'hFF0F;		//R3=FF0F
			regFile[4] = 16'hF0FF;		//R4=F0FF
			regFile[5] = 16'h0051;		//R5=0051
			regFile[6] = 16'h6666;		//R6=6666
			regFile[7] = 16'h00FF;		//R7=00FF
			regFile[8] = 16'hFF88;		//R8=FF88
			regFile[9] = 16'h0000;		//R9=0000
			regFile[10] = 16'h0000;	//R10=0000
			regFile[11] = 16'h3099;	//R11=3099
			regFile[12] = 16'hCCCC;	//R12=CCCC
			regFile[13] = 16'h0002;	//R13=0002
			regFile[14] = 16'h0011;	//R14=0011
			regFile[15] = 16'h0000;	//R15=0000
		end
		else
		begin
			if (regWrite)
			begin
				regFile[WA] <= WD1;
				regFile[0] <= WD0;
			end
		end
	end
	
	always@(*)
	begin
		RD1 = regFile[RR1];
		RD2 = regFile[RR2];
		RD0 = 1'b0;
	end
endmodule


