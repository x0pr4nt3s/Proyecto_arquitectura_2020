`ifndef _signext_v_
`define _signext_v_

module signext(a,y);
input [15:0] a;
output [31:0] y;              

assign y = {{16{a[15]}}, a};
endmodule

`endif