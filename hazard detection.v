`timescale 1 ns / 1 ps
module hazardDetection(input memRead,
                        input [3:0] r2IDEX, r1IFID, r2IFID,
                        output reg wr_enable);

always@(*)
begin
        if(memRead && ((r1IFID == r2IDEX) || (r2IFID == r2IDEX)))        //if LW detected then stall 1 cycle
                wr_enable = 0;
        else
                wr_enable = 1;
end
endmodule
