`timescale 1ns / 1ps

module signExtd16(input [7:0] dataIn, output reg [15:0] dataOut);

always@(*)
begin
    dataOut[15:0] = {{8{dataIn[7]}}, dataIn[7:0]};
end
endmodule