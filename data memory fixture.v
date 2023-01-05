`timescale 1 ns / 1 ps
`include "dataMemory.v";
module dataMemory_fixture;

reg wr_enableBW, memRead, memWrite, clk, rst;
reg [7:0] writeByte;
reg [15:0] writeWord, address;
wire [15:0] readData;


initial $monitor($time, " wr_enableBW = %h, memRead = %h, memWrite = %h, writeByte = %h,  writeWord = %h, address = %h, readData = %h", wr_enableBW, memRead, memWrite, writeByte, writeWord, address, readData);

dataMemory uut(wr_enableBW, memRead, memWrite, clk, rst, writeByte, writeWord, address, readData);

initial 
begin
    clk = 0;
    #5; clk = ~clk;
end

initial
begin    
        wr_enableBW = 0;  
        memRead = 1; 
        memWrite = 0;  
        rst = 0;
        writeByte = 8'h10; 
        writeWord = 16'hAB10; 
        address = 16'h0000; 
        #20;
        wr_enableBW = 1;  
        memRead = 0; 
        memWrite = 1;  
        rst = 0;
        writeByte = 8'h10; 
        writeWord = 16'hAB10; 
        address = 16'h0000; 
        #20;
        wr_enableBW = 0;  
        memRead = 1; 
        memWrite = 0;  
        rst = 1;
        writeByte = 8'h10; 
        writeWord = 16'hAB10; 
        address = 16'h0000; 
        #20;
        wr_enableBW = 0;  
        memRead = 1; 
        memWrite = 0;  
        rst = 1;
        writeByte = 8'h10; 
        writeWord = 16'hCC10; 
        address = 16'h0000; 
        #20;
        wr_enableBW = 0;  
        memRead = 1; 
        memWrite = 0;  
        rst = 1;
        writeByte = 8'h10; 
        writeWord = 16'hAB10; 
        address = 16'h0000; 
        #20;
        wr_enableBW = 0;  
        memRead = 1; 
        memWrite = 0;  
        rst = 0;
        writeByte = 8'h10; 
        writeWord = 16'hAB10; 
        address = 16'h0000; 
        #20;
        wr_enableBW = 0;  
        memRead = 1; 
        memWrite = 0;  
        rst = 1;
        writeByte = 8'h10; 
        writeWord = 16'hAB10; 
        address = 16'h0000; 
        #10; $finish;
end
endmodule