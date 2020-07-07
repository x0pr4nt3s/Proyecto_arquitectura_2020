module mem(input         clk, we,
           input  [31:0] a, wd,
           output  [31:0] rd);

  reg  [31:0] RAM[63:0];

  // initialize memory with instructions
  initial
    begin
      $readmemh("ehm.dat",RAM);  // "memfile.dat" contains your instructions in hex
                                     // you must create this file
    end

  assign rd = RAM[a[31:2]]; // word aligned

  always@(posedge clk)
    if (we)
      RAM[a[31:2]] <= wd;
endmodule

