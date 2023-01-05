`timescale 1 ns / 1 ps
module pc(input [15:0] pc,
        input clk, wr_enable,
        output reg [15:0] pcNew);
always@(*)
begin
        if(wr_enable == 1)                        //if wr_enable 1 then write pc 
                pcNew = pc;
        else;                                     //else do nothing
end
endmodule