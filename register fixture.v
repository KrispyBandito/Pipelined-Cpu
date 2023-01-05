`timescale 1ns / 1ps
`include "register.v"

module register_fixture;
reg clk;
reg rst;
	
reg regWrite;
reg[3:0] WA;
reg[15:0] WD1, WD0;
	
reg[3:0] RR1, RR2;
wire[15:0] RD0, RD1, RD2;

initial 
    $monitor($time, " clk = %h, rst = %h, regWrite = %h, WA = %h, WD1 = %h, WD0 = %h, RR1 = %h, RR2 = %h, RD0 = %h, RD1 = %h, RD2 = %h", 
	         clk, rst, regWrite, WA, WD1, WD0, RR1, RR2, RD0, RD1, RD2);

register uut(clk, rst, regWrite, WA, WD1, WD0, RR1, RR2, RD0, RD1, RD2);

initial begin
    clk <= 0;
    #10 clk <= ~clk;
end

initial begin 
    rst <= 1;  
    #10 rst<=0;
     
    //Writing into register location R3
    #10 rst <= 0; regWrite <= 1; WA <= 4'b0011; RR1 <= 4'b0011; RR2 <= 4'b1000; WD1 <= 16'b0101; WD0 <= 16'b1000;
    
    //Writing into register location R4
    #10 rst <= 0; regWrite <= 1; WA <= 4'b0100; RR1 <= 4'b1101; RR2 <= 4'b0010; WD1 <= 16'b0101; WD0 <= 16'b1000;
    
    //Writing into register location R10
    #10 rst <= 0; regWrite <= 1; WA <= 4'b1010; RR1 <= 4'b1001; RR2 <= 4'b0110; WD1 <= 16'b0101; WD0 <= 16'b1000;
    
    //No Reg Write for Sw and Sb, Branch test
    #10 rst <= 0; regWrite <= 0; WA <= 4'bxxxx; RR1 <= 4'b0011; RR2 <= 4'b1000; WD1 <= 16'bxxxx; WD0 <= 16'bxxxx;
    
    #10; $finish;
end
endmodule
