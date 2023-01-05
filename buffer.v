`timescale 1 ns / 1 ps
module buffer #(parameter N = 16) ( input clk, pause, rst, bubble,
                                input [N-1:0] buffIn,
                                output reg [N-1:0] buffOut);
integer i;
reg nextBubble;

always@(posedge clk, negedge rst)
begin
        if(rst == 0 || nextBubble == 0)                         //if reset or bubble insert
        begin
                nextBubble <= 1;
                for(i = 0; i < N; i = i + 1)                    //set all register contents to 0
                begin
                        buffOut[i] <= 0;
                end
        end
        else if(rst == 1 && pause == 1)                         //if not reset and pause
                buffOut <= buffOut;                             //dont change buffOut
        else
                buffOut <= buffIn;                              //else buff updates to input
        if(bubble == 0)                                         //if bubble needed then
                nextBubble <= 0;                                //activate next bubble
end
endmodule
