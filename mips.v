`ifndef _mips_v_
`define _mips_v_
`include "datapath.v"
`include "controller.v"
module mips(clk,reset,pc,instr,memwrite,aluout,writedata,
           readdata);
input clk,reset;
output [31:0] pc;
input [31:0] instr;
output memwrite;
output [31:0] aluout,writedata;
input [31:0] readdata;

wire        memtoreg, branch,
            pcsrc, zero,
            alusrc, regdst, regwrite, jump;
wire [2:0]  alucontrol;
    

  controller c(instr[31:26], instr[5:0], zero,
               memtoreg, memwrite, pcsrc,
               alusrc, regdst, regwrite, jump,
               alucontrol);
  datapath dp(clk, reset, memtoreg, pcsrc,
              alusrc, regdst, regwrite, jump,
              alucontrol,
              zero, pc, instr,
              aluout, writedata, readdata);


endmodule 

`endif