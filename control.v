`timescale 1 ns / 1 ps

module control(input[3:0] Opcode, 
               input branchTake,
               output reg[1:0] PCsrc,
               output reg flush,
               output reg[10:0] controlLine
               );
    reg[1:0] AluOP, MemtoReg, AluSrc;
    reg RegWrite, RegDst, MemWrite, MemRead, weWb;
    
	always @(*)
	begin
			
		case(Opcode)
			0: 
			begin //Halt
				AluOP = 2'bxx;
				MemtoReg= 2'bxx;
				AluSrc= 2'bxx;
				PCsrc= 2'bxx;
				RegWrite= 1'bx;
				RegDst= 1'bx;
				MemWrite= 1'bx;
				MemRead= 1'bx;
				weWb= 1'bx;
				flush= 1'b0;
				
				            // [10]     [9:8]   [7:6]   [5]       [4]     [3]     [2]     [1:0] 
				controlLine = {RegDst, AluSrc, AluOP, MemWrite, MemRead, weWb, RegWrite, MemtoReg}; //Orginized Way
			end
			
			1: //Andi
			begin
				AluOP =2'b10;
				MemtoReg=2'b10;
				AluSrc=2'b01;
				PCsrc=2'b01;
				RegWrite=1'b1;
				RegDst=1'b1;
				MemWrite=1'b0;
				MemRead=1'b0;
				weWb= 1'bx;
				flush= 1'b0;
				
				controlLine = {RegDst, AluSrc, AluOP, MemWrite, MemRead, weWb, RegWrite, MemtoReg}; //Orginized Way
			end
			
			2: 
			begin //Ori
				AluOP =2'b10;
				MemtoReg=2'b10;
				AluSrc=2'b01;
				PCsrc=2'b01;
				RegWrite=1'b1;
				RegDst=1'b1;
				MemWrite=1'b0;
				MemRead=1'b0;
				weWb= 1'bx;
				flush= 1'b0;
				
				controlLine = {RegDst, AluSrc, AluOP, MemWrite, MemRead, weWb, RegWrite, MemtoReg}; //Orginized Way
			end
			
			4: 
			begin //Branch Greater
				AluOP =2'bxx;
				MemtoReg=2'bxx;
				AluSrc=2'bxx;
				PCsrc= branchTake;
				RegWrite=1'b0;
				RegDst=1'bx;
				MemWrite=1'bx;
				MemRead=1'bx;
				flush= 1'b1;
				
				controlLine = {RegDst, AluSrc, AluOP, MemWrite, MemRead, weWb, RegWrite, MemtoReg}; //Orginized Way
			end
			
			5: 
			begin //Branch Lesser
				AluOP = 2'bxx;
				MemtoReg=2'bxx;
				AluSrc=2'bxx;
				PCsrc= branchTake;
				RegWrite=1'b0;
				RegDst=1'bx;
				MemWrite=1'bx;
				MemRead=1'bx;
				weWb= 1'bx;
				flush= 1'b1;
				
				controlLine = {RegDst, AluSrc, AluOP, MemWrite, MemRead, weWb, RegWrite, MemtoReg}; //Orginized Way
			end
			
			6: 
			begin //Branch Equal
				AluOP =2'bxx;
				MemtoReg=2'bxx;
				AluSrc=2'bxx;
				PCsrc= branchTake;
				RegWrite=1'b0;
				RegDst=1'bx;
				MemWrite=1'bx;
				MemRead=1'bx;
				weWb= 1'bx;
				
				controlLine = {RegDst, AluSrc, AluOP, MemWrite, MemRead, weWb, RegWrite, MemtoReg}; //Orginized Way
			end
			
			7: 
			begin //Jump
				AluOP =2'bxx;
				MemtoReg=2'bxx;
				AluSrc=2'bxx;
				PCsrc=2'b10;
				RegWrite=1'bx;
				RegDst=1'bx;
				MemWrite=1'bx;
				MemRead=1'bx;
				weWb= 1'bx;
				flush= 1'b0;
				
				controlLine = {RegDst, AluSrc, AluOP, MemWrite, MemRead, weWb, RegWrite, MemtoReg}; //Orginized Way
			end
			
			10: 
			begin //LBU
				AluOP =2'b00;
				MemtoReg=2'b01;
				AluSrc=2'b10;
				PCsrc=2'b01;
				RegWrite=1'b1;
				RegDst=1'b0;
				MemWrite=1'b0;
				MemRead=1'b1;
				weWb= 1'bx;
				flush= 1'b0;
				
				controlLine = {RegDst, AluSrc, AluOP, MemWrite, MemRead, weWb, RegWrite, MemtoReg}; //Orginized Way
			end
			
			11: 
			begin //SB
				AluOP =2'b00;
				MemtoReg=2'bxx;
				AluSrc=2'b10;
				PCsrc=2'b01;
				RegWrite=1'b0;
				RegDst=1'bx;
				MemWrite=1'b1;
				MemRead=1'b0;
				weWb= 1'b0;
				flush= 1'b0;
				
				controlLine = {RegDst, AluSrc, AluOP, MemWrite, MemRead, weWb, RegWrite, MemtoReg}; //Orginized Way
			end
			
			12: 
			begin //LW
				AluOP =2'b00;
				MemtoReg=2'b00;
				AluSrc=2'b10;
				PCsrc=2'b01;
				RegWrite=1'b1;
				RegDst=1'b0;
				MemWrite=1'b0;
				MemRead=1'b1;
				weWb= 1'bx;
				flush= 1'b0;
				
				controlLine = {RegDst, AluSrc, AluOP, MemWrite, MemRead, weWb, RegWrite, MemtoReg}; //Orginized Way
			end
			
			13: 
			begin //SW
				AluOP =2'b00;
				MemtoReg=2'bxx;
				AluSrc=2'b10;
				PCsrc=2'b01;
				RegWrite=1'b0;
				RegDst=1'bx;
				MemWrite=1'b1;
				MemRead=1'b0;
				weWb= 1'b1;
				flush= 1'b0;
				
				controlLine = {RegDst, AluSrc, AluOP, MemWrite, MemRead, weWb, RegWrite, MemtoReg}; //Orginized Way
			end
			
			15:
			begin //Type A: Add, Sub, Mult, Div
				AluOP =2'b00;
				MemtoReg=2'b10;
				AluSrc=2'b00;
				PCsrc=2'b01;
				RegWrite=1'b1;
				RegDst=1'b1;
				MemWrite=1'b0;
				MemRead=1'b0;
				weWb= 1'bx;
				flush= 1'b0;
				
				controlLine = {RegDst, AluSrc, AluOP, MemWrite, MemRead, weWb, RegWrite, MemtoReg}; //Orginized Way
			end
		endcase
	end
endmodule