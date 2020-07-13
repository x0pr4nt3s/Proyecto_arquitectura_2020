module maindec(input clk, reset, 
input [5:0] op, 
output pcwrite,memwrite,irwrite,regwrite,
output alusrca,branch,iord,memtoreg,regdst,
output [1:0] alusrcb,pcsrc,
output [1:0] aluop);

parameter FETCH = 4'b0000; // State 0
parameter DECODE = 4'b0001; // State 1
parameter MEMADR = 4'b0010;	// State 2
parameter MEMRD = 4'b0011;	// State 3
parameter MEMWB = 4'b0100;	// State 4
parameter MEMWR = 4'b0101;	// State 5
parameter RTYPEEX = 4'b0110;	// State 6
parameter RTYPEWB = 4'b0111;	// State 7
parameter BEQEX = 4'b1000;	// State 8
parameter ADDIEX = 4'b1001;	// State 9
parameter ADDIWB = 4'b1010;	// state 10
parameter JEX = 4'b1011;	// State 11

parameter LW = 6'b100011;	// Opcode for lw
parameter SW = 6'b101011;	// Opcode for sw
parameter RTYPE = 6'b000000;	// Opcode for R-type
parameter BEQ = 6'b000100;	// Opcode for beq
parameter ADDI = 6'b001000;	// Opcode for addi
parameter J = 6'b000010;	// Opcode for j

reg [3:0]  state, nextstate;
reg [14:0] controls;

  // state register
always @(posedge clk or posedge reset)			
  if(reset) state <= FETCH;
  else state <= nextstate;

  // ADD CODE HERE
  // Finish entering the next state logic below.  We've completed the first 
  // two states, FETCH and DECODE, for you.

  // next state logic
always @(*)
  case(state)
    FETCH:   nextstate <= DECODE;
    DECODE:  case(op)
    LW:      nextstate <= MEMADR;
    SW:      nextstate <= MEMADR;
    RTYPE:   nextstate <= RTYPEEX;
    BEQ:     nextstate <= BEQEX;
    ADDI:    nextstate <= ADDIEX;
    J:       nextstate <= JEX;
    default: nextstate <= 4'bx; // should never happen
    endcase
 		// Add code here
    MEMADR:  case(op)
    LW: nextstate <= MEMRD;
    SW: nextstate <= MEMWR;
    default: nextstate <= 4'bx;
    endcase
    MEMRD: nextstate <= MEMWB;
    MEMWB: nextstate <= FETCH;
    MEMWR: nextstate <= FETCH;
    RTYPEEX: nextstate <= RTYPEWB;
    RTYPEWB: nextstate <= FETCH;
    BEQEX:   nextstate <= FETCH;
    ADDIEX:  nextstate <= ADDIWB;
    ADDIWB:  nextstate <= FETCH;
    JEX: nextstate <= FETCH;    
    default: nextstate <= 4'bx; // should never happen
  endcase

  // output logic
  assign {pcwrite, memwrite, irwrite, regwrite, 
  alusrca, branch, iord, memtoreg, regdst,
  alusrcb, pcsrc, aluop} = controls;
  // ADD CODE HERE
  // Finish entering the output logic below.  We've entered the
  // output logic for the first two states, S0 and S1, for you.
always @(*)
  case(state)
    FETCH:   controls <= 15'b101000000010000;
    DECODE:  controls <= 15'b000000000110000;
    // your code goes here 
    MEMADR:  controls <= 15'h0420;      
    MEMRD:   controls <= 15'h0100;
    MEMWB:   controls <= 15'h0880;
    MEMWR:   controls <= 15'h2100;
    RTYPEEX: controls <= 15'h0402;
    RTYPEWB: controls <= 15'h0840;
    BEQEX:   controls <= 15'h0605;
    ADDIEX:  controls <= 15'h0420;
    ADDIWB:  controls <= 15'h0800;
    JEX:     controls <= 15'h4008;	 
    default: controls <= 15'hxxxx;// should never happen
  endcase
endmodule