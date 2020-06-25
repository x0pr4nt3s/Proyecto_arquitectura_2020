`ifndef _maindec_v_
`define _maindec_v_ 

module maindec(op,memtoreg, memwrite,branch, alusrc,
               regdst, regwrite,jump,aluop);
input [5:0] op;
output reg memtoreg,memwrite,branch,alusrc,regdst,regwrite;
output reg jump;
output reg [1:0] aluop;

  always@(*)
  begin
    case(op)
      6'b000000: //Rtype
      begin
          regwrite<=1'b1;regdst<=1'b1;alusrc<=1'b0;
          branch<=1'b0;memwrite<=1'b0;memtoreg<=1'b0;
          jump<=1'b0;aluop<=2'b10;
      end
      6'b100011: //LW
      begin
          regwrite<=1'b1;regdst<=1'b0;alusrc<=1'b1;
          branch<=1'b0;memwrite<=1'b0;memtoreg<=1'b1;
          jump<=1'b0;aluop<=2'b00;
      end
      6'b101011: //SW --
      begin
          regwrite<=1'b0;regdst<=1'b0;alusrc<=1'b1;
          branch<=1'b0;memwrite<=1'b1;memtoreg<=1'b0;
          jump<=1'b0;aluop<=2'b00;
      end
      6'b000100: //BEQ --
      begin
          regwrite<=1'b0;regdst<=1'b0;alusrc<=1'b0;
          branch<=1'b1;memwrite<=1'b0;memtoreg<=1'b0;
          jump<=1'b0;aluop<=2'b01;
      end
      6'b001000: //ADDI --
      begin
          regwrite<=1'b1;regdst<=1'b0;alusrc<=1'b1;
          branch<=1'b0;memwrite<=1'b0;memtoreg<=1'b0;
          jump<=1'b0;aluop<=2'b00;
      end
      6'b000010: //J --
      begin
          regwrite<=1'b0;regdst<=1'b0;alusrc<=1'b0;
          branch<=1'b0;memwrite<=1'b0;memtoreg<=1'b0;
          jump<=1'b1;aluop<=2'b00;
      end
    endcase
  end
endmodule

`endif