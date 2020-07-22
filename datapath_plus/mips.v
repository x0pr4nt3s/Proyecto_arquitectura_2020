
`include "datapath.v"
`include "controller.v"
module mips(input         clk, reset,
            output  [31:0] adr, writedata,
            output         memwrite,
            input   [31:0] readdata);

  wire        zero, pcen, irwrite, regwrite_int,regwrite_float,
               alusrca, iord, memtoreg, regdst;
  wire [1:0]  alusrcb, pcsrc;
  wire [2:0]  alucontrol;
  wire [5:0]  op, funct;

  controller c(clk, reset, op, funct, zero,
               pcen, memwrite, irwrite, regwrite_int,regwrite_float,
               alusrca, iord, memtoreg, regdst, 
               alusrcb, pcsrc, alucontrol);
  datapath dp(clk, reset, 
              pcen, irwrite, regwrite_int,regwrite_float,
              alusrca, iord, memtoreg, regdst,
              alusrcb, pcsrc, alucontrol,
              op, funct, zero,
              adr, writedata, readdata);
endmodule
