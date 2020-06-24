`ifndef _adder_v_
`define _adder_v_ 

module adder(a, b,y);
    input [31:0] a,b;
    output [31:0] y;

  assign y = a + b;

endmodule 

`endif