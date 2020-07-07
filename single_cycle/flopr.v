`ifndef _flopr_v_
`define _flopr_v_ 

module flopr(clk, reset,d,q);
input clk,reset;
input [31:0] d;
output reg [31:0] q;


always@(posedge clk, posedge reset)
begin
    if (reset) q <= 0;
    else       q <= d;
end

endmodule
`endif