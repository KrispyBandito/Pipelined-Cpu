`timescale 1 ns / 1 ps
module forwardingUnit(//input [3:0] r1IDEX, r2IDEX, r1EXMEM, r2EXMEM, r1MEMWB, r2MEMWB,
                        input [3:0] r1IDEX, r2IDEX, r12EXMEM, r12MEMWB,
                        input regWriteEXMEM, regWriteMEMWB,
                        output reg [1:0] forwardA, forwardB);

always@(*)
begin
  //choose forward A
  //ex mem hazard
  if(regWriteEXMEM && (r12EXMEM != 0) && (r12EXMEM == r1IDEX))
      forwardA = 2'b10; 
  //mem hazard
  else if(regWriteMEMWB && (r12MEMWB != 0) && !(regWriteEXMEM && (r12EXMEM != 0) && (r12EXMEM != r1IDEX)) && (r12MEMWB == r1IDEX)) 
       forwardA = 2'b01;
  //no hazard
  else
      forwardA = 2'b00;
      
      //choose forward B
      //ex hazard
  if(regWriteEXMEM && (r12EXMEM != 0) && (r12EXMEM == r2IDEX))
      forwardB = 2'b10;
  //mem hazard
  else if(regWriteMEMWB && (r12MEMWB != 0) && !(regWriteEXMEM && (r12EXMEM != 0) && (r12EXMEM != r2IDEX)) && (r12MEMWB == r2IDEX))
       forwardB = 2'b01;
  //no hazard     
  else
      forwardB = 2'b00;

end
endmodule
