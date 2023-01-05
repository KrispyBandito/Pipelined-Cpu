`timescale 1 ns / 1 ps
`include "mux2to1.v";
module mux2to1_fixture;

reg [15:0] d0, d1;
reg sel;
wire [15:0] y;

initial $monitor($time, " d0 = %h, d1 = %h, sel = %h, y = %h", d0, d1, sel, y);

mux2to1 uut(d0, d1, sel, y);

initial
begin    
        
        d0 = 16'h1100; d1 = 16'h001A; sel = 1; #20;
        d0 = 16'hFFFF; d1 = 16'h8976; sel = 0; #20;
        d0 = 16'h1122; d1 = 16'h5656; sel = 1; #20;
        d0 = 16'h1111; d1 = 16'hABCD; sel = 1; #20;
        d0 = 16'h2345; d1 = 16'h5432; sel = 0; #20;
        
        #10; $finish;
end
endmodule