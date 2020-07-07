
`include "mem.v"
`include "mips.v"
module top(input 	clk, reset, 
           output [31:0] writedata, adr, 
           output      memwrite);

  wire [31:0] readdata;
  
  mips mips(clk, reset, adr, writedata, memwrite, readdata);
   
  mem mem(clk, memwrite, adr, writedata, readdata);

endmodule
