`ifndef _imem_v_
`define _imem_v_

module imem(a,rd);
input [31:0] a;
output [31:0] rd;

reg [7:0] RAM[0:71];


initial begin
  $readmemb("memfile.txt",RAM); // initialize memory
end

  assign rd = {RAM[a],RAM[a+1],RAM[a+2],RAM[a+3]}; // word aligned
endmodule

`endif