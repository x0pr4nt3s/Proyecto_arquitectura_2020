`include "Register_file.v"
module testbench();

reg clk;
reg reset;
reg [4:0] ra1,ra2,wa3;
reg [31:0] wd3;
wire [31:0] rd1,rd2;

// instantiate device to be tested
regfile dut(clk, reset,ra1,ra2,wa3,wd3,rd1,rd2);

  // initialize test
  initial
    begin
      $dumpfile("rf.vcd");
      $dumpvars(0,testbench);
      reset <= 1; # 22; reset <= 0;
      ra1<=5'b00000;ra2<=5'b00000;wa3<=1'b0;wd3<=32'b0;#5
      ra1<=5'b00010;ra2<=5'b00001;wa3<=1'b0;wd3<=32'b0;#5
      ra1<=5'b00101;ra2<=5'b00100;wa3<=1'b0;wd3<=32'b0;#5
      ra1<=5'b01101;ra2<=5'b00010;wa3<=1'b0;wd3<=32'b0;#5
      ra1<=5'b00011;ra2<=5'b01000;wa3<=1'b0;wd3<=32'b0;#5
      #300;
      $finish;
    end

  // generate clock to sequence tests
  always
    begin
      clk <= 1; # 5; clk <= 0; # 5;
    end
endmodule