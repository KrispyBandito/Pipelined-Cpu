`timescale 1ns / 1ps

module shiftleft(
    input[16:0] dataIn,
    output reg[16:0] dataOut
    );
    
    always@(*)
    begin 
        dataOut = dataIn << 1;
    end
endmodule