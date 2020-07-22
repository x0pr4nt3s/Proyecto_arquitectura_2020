module mem(input         clk, we,
           input  [31:0] a, wd,
           output  [31:0] rd);

  reg  [7:0] RAM [0:100];

  // initialize memory with instructions
  initial
    begin
      $readmemb("mem.dat",RAM);  
    end

  assign rd = {RAM[a],RAM[a+1],RAM[a+2],RAM[a+3]}; // word aligned

  always@(posedge clk)
    if (we)
      {RAM[a],RAM[a+1],RAM[a+2],RAM[a+3]} <= wd;
endmodule

