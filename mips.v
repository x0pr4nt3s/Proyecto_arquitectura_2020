`include "datapath.v"
module mips(clk,reset,pc,instr,memwrite,aluout,writedata,
           readdata);
input clk,reset;
output [31:0] pc;
input [31:0] instr;
output memwrite;
output [31:0] aluout,writedata;
input [31:0] readdata;
    


endmodule 