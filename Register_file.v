`ifndef _Register_file_v_
`define _Register_file_v_ 

module regfile(clk,we3,ra1,ra2,wa3,wd3,rd1,rd2);
  input clk,we3;
  input [4:0] ra1,ra2,wa3;
  input [31:0] wd3;
  output [31:0] rd1,rd2;

  reg [31:0] variables[0:31];

  // three ported register file
  // read two ports combinationally
  // write third port on rising edge of clock
  // register 0 hardwired to 0
//  initial begin
  //  $readmemh("variables.txt",variables);
  //end

  always@(posedge clk)
  begin
    if (we3) 
      variables[wa3] <= wd3;	
  end

  assign rd1 = (ra1==5'd0) ? 32'd0 : variables[ra1];
  assign rd2 = (ra2==5'd0) ? 32'd0 : variables[ra2];
endmodule
`endif