`ifndef _controller_v_
`define _controller_v_
`include "aludec.v"
`include "maindec.v" 
module controller(op,funct,zero,memtoreg,memwrite,pcsrc,
            alusrc,regdst,regwrite,jump,alucontrol);
input [5:0] op,funct;
input zero;
output memtoreg,memwrite,pcsrc,alusrc,regdst,regwrite,jump;
output [2:0] alucontrol;

wire [1:0] aluop;
wire branch;

maindec md(op, memtoreg, memwrite, branch,
             alusrc, regdst, regwrite, jump,
             aluop);
aludec  ad(funct, aluop, alucontrol);

assign pcsrc = branch & zero;


endmodule
`endif
