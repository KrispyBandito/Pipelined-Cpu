`timescale 1 ns / 1 ps
`include "aluControl.v";
module aluControl_fixture;

reg [3:0] functionCode; 
reg [1:0] ALUop;
wire [3:0] ALUctrl;
                                

initial $monitor($time, " functionCode = %b, ALUop = %b, ALUctrl = %b", functionCode, ALUop, ALUctrl);

aluControl uut(functionCode, ALUop, ALUctrl);

initial
begin    
        functionCode = 4'b0001; ALUop = 2'b00; #20;      //alu ctrl = 0
        functionCode = 4'b0010; ALUop = 2'b00; #20;      //alu ctrl = 1
        functionCode = 4'b0100; ALUop = 2'b00; #20;      //alu ctrl = 2
        functionCode = 4'b1000; ALUop = 2'b00; #20;      //alu ctrl = 3
        functionCode = 4'b1010; ALUop = 2'b10; #20;      //alu ctrl = 4
        functionCode = 4'b1111; ALUop = 2'b11; #20;      //alu ctrl = 0
        
        #10; $finish;
end
endmodule