`ifndef _dmem_v_
`define _dmem_v_

module dmem(clk,memwrite,address,wd,rd);

input clk, memwrite;
input [31:0] address,wd;
output [31:0] rd;

reg [31:0] RAM[63:0];

assign rd = RAM[address[31:0]]; // word aligned

  always @(posedge clk)
    begin
    if (memwrite)
      RAM[address[31:0]] <= wd;
    end
endmodule

`endif