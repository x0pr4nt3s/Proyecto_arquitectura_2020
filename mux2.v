`ifndef _mux2_v_
`define _mux2_v_

module mux2#(parameter WIDTH=32)(d0, d1,s,y);

input [WIDTH-1:0] d0,d1;
input s;
output [WIDTH-1:0] y;

assign y = s ? d1 : d0; 

endmodule
`endif