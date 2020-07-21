module maindec(input clk, reset, 
input [5:0] op, 
output pcwrite,memwrite,irwrite,regwrite,
output alusrca,branch,iord,memtoreg,regdst,
output [1:0] alusrcb,pcsrc,
output [2:0] aluop);

parameter FETCH = 5'b00000; // State 0
parameter DECODE = 5'b00001; // State 1
parameter MEMADR = 5'b00010;	// State 2
parameter MEMRD = 5'b00011;	// State 3
parameter MEMWB = 5'b00100;	// State 4
parameter MEMWR = 5'b00101;	// State 5
parameter RTYPEEX = 5'b00110;	// State 6
parameter RTYPEWB = 5'b00111;	// State 7
parameter BEQEX = 5'b01000;	// State 8
parameter ADDIEX = 5'b01001;	// State 9
parameter ADDIWB = 5'b01010;	// state 10
parameter JEX = 5'b01011;	// State 11
parameter ORI_EX = 5'b01100;//State 12
parameter ORI_WB = 5'b01101;//State 13
parameter ANDI_EX = 5'b01110;//State 14
parameter ANDI_WB = 5'b01111;//State 15
parameter SLTI_EX = 5'b10000;//State 16
parameter SLTI_WB = 5'b10001;//State 17
parameter BNQEX = 5'b10010;	// State 18

parameter LW = 6'b100011;	// Opcode for lw
parameter SW = 6'b101011;	// Opcode for sw
parameter RTYPE = 6'b000000;	// Opcode for R-type
parameter BEQ = 6'b000100;	// Opcode for beq
parameter ADDI = 6'b001000;	// Opcode for addi
parameter J = 6'b000010;	// Opcode for j
parameter BNQ = 6'b000101; //Opcode for bnq 
parameter ORI = 6'b001101; //Opcode for ori
parameter ANDI = 6'b001100; //Opcode for andi
parameter SLTI = 6'b001010; //Opcode for slti
parameter FLOAT = 6'b010001;//Opcode for FLOAT


reg [4:0]  state, nextstate;
reg [15:0] controls;

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
    BNQ:     nextstate <= BNQEX; 
    ADDI:    nextstate <= ADDIEX;
    ORI:     nextstate <= ORI_EX;
    ANDI:    nextstate <= ANDI_EX;
    SLTI:    nextstate <= SLTI_EX;
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

    ORI_EX: nextstate <= ORI_WB;
    ORI_WB: nextstate <= FETCH;

    ANDI_EX: nextstate <= ANDI_WB;
    ANDI_WB: nextstate <= FETCH;

    SLTI_EX: nextstate <= SLTI_WB;
    SLTI_WB: nextstate <= FETCH;


    default: nextstate <= 5'bx; // should never happen
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
    FETCH:   controls <= 16'b1010000000100000;
    DECODE:  controls <= 16'b0000000001100000;
    // your code goes here 
    MEMADR:  controls <= 16'b0000100001000000;      
    MEMRD:   controls <= 16'b0000001000000000;
    MEMWB:   controls <= 16'b0001000100000000;
    MEMWR:   controls <= 16'b0100001000000000;
    RTYPEEX: controls <= 16'b0000100000000010;
    RTYPEWB: controls <= 16'b0001000010000000;

    BEQEX:   controls <= 16'b0000110000001001;

    BNQEX:   controls <= 16'b0000110000001011;//BNQ

    ADDIEX:  controls <= 16'b0000100001000000;//ADDI
    ADDIWB:  controls <= 16'b0001000000000000;
    
    ORI_EX:  controls <= 16'b0000100001000100;//ORI
    ORI_WB:  controls <= 16'b0001000000000000;

    ANDI_EX: controls <= 16'b0000100001000101;//ANDI
    ANDI_WB: controls <= 16'b0001000000000000;

    SLTI_EX: controls <= 16'b0000100001000111;//SLTI
    SLTI_WB: controls <= 16'b0001000000000000;

    JEX:    controls <= 16'b1000000000010000; //JUMP	 
    default: controls <= 16'bxxxxxxxxxxxxxxxx;// should never happen
  endcase
endmodule