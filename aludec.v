`ifndef _aludec_v_
`define _aludec_v_ 

module aludec(funct,aluop,alucontrol);

input [5:0] funct;
input [2:0] aluop;
output reg [2:0] alucontrol;

always@(*)
begin
    case(aluop)
      3'b000: alucontrol <= 3'b010;  // add
      3'b010: alucontrol <= 3'b110;  // sub
      3'b001: alucontrol <= 3'b100;  //  beq
      3'b011: alucontrol <= 3'b101;  //bnq
      3'b100: 
      begin
      case(funct)          // RTYPE
          6'b100000: alucontrol <= 3'b010; // ADD
          6'b100010: alucontrol <= 3'b110; // SUB
          6'b100100: alucontrol <= 3'b000; // AND
          6'b100101: alucontrol <= 3'b001; // OR
          6'b101010: alucontrol <= 3'b111; // SLT
          default:   alucontrol <= 3'bxxx; // ???
        endcase
      end
    endcase
end

endmodule

`endif