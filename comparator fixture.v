`timescale 1 ns / 1 ps
`include "comparator.v";
module comparator_fixture;

reg [15:0] r0, r1;
reg [3:0] opCode;
wire [1:0] branch;


initial $monitor($time, " r0 = %h, r1 = %h, opCode = %h, branch = %h", r0, r1, opCode, branch);

comparator uut(r0, r1, opCode, branch);

initial
begin
        r0 = 16'h0004; r1 = 16'h00FF; opCode = 4'b0110;  #10;      //beq
        r0 = 16'h0005; r1 = 16'h00FF; opCode = 4'b0101;  #10;      //blt
        r0 = 16'h0002; r1 = 16'h00FF; opCode = 4'b0100;  #10;      //bgt
        r0 = 16'h0000; r1 = 16'h0ADE; opCode = 4'b1111;  #10;
        r0 = 16'hA006; r1 = 16'hF211; opCode = 4'b0100;  #10;
        r0 = 16'hFF65; r1 = 16'h0213; opCode = 4'b0101;  #10;
        r0 = 16'h0426; r1 = 16'h0033; opCode = 4'b0100;  #10;
        r0 = 16'h0ADE; r1 = 16'h0ADE; opCode = 4'b0110;  #10;
        #10; $finish;
end
endmodule