`timescale 1ns / 1ps
`include "shiftleft.v"

module shiftleft_fixture;

reg [16:0] dataIn;
wire[16:0] dataOut;
    
initial 
	$monitor($time, " dataIn = %h, dataOut = %h", dataIn, dataOut);
    
shiftleft uut(dataIn, dataOut);

initial begin 
    dataIn = 16'h00A1;
    
    #10 dataIn = 16'h002B;
    
    #10 $finish;
end

endmodule
