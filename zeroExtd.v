`timescale 1ns / 1ps

module zeroExtd(input [7:0] dataIn, output reg [15:0] dataOut);

always@(*)
begin
  dataOut = {8'h00, dataIn};
end  
endmodule