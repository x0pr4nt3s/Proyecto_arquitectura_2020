`ifndef _signext_v_
`define _signext_v_

module signext(a,alucontrol,y);
input [15:0] a;
input [2:0] alucontrol;
output [31:0] y;              

assign y = (alucontrol==3'b001)? {{16{1'b0}},a}:{{16{a[15]}},a};
endmodule

`endif