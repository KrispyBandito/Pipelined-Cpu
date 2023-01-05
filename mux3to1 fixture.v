`timescale 1 ns / 1 ps
`include "mux3to1.v";
module mux3to1_fixture;

reg [15:0] d0, d1, d2;
reg [1:0] sel;
wire [15:0] y;

initial $monitor($time, " d0 = %h, d1 = %h, d2 = %h; sel = %h, y = %h", d0, d1, d2, sel, y);

mux3to1 uut(d0, d1, d2, sel, y);

initial
begin    
        
        d0 = 16'h1100; d1 = 16'h001A; d2 = 16'h001A; sel = 1; #20;
        d0 = 16'hFFFF; d1 = 16'h8976; d2 = 16'h1842; sel = 0; #20;
        d0 = 16'h1122; d1 = 16'h5656; d2 = 16'h1467; sel = 2; #20;
        d0 = 16'h1111; d1 = 16'hABCD; d2 = 16'h2396; sel = 1; #20;
        d0 = 16'h2345; d1 = 16'h5432; d2 = 16'h6890; sel = 2; #20;
        d0 = 16'h7777; d1 = 16'h4444; d2 = 16'hEEEE; sel = 0; #20;
        
        #10; $finish;
end
endmodule