`timescale 1 ns / 1 ps
`include "mux32bit3to1_fixture.v";

module mux32bit3to1_fixture;

reg [31:0] d0, d1, d2;
reg [1:0] sel;
wire [31:0] y;

initial $monitor($time, " d0 = %h, d1 = %h, d2 = %h; sel = %h, y = %h", d0, d1, d2, sel, y);

mux32bit3to1 uut(d0, d1, d2, sel, y);

initial
begin    
        
        d0 = 32'h1100; d1 = 32'h001A; d2 = 32'h001A; sel = 1; #20;
        d0 = 32'hFFFF; d1 = 32'h8976; d2 = 32'h1842; sel = 0; #20;
        d0 = 32'h1122; d1 = 32'h5656; d2 = 32'h1467; sel = 2; #20;
        d0 = 32'h1111; d1 = 32'hABCD; d2 = 32'h2396; sel = 1; #20;
        d0 = 32'h2345; d1 = 32'h5432; d2 = 32'h6890; sel = 2; #20;
        d0 = 32'h7777; d1 = 32'h4444; d2 = 32'hEEEE; sel = 0; #20;
        
        #10; $finish;
end
endmodule