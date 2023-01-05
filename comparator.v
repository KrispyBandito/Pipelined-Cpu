`timescale 1 ns / 1 ps
module comparator(input [15:0] r0, r1, 
                    input [3:0] opCode,
                    output reg [1:0] branch);

always@(*)
begin
    if(opCode == 4'b0110)            //if beq
    begin
        if(r1 == r0)
            branch = 2'b00;
        else 
            branch = 2'b01;
    end
    else if(opCode == 4'b0100)        //if bgt
    begin
        if(r1 > r0)
            branch = 2'b00;
        else
            branch = 2'b01;
    end
    else if(opCode == 4'b0101)        //if blt
    begin 
        if(r1 < r0)
            branch  = 2'b00;
        else
            branch = 2'b01;
    end
    else
        branch = 2'b01;
end
endmodule