`timescale 1 ns / 1 ps
`include "zeroExtd.v";
module zeroExtd_fixture;

reg [7:0] dataIn;
wire [15:0] dataOut;


initial $monitor($time, " dataIn = %h, dataOut = %h", dataIn, dataOut);

zeroExtd uut(dataIn, dataOut);

initial
begin
        dataIn = 8'h00; #10;
        dataIn = 8'h21; #10;
        dataIn = 8'hDE; #10;
        dataIn = 8'h73; #10;
        dataIn = 8'h08; #10;
        dataIn = 8'h47; #10;
        dataIn = 8'hBA; #10;
        dataIn = 8'hFF; #10;
        #10; $finish;
end
endmodule