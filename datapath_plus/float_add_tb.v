`include "float_add.v"
module testbench();
    reg [31:0] a,b;
    wire [31:0] alu_float_result;

  // instantiate device to be tested
    floating_alu_add prueba(a,b,alu_float_result);
  // initialize test
  initial
    begin
    $dumpfile("prueba_float.vcd");
    $dumpvars(0,testbench);
    a<=32'b01000010000011110000000000000000;
    b<=32'b01000001101001000000000000000000;#1    
    $finish;
    end

  // generate clock to sequence tests
endmodule

