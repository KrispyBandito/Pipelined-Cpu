`timescale 1 ns / 1 ps
`include "signExtd8.v";
module signExtd8_fixture;

reg [3:0] dataIn;
wire [7:0] dataOut;


initial $monitor($time, " dataIn = %h, dataOut = %h", dataIn, dataOut);

signExtd8 uut(dataIn, dataOut);

initial
begin
        dataIn = 4'h0; #10;
        dataIn = 4'h1; #10;
        dataIn = 4'hE; #10;
        dataIn = 4'h3; #10;
        dataIn = 4'h8; #10;
        dataIn = 4'h7; #10;
        dataIn = 4'hA; #10;
        dataIn = 4'hF; #10;
        #10; $finish;
end
endmodule