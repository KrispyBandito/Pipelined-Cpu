`timescale 1ns / 1ps
include "hazardDetection.v";

module hazardDetection_fixture;
    reg memRead;
    reg [3:0] r2IDEX, r1IFID, r2IFID;
    wire wr_enable;
    
    initial $monitor($time, " memRead = %h, r2IDEX = %h, r1IFID = %h; r2IFID = %h, wr_enable = %h", memRead, r2IDEX, r1IFID, r2IFID, wr_enable);
        
    hazardDetection uut(memRead, r2IDEX, r1IFID, r2IFID, wr_enable);
    
    initial begin
        memRead = 0; r2IDEX = 0; r1IFID = 0; r2IFID = 0; #10;
        
        memRead = 1; r2IDEX = 0; r1IFID = 0; r2IFID = 1; #10;
        
        memRead = 0; r2IDEX = 0; r1IFID = 1; r2IFID = 0; #10;
        
        memRead = 1; r2IDEX = 0; r1IFID = 1; r2IFID = 1; #10;
        
        memRead = 0; r2IDEX = 1; r1IFID = 0; r2IFID = 0; #10;
        
        memRead = 1; r2IDEX = 1; r1IFID = 0; r2IFID = 1; #10;
        
        memRead = 0; r2IDEX = 1; r1IFID = 1; r2IFID = 0; #10;
        
        #10 $finish;
    end
endmodule