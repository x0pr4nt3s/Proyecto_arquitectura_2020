`ifndef _imem_v_
`define _imem_v_

module imem(a,rd);

input [5:0]  a;
output [31:0] rd;

reg [31:0] RAM[63:0];

initial begin
    $readmemh("memfile.dat",RAM); // initialize memory
end

  assign rd = RAM[a]; // word aligned
endmodule

`endif