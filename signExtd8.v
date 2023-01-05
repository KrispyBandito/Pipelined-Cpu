`timescale 1ns / 1ps

module signExtd8(input [3:0] dataIn, output reg [7:0] dataOut);

always@(*)
begin
   dataOut = {{4{dataIn[3]}}, dataIn[3:0]};
   
end 
endmodule