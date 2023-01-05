`timescale 1 ns / 1 ps
`include "forwardingUnit.v";
module forwardingUnit_fixture;

reg [3:0] r1IDEX, r2IDEX, r12EXMEM, r12MEMWB;
reg regWriteEXMEM, regWriteMEMWB;
wire [1:0] forwardA, forwardB;

forwardingUnit uut(r1IDEX, r2IDEX, r12EXMEM, r12MEMWB,
                        regWriteEXMEM, regWriteMEMWB,
                        forwardA, forwardB);

initial $monitor($time, " forwardA = %b, forwardB = %b", forwardA, forwardB);

initial
begin
        //#20;
        //add idex & add exmem & lw memwb -> fA = 10 & fB = 10
        //memhazard
        r1IDEX = 4'b0001;     //add r1
        r2IDEX = 4'b0001;     //add r2      
        r12EXMEM = 4'b0001;    //add r1
        //r2EXMEM = 4'b0001;    //add r2
        r12MEMWB = 4'b0111;    //bgt r1       
        //r2MEMWB = 4'b0010;    //bgt r2
        regWriteEXMEM = 1; 
        regWriteMEMWB = 1;
        #20;
        //ori idex & sub exmem & add memwb -> fA = 00 & fB = 10
        //memhazard
        r1IDEX = 4'b0011;     //ori r1
        r2IDEX = 4'b1000;     //ori r2      
        r12EXMEM = 4'b1011;    //sub r1
        //r2EXMEM = 4'b0010;    //sub r2
        r12MEMWB = 4'b1110;    //add r1       
        //r2MEMWB = 4'b0010;    //add r2
        regWriteEXMEM = 1; 
        regWriteMEMWB = 1;    
        #20;
        
        //lb idex & sw exmem & lbu memwb -> fA = 01 & fB = 00
        //memhazard
        r1IDEX = 4'b0110;     //lw r1
        r2IDEX = 4'b1001;     //lw r2
        r12EXMEM = 4'b0110;    //sb r1
        //r2EXMEM = 4'b1001;    //sb r2
        r12MEMWB = 4'b0110;    //lbu r1
        //r2MEMWB = 4'b1001;    //lbu r2
        regWriteEXMEM = 0; 
        regWriteMEMWB = 1;    
        #20;
        //sub idex & add exmem & sub memwb -> fA = 10 & fB = 00
        //memhazard
        r1IDEX = 4'b0001;     //subr1,r2 ->r1
        r2IDEX = 4'b0010;     //subr1,r2 ->r2
        r12EXMEM = 4'b0001;    //add r1
        //r2EXMEM = 4'b0010;    //add r2
        r12MEMWB = 4'b0000;    //sub r1
        //r2MEMWB = 4'b0000;    //sub r2
        regWriteEXMEM = 1; 
        regWriteMEMWB = 1;    
        #20;
        #10; $finish;
end
endmodule
