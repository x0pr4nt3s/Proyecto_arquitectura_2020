`include "mipsparts.v"
`include "Alu.v"
`include "float_add.v"
module datapath(input          clk, reset,
                input          pcen, irwrite, regwrite_int,regwrite_float,
                input          alusrca, iord, memtoreg, regdst,
                input   [1:0]  alusrcb, pcsrc, 
                input   [2:0]  alucontrol,
                output  [5:0]  op, funct,
                output         zero,
                output  [31:0] adr, writedata, 
                input   [31:0] readdata);


  wire [4:0]  writereg;
  wire [31:0] pcnext, pc;
  wire [31:0] instr, data, srca_int, srcb_int,srca_float,srcb_float;
  wire [31:0] a;
  wire [31:0] aluresult, aluout;
  wire [31:0] signimm;   
  wire [31:0] signimmsh;	
  wire [31:0] wd3, rd1_int, rd2_int;

  wire [31:0] alu_float_result;

  wire [31:0] rd1_float,rd2_float;

  wire [31:0] rd1_final,rd2_final;

  wire [31:0] aluresult_final;

  assign op = instr[31:26];
  assign funct = instr[5:0];




  flopenr #(32) pcreg(clk, reset, pcen, pcnext, pc);
  mux2    #(32) adrmux(pc, aluout, iord, adr);
  flopenr #(32) instrreg(clk, reset, irwrite, readdata, instr);
  flopr   #(32) datareg(clk, reset, readdata, data);
  mux2    #(5)  regdstmux(instr[20:16], instr[15:11],regdst, writereg);
  mux2    #(32) wdmux(aluout, data, memtoreg, wd3);

  regfile       rf_int(clk, regwrite_int, instr[25:21], instr[20:16], writereg, wd3, rd1_int, rd2_int);
  
  regfile_float     rf_floating(clk,regwrite_float,instr[25:21],instr[20:16],instr[15:11],wd3,rd1_float,rd2_float);
  
  signext       se(instr[15:0], signimm);
  sl2           immsh(signimm, signimmsh);

  mux2 #(32) rd1_int_o_float(rd1_int,rd1_float,regwrite_float,rd1_final);
  mux2 #(32) rd2_int_o_float(rd2_int,rd2_float,regwrite_float,rd2_final);


  flopr   #(32) areg(clk, reset, rd1_final, a);
  flopr   #(32) breg(clk, reset, rd2_final, writedata);
  
  mux2    #(32) srcamux(pc, a, alusrca, srca_int);
  mux4    #(32) srcbmux(writedata, 32'b100, signimm, signimmsh, alusrcb, srcb_int);
  
  //ALU INT
  alu           alu_int(srca_int, srcb_int, alucontrol, aluresult, zero);
  //ALU FLOAT
  floating_alu_add alu_float(a,writedata,alucontrol,alu_float_result);
  //mux entre el alu int y el alu float

  mux2 #(32) alu_int_o_alu_float(aluresult,alu_float_result,regwrite_float,aluresult_final);
  
  flopr   #(32) alureg(clk, reset, aluresult_final, aluout);

  mux3    #(32) pcmux(aluresult, aluout, {pc[31:28], instr[25:0], 2'b00}, pcsrc, pcnext);  
endmodule

