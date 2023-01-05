`timescale 1 ns / 1 ps
module cpu(input clock, reset)

//wires for IF
wire [15:0] pcIn, pcOut, pcAdderIFID, instrIFID, branchMux, 
            newPCmux, jumpMux;        
wire we_IFID, we_pc, flushIFID; 
wire [1:0] pcsrc;
  
//wires for ID
wire [15:0] branchAdderOut, branchSLOut, branchSignExtOut, zeroExtOutID,
            rd0Out, rd1IDEXIn, rd2IDEXIn, wd0RegIn, wd1RegIn, instrIDIFOut, IDEXmuxOutput;
wire [7:0] branchSignExtIn, signExt8Out;
wire [11:0] jumpSLIn;
wire [12:0] jumpSLOut; 
wire [3:0] r1Addr, r2Addr, signExt8In, comparatorOpcodeIn, writeAddrIn, opCodeCtrlIn;
wire [1:0] comparatorCtrlOut;
wire hazardDetectedMuxIn, regWriteID;
wire [10:0] controlOutput; 


//wires for EX
wire [15:0] rd1IDEXOutMuxIn, rd2IDEXOutMuxIn, wbValueMuxIn, memValueMuxIn, signExt8ALUIn,
            zeroExtdMuxIn, muxBOutMuxIn00, aluAIn, aluBIn; 
wire [31:0] aluResult;
wire [1:0] forwardAMuxCtrl, forwardBMuxCtrl, aluSrcMuxCtrl, aluOp;
wire [3:0] muxEXMEMIn, aluCtrl, r1MuxInEX, r2MuxInEX;
wire regDest, memReadToHazDet, regWriteEXMEM, regWriteMEMWB;
wire [4:0] ctrlEXMEMOut;
  
//wires for MEM
wire [31:0] aluResultToAddr, readDatatoMEMWB;
wire [15:0] WDwordByte, addressMEM;
wire [3:0] r1r2toMEMWB;
wire memWriteDM, memReadDM, weBW;

//wires for WB
  wire [31:0] aluResultWBMuxIn, muxOutWB ;
wire [15:0] mux00In, zeroExtOutWB;            //mux out to wd1 wd0
wire [7:0] zeroExtInWB;
wire [3:0] r1r2OutMEMWB, EXMEMopOut, MEMWBopOut;
wire [2:0]ctrlMEMWBOut;
wire memtoRegWB, regWriteWB;

//IF stage
	mux3to1 muxIF(.d0(branchMux), 
                .d1(newPCMux), 
                .d2(jumpMux), 
                .sel(pcsrc), 
                .y(pcIn)
               );
  
	pc pcIF(.pc(pcIn), 
          .clk(clock), 
          .wr_enable(we_pc), 
          .pcNew(pcOut)
         );
  
  adder pcAdder(.a(16'h0002), 
                .b(pcOut), 
                .result(pcAdderIFID)
               );
  
  instructionMemory instrM(.clk(clock), 
                           .pc(pcOut), 
                           .instruction(instrMemIFID)
                          ); 
  
//IFID buffer
  buffer #(.N(32)) buffIFID(.clk(clock), 
                            .pause(we_IFID), 
                            .rst(reset), 
                            .bubble(flushIFID), 
                            .buffIn({pcAdderIFID,instrIFID}), 
                            .buffOut(instrIFIDOut)
                           ); 
//ID stage
  register #(.n(16)) regID(.clk(clock), 
                           .rst(reset), 
                           .regWrite(ctrlMEMWBOut[2]), 
                           .WA(r1r2OutMEMWB), 
                           .WD1(muxOutWB[15:0]), //Accessing the Lower bits of the 32 bit output of the mux
                           .WD0(muxOutWB[31:16]), 
                           .RR1(instrIFIDOut[11:8]), 
                           .RR2(instrIFIDOut[7:4]), 
                 					 .RD0(rd0Out), 
                           .RD1(rd1IDEXIn), 
                           .RD2(rd2IDEXIn)
                          );
  
  signExtd16 signExBranch(.dataIn(instrIDIFOut[7:4]), 
                          .dataOut(branchSignExtOut)
                         );
  
  shiftleft branchShift(.dataIn(branchSignExtOut), 
                        .dataOut(branchSLOut)
                       );
  
  shiftLeft jumpShift(.dataIn(instrIDIFOut[11:0]), 
                    	.dataOut({pcMux[15:13], jumpMux})
                     );
  
  zeroExtd zeroExtID(.dataIn(instrIDIFOut[7:0]), 
                     .dataOut(zeroExtOutID)
                    );
  
  adder branchAdder(.a(branchSLOut), 
                    .b(instrIDIFOut), 
                    .result(branchAdderOut)
                   );
  
  comparator compID(.r0(rd0Out), 
                    .r1(rd1IDEXIn), 
                    .opCode(instrIDIFOut[15:12]), 
                    .branch(comparatorCtrlOut)
                   );
  
  control ctrlUnit(.opCode(instrIDIFOut[15:12]), 
                   .branchTake(comparatorCtrlOut), 
                   .PCsrc(pcsrc), 
                   .flush(flushIFID), 
                   .controlLine(controlOutput)
                  );
  
 	hazardDetection hazUnitID(.memRead(memReadToHazDet), 
                            .r2IDEX(r2MuxInEX), 
                            .r1IFID(instrIDIFOut[11:8]), 
                            .r2IFID(instrIDIFOut[7:4]), 
                            .wr_enable(hazardDetectedMuxIn)
                           );
  
 mux2to1 muxtoBuff(.d0(controlOutput), 
                   .d1(16'h0000), 
                   .sel(hazardDetectedMuxIn), 
                   .y(IDEXmux)
                  );

//IDEX buffer
  buffer #(.N(75)) buffIDEX(.clk(clock), 
                            .pause(1'bx), 
                            .rst(reset), 
                            .bubble(1'bx), 
                            
                            .buffIn({IDEXmuxOutput, rd1IDEXIn, rd2IDEXIn, zeroExtOutID,
                                    signExt8Out, instrIFIDOut[11:8], instrIFIDOut[7:4]}),
                            
                            .buffOut({controlOutput, rd1IDEXOutMuxIn, rd2IDEXOutMuxIn, zeroExtdMuxIn, 
                           				 signExt8ALUIn, r1MuxInEX, r2MuxInEX})
                           ); 
//EX stage
	mux3to1 muxAEX(.d0(rd1IDEXOutMuxIn), 
                 .d1(muxOutWB), 
                 .d2(aluResultToAddr[15:0]), 
                 .sel(forwardAMuxCtrl), 
                 .y(aluAIn)
                );
  
 	mux3to1 muxBEX(.d0(rd2IDEXOutMuxIn), 
                 .d1(muxOutWB), 
                 .d2(aluResultToAddr[15:0]),
                 .sel(forwardBMuxCtrl),
                 .y(muxBOutMuxIn00)
                );
  
  mux3to1 muxAlu(.d0(muxBOutMuxIn00),
                 .d1(zeroExtdMuxIn),
                 .d2(signExt8ALUIn),
                 .sel(controlOutput[9:8]),
                 .y(aluBIn)
                );
  
  mux2to1 WriteAdrressMux(.d0(r1MuxInEX),
                          .d1(r2MuxInEX),
                          .sel(controlOutput[10]),
                          .y(muxEXMEMIn)
                         );
  
  aluControl ControlUnitAlu(.functionCode(signExt8ALUIn),
                            .ALUop(controlOutput[7:6]),
                            .ALUctrl(aluCtrl)
                           );
  
  alu ALU(.A(aluAIn), 
          .B(aluBIn),
          .ctrl(aluCtrl),
          .result(aluResult)
         );
  
  //NEEDS WORK
  forwardingUnit ForwardUnit(.r1IDEX(r1MuxInEX), 
                             .r2IDEX(r2MuxInEX), 
                             .r12EXMEM(r1r2toMEMWB), 
                             .r12MEMWB(r1r2OutMEMWB), 
                             .regWriteEXMEM(ctrlEXMEMOut[2]), 
                             .regWriteMEMWB(ctrlMEMWBOut[2]),
                             .forwardA(forwardAMuxCtrl), 
                             .forwardB(forwardBMuxCtrl)
                            );
  
  
//EXMEM buffer
  //make wire for ctrl exmem out
  //decide control bits in
  buffer #(.N(58)) buffEXMEM(.clk(clock), .pause(1'bx), 
                             .rst(reset), .bubble(1'bx), 
                             .buffIn({controlOutput[5:0], 
                              aluResult, 
                              muxBOutMuxIn00, 
                              muxEXMEMIn}), 
                             .buffOut({ctrlEXMEMOut[5:0], 
                              aluResultToAddr, 
                              WDwordByte, 
                              r1r2toMEMWB})
                            ); 
                 
//MEM stage
  //test data mem
  dataMemory dataMem(.wr_enableBW(ctrlEXMEMOut[3]), 
                                  .memRead(ctrlEXMEMOut[4]), 
                                  .memWrite(ctrlEXMEMOut[5]), 
                                  .clk(clock),
                                  .writeByte(WDwordByte[7:0]),
                                  .writeWord(WDwordByte[15:0]),
                                  .addressMEM(aluResultToAddr),                                   
                                  .readData(readDatatoMEMWB));
	
  //memwb buffer
  buffer #(.N(39)) buffMEMWB(.clk(clock), .pause(1'bx), 
                           .rst(reset), .bubble(1'bx), 
                             .buffIn({ctrlEXMEMOut[2:0], 
                             readDatatoMEMWB,
                             aluResultToAddr,
                             r1r2toMEMWB}), 
                           .buffOut({ctrlMEMWBOut[2:0], 
                             aluResultWBMuxIn, 
                             r1r2OutMEMWB}));
//WB stage
  zeroExtd zeroExtendtoMux3(.dataIn(mux00In), 
                            .dataOut(zeroExtInWB)
                           );															
  mux32bit3to1 MuxWriteBack(.d0(mux00In), //Changed Mux from 16 bit Input/Output to a 32 bit one
                       .d1(zeroExtInWB), 
                       .d2(aluResultWBMuxIn), 
                       .sel(ctrlMEMWBOut[1:0]), 
                       .y(muxOutWB)
                      );
                     
endmodule