module aludec(input  wire [5:0] funct,
              input  wire [2:0] aluop,
              output reg [2:0] alucontrol);

  // ADD CODE HERE
  // Complete the design for the ALU Decoder.
  // Your design goes here.  Remember that this is a combinational 
  // module. 

  // Remember that you may also reuse any code from previous labs.
  always @(*)
    case(aluop)
      3'b000: alucontrol <= 3'b010;  // add -
      3'b001: alucontrol <= 3'b100;  // beq -
      3'b011: alucontrol <= 3'b011;   // bnq -
      3'b100: alucontrol <= 3'b001;   // or -
      3'b101: alucontrol <= 3'b000;   // andi -
      3'b111: alucontrol <= 3'b111;   // slti -
      3'b010: case(funct)          // RTYPE
          6'b100000: alucontrol <= 3'b010; // ADD
          6'b100010: alucontrol <= 3'b110; // SUB
          6'b100100: alucontrol <= 3'b000; // AND
          6'b100101: alucontrol <= 3'b001; // OR
          6'b101010: alucontrol <= 3'b111; // SLT
          default:   alucontrol <= 3'bxxx; 
        endcase
  endcase

endmodule

