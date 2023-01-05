timesclase 1ns / 1ps
`include "cpu.v"

module cpu_fixture;
  
  reg clk, reset;
  
  
  cpu uut (clk, reset);
  
  initial begin
    clk = 0;
    totalclk = 0;
    
    forever begin 
      #10 clk = ~clk;
      if (reset == 1'b1 && clk = 1'b1)
      	totalclk = totalclk + 1;
    end
  end
  
  always @(negedge clk)
    begin
      $display("Total clk cycles = %d, reset = %h", totalclk, reset);
      
      //Instruction Fetch Stage Displays
      $display("========== Instrcution Fetch Stage ===============");
      $display("IF MuxBranch = %h", uut.branchMux);
      $display("IF MuxPCNew = %h", uut.newPCMux);
      $display("IF MuxJump = %h", uut.jumpMux);
      $display("IF PCSrc = %h", uut.pcsrc);      
      $display("IF PCNew = %h", uut.pcIn);
      $display("IF PCOut = %h", uut.pcOut);
      $display("IF Instruction = %h", uut.instrMemIFID);
      
      //Decode Stage Displays
      $display("========== Decode Stage ===============");
      $display("IDInstruction = %h", uut.instrIFIDOut);
      $display("ID ControlIn = %h", uut.instrIFIDOut[15:12]);
      $display("ID ControlOut = %h", uut.controlOutput);      
      $display("ID RR1 = %h", uut.instrIFIDOut[11:8]);
      $display("ID RR2 = %h", uut.instrIFIDOut[7:4]);
      $display("ID WA = %h", uut.r1r2OutMEMWB);
      $display("ID WD1 = %h", uut.muxOutWB[15:0]);
      $display("ID Wd0 = %h", uut.muxOutWB[31:16]);
      $display("ID RD1 = %h", uut.rd1IDEXIn);
      $display("ID RD2 = %h", uut.rd2IDEXIn);
      $display("ID RD0 = %h", uut.rd0Out);


			//Exectue Stage
      $display("========== Memory Stage ===============");
      $display("EX ALU Input A = %h", uut.aluAIn);
      $display("EX MUXB Out = %h", uut.muxBOutMuxIn00);
      $display("EX ALU Input B = %h", uut.aluBIn);
      $display("EX Register MUX Out = %h", uut.muxEXMEMIn);
      $display("EX Forward A Ctrl = %h", uut.forwardAMuxCtrl);
      $display("EX Forward B Ctrl = %h", uut.forwardBMuxCtrl);
      $display("EX ALU Ctrl = %h", uut.aluCtrl);
      
      
			//Memory Stage Displays
      $display("========== Memory Stage ===============");
      $display("MEM ALU Result Lower (Addr) = %h", uut.aluResulToAddr[15:0]);
      $display("MEM ALU Result Lower = %h", uut.aluResulToAddr[31:16]);
      $display("MEM WD Word = %h", uut.WDwordByte[7:0]);
      $display("MEM WD Byte = %h", uut.WDwordByte);
      $display("MEM Read Data = %h", uut.readDatatoMEMWB);
      
      
      //Write Back Stage
      $display("========== Write Back Stage ===============");
      $display("WB MUX 00 = %h", uut.mux00In);
      $display("WB MUX 01 = %h", uut.zeroExtOutWB);
      $display("WB MUX 10 = %h", uut.aluResultWBMuxIn);
      $display("WB MUX OUT = %h", uut.muxOutWB);
    end
endmodule