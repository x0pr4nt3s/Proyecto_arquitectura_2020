`include "mips_parts/flopr.v"
`include "mips_parts/Register_file.v"
`include "mips_parts/sl2.v"
`include "mips_parts/adder.v"
`include "mips_parts/signext.v"
`include "mips_parts/mux2.v"
`include "mips_parts/Alu.v"

module datapath(clk,reset,memtoreg,pcsrc,
                alusrc,regdst,regwrite,jump,
                alucontrol,zero,pc,instr,aluout,
                writedata,readdata);

input clk,reset,memtoreg,pcsrc,alusrc,regdst;
input regwrite,jump;
input [2:0] alucontrol;
input [31:0] instr,readdata;
output zero;
output [31:0] pc,aluout,writedata;

wire [4:0] writereg;
wire [31:0] pcnext,pcnextbr,pcplus4,pcbranch;
wire [31:0] signim,signimmsh;
wire [31:0] srca,srcb;
wire [31:0] result;


//next pc

flopr pcreg(clk,reset,pcnext,pc);
adder pcadd1(pc,32'b100,pcplus4);
sl2 immsh(signim,signimmsh);
adder pcadd2(pcplus4,signimmsh,pcbranch);
mux2 pcbrmux(pcplus4,pcbranch,pcsrc,pcnextbr);
mux2 pcmux(pcnextbr,{pcplus4[31:28],instr[25:0],2'b00},jump,
            pcnext);

// register file logic 

regfile rf(clk,regwrite,instr[25:21],instr[20:16],writereg,
            result,srca,writedata);

mux2 #(5) wrmux(instr[20:16],instr[15:11],regdst,writereg);//mux del write register para el RF 

mux2 #(32) resmux(pcnextbr,{pcplus4[31:28],instr[25:0],2'b00},
                jump,pcnext);

signext se(instr[15:0],signim);

// ALU Logic 

mux2 #(32) srcbmux(writedata,signim,alusrc,srcb);

alu Alu(srca,srcb,alucontrol,
    aluout,zero);


endmodule