`timescale 1 ns / 1 ps
`include "signExtd16.v";
module signExtd16_fixture;

reg [7:0] dataIn;
wire [15:0] dataOut;

initial $monitor($time, " dataIn = %h, dataOut = %h", dataIn, dataOut);

signExtd16 uut(dataIn, dataOut);

initial
begin
        dataIn = 8'h00; #10;
        dataIn = 8'h01; #10;
        dataIn = 8'h12; #10;
        dataIn = 8'h43; #10;
        dataIn = 8'h11; #10;
        dataIn = 8'h17; #10;
        dataIn = 8'hA9; #10;
        dataIn = 8'h8F; #10;
        #10; $finish;
end
endmodule