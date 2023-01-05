`timescale 1 ns / 1 ps
module dataMemory(input wr_enableBW, memRead, memWrite, clk, rst,
                    input [7:0] writeByte,
                    input [15:0] writeWord, address,
                    output reg [15:0] readData);
                    
reg [15:0] dataMem [0:7];

initial
begin
    dataMem[16'h0000] = 16'h3856;
    dataMem[16'h0001] = 16'h0000;
    dataMem[16'h0002] = 16'h0000;
    dataMem[16'h0003] = 16'h0000;
    dataMem[16'h0004] = 16'h4312;
    dataMem[16'h0005] = 16'h0000;
    dataMem[16'h0006] = 16'hBEDE;
    dataMem[16'h0007] = 16'h0000;
    dataMem[16'h0008] = 16'hADEF;
    dataMem[16'h0009] = 16'h0000;
    dataMem[16'h000A] = 16'h0000;
    dataMem[16'h000B] = 16'h0000;
    dataMem[16'h000C] = 16'h3856;
    dataMem[16'h000D] = 16'h0000;
    dataMem[16'h000E] = 16'h0000;
    dataMem[16'h000F] = 16'h0000;
    dataMem[16'h0010] = 16'h0000;
    dataMem[16'h0011] = 16'h0000;
    dataMem[16'h0012] = 16'h0000;
end

always@(*)
begin
    if(!rst)
    begin
      dataMem[16'h0000] = 16'h3856;
      dataMem[16'h0001] = 16'h0000;
      dataMem[16'h0002] = 16'h0000;
      dataMem[16'h0003] = 16'h0000;
      dataMem[16'h0004] = 16'h4312;
      dataMem[16'h0005] = 16'h0000;
      dataMem[16'h0006] = 16'hBEDE;
      dataMem[16'h0007] = 16'h0000;
      dataMem[16'h0008] = 16'hADEF;
      dataMem[16'h0009] = 16'h0000;
      dataMem[16'h000A] = 16'h0000;
      dataMem[16'h000B] = 16'h0000;
      dataMem[16'h000C] = 16'h3856;
      dataMem[16'h000D] = 16'h0000;
      dataMem[16'h000E] = 16'h0000;
      dataMem[16'h000F] = 16'h0000;
      dataMem[16'h0010] = 16'h0000;
      dataMem[16'h0011] = 16'h0000;
      dataMem[16'h0012] = 16'h0000;
    end
    else if(memRead)                                //if lw then pull from dataMem
        readData = dataMem[address];
    else if(memWrite)
    begin
        if(wr_enableBW)                        //if sw then write word into memory
            dataMem[address] = writeWord;
        else
            dataMem[address] = writeByte;     //if sb then write byte into memory
    end
end
endmodule