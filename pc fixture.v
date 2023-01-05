`timescale 1 ns / 1 ps
`include "pc.v";
module pc_fixture;

reg [15:0] pc;
reg clk, wr_enable;
wire [15:0] pcNew;

initial $monitor($time, " pc = %h, wr_enable = %h, pcNew = %h", pc, wr_enable, pcNew);

pc uut(pc, clk, wr_enable, pcNew);

initial 
begin
    clk = 0;
    #5; clk = ~clk;
end

initial
begin    
        
        pc = 16'h1100; wr_enable = 1; #20;
        pc = 16'h1206; wr_enable = 1; #20;
        pc = 16'h16A0; wr_enable = 0; #20;
        pc = 16'h7020; wr_enable = 0; #20;
        pc = 16'h9999; wr_enable = 1; #20;
        pc = 16'h4545; wr_enable = 0; #20;
        
        #10; $finish;
end
endmodule