`include "mipstop.v"
module testbench();

    reg clk;
    reg reset;

  wire [31:0] writedata, dataadr;
  wire memwrite;

  // instantiate device to be tested
  top dut(clk, reset, writedata, dataadr, memwrite);
  
  // initialize test
  initial
    begin
      $dumpfile("mips.vcd");
      $dumpvars(0,testbench);
      reset <= 1; #1; reset <= 0;
      #300;
      $finish;
    end

  // generate clock to sequence tests
  always
    begin
      clk <= 1; # 1; clk <= 0; # 1;
    end

  // check that 7 gets written to address 84
  always@(negedge clk)
    begin
      if(memwrite) begin
        if(dataadr === 84 & writedata === 7) begin
          $display("Simulation succeeded");
          $finish;
        end else if (dataadr !== 80) begin
          $display("Simulation failed");
          $finish;
        end
      end
    end
endmodule

