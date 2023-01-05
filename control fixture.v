`timescale 1ns / 1ps
//`include "control.v"

module control_fixture;
reg[3:0] Opcode;
reg branchTake; 
wire[1:0] PCsrc; 
wire flush; 
wire [10:0] controlLine;

initial         
	$monitor($time, " Opcode = %h, branchtake = %h, PCsrc = %h, flush = %h, controlLine = %b", 
	Opcode, branchTake, PCsrc,  flush, controlLine);


control uut(Opcode, branchTake, PCsrc, flush, controlLine);

initial begin 

    //halt
    Opcode = 4'h0; branchTake = 1'bx;
    
    //Andi
    #10
    Opcode =4'h1; branchTake =1'bx;
    
    //Ori
    #10
    Opcode =4'h2; branchTake =1'bx;
    
    //Branch Greater
    #10
    Opcode =4'h4; branchTake =1'b0;
    
    //Branch Lesser
    #10
    Opcode =4'h5; branchTake =1'b0;
    
    //Branch Equal
    #10
    Opcode =4'h6; branchTake =1'b0;
    
    //Jump
    #10
    Opcode =4'h7; branchTake =1'bx;
    
    //LBU
    #10
    Opcode =4'hA; branchTake =1'bx;
    
    //Sb
    #10
    Opcode =4'hB; branchTake =1'bx;
    
    //LW
    #10
    Opcode =4'hC; branchTake =1'bx;
    
    //SW
    #10
    Opcode =4'hD; branchTake =1'bx;
    
    //Type A
    #10
    Opcode =4'hF; branchTake =1'bx;
    
    #10 $finish;
    end
endmodule
