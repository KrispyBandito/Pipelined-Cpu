`timescale 1 ns / 1 ps
module aluControl(input [3:0] functionCode, 
                    input [1:0] ALUop,
                    output reg [3:0] ALUctrl);

always@(*)
begin
    if((functionCode == 4'b0001) && (ALUop == 2'b00))               //if signed add & type A 
        ALUctrl = 4'b0000;
    else if((functionCode == 4'b0010) && (ALUop == 2'b00))           //if signed sub & type A
        ALUctrl = 4'b0001;
    else if((functionCode == 4'b0100) && (ALUop == 2'b00))           //if signed multi & type A
        ALUctrl = 4'b0010;
    else if((functionCode == 4'b1000) && (ALUop == 2'b00))           //if signed div & type A
        ALUctrl = 4'b0011;
    else if((ALUop == 2'b10))                                         //if andi & type C
        ALUctrl = 4'b0100;                                            //and
    else if((ALUop == 2'b10))                                        //if ori & type C
        ALUctrl = 4'b0101;                                            //or
    else    
        ALUctrl = 4'b0110;                                            //add  for lw etc
end
endmodule