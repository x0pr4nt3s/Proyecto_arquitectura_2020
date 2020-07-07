module alu(a,b,aluop,result,zero);
input [31:0] a,b;
input [2:0] aluop;
output reg [31:0] result; 
output reg zero;

always @(*)
begin
    case (aluop)
        3'b010: //ADD
        begin
           result <= a + b; 
           zero <= 1'b0;
        end 
        3'b110: //SUB
        begin
           result <= a - b; 
           zero <= 1'b0;            
        end 
        3'b000: //AND
        begin
           result <= a & b; 
           zero <= 1'b0;
        end 
        3'b001: //OR
        begin
           result <= a | b; 
           zero <= 1'b0;
        end 
        3'b111: //SLT
        begin
           result <= (a < b) ? 1:0; 
           zero <= 1'b0;  
        end
        3'b100: //BEQ 
        begin
           result <= 32'dx; 
           zero <= (a==b) ? 1'b1:1'b0;
        end 
         3'b100: //BEQ 
        begin
           result <= 32'dx; 
           zero <= (a!=b) ? 1'b1:1'b0;
        end
    endcase
end 
endmodule
