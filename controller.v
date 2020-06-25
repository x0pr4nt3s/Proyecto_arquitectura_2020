`ifndef _controller_v_
`define _controller_v_ 
module controller(op,funct,zero,memtoreg,memwrite,pcsrc,alusrc,
                  regdst,regwrite,jump,alucontrol);
input [5:0] op;
input funct,zero;
output memtoreg,memwrite,pcsrc,alusrc,regdst,regwrite,jump;
output [2:0] alucontrol;




endmodule
`endif
