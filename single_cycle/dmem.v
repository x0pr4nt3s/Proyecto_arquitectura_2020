`ifndef _dmem_v_
`define _dmem_v_

module dmem(clk,memwrite,address,wd,rd);

input clk, memwrite;
input [31:0] address,wd;
output [31:0] rd;

reg [7:0] RAM[255:0];

assign rd = {RAM[address],RAM[address+1],RAM[address+2],RAM[address+3]}; // word aligned

always @(posedge clk)
  begin
  if (memwrite)
    {RAM[address],RAM[address+1],RAM[address+2],RAM[address+3]} <= wd;
  end
endmodule

`endif
