`timescale 1 ns / 1 ps
`include "instructionMemory.v";
module instructionMemory_fixture;

reg clk;
reg [15:0] pc;
wire [15:0] instruction;


initial $monitor($time, " pc = %h, instruction = %h", pc, instruction);

instructionMemory uut(clk, pc, instruction);

initial 
    begin
        clk = 0;
        #10 clk = ~clk;
    end

initial
begin
        pc = 2;    #10;      
        pc = 4;    #10;
        pc = 26;    #10; 
        pc = 44;    #10;
        pc = 56;    #10;
        pc = 12;    #10;
        pc = 62;    #10;
        pc = 36;    #10;
        #10; $finish;
end
endmodule
