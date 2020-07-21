module F_alu(read_f_data1,read_f_data2,cop,func,alu_float_result);

input [63:0] read_f_data1;//son de 64 bits por si es un double
input [63:0] read_f_data2;
input [4:0] cop;
input [5:0] func;
output reg [63:0] alu_float_result;

//signo
reg sign;

//DATA 1 en single 

wire [31:0] data1_single,data2_single;

//SEÑALES PARA SINGLE FLOATS 
reg [7:0] exponent_s_1;
reg [7:0] exponent_s_2;

reg [22:0] single_precision_1;

reg [31:0] data1;//primer operando de tipo single 
reg [31:0] data2;//segundo operando de tipo single


//son los operandos en single 
assign data1_single = read_f_data1[63:32];
assign data2_single = read_f_data2[63:32];

//datos a los que pasaran en el intercambio sea por cual operando es mayor 
reg [31:0] operand_a,operand_b;


//mantisas de operandos
reg [23:0] mantisa_a,mantisa_b;


reg [7:0] diff_exponents;


//shift a operand_b
reg [23:0] shift_operand_b; 

//exponente nuevo 
reg [7:0] exponent_b_new;


//suma de las mantisas 
reg [24:0] sum_end;

//suma final 
reg [31:0] end_sum;

always@(*)
begin
    if (cop==5'b10000) 
        begin
            if(func==6'b000000)//ADD
                begin
                    //bloque ADD SINGLE 
                    //cambair lugares de los elementos entre a y b.
                    if(data1_single < data2_single)
                        begin
                            {operand_a,operand_b} = {data2_single,data1_single};                 
                        end
                    else
                        begin
                            {operand_a,operand_b} = {data1_single,data2_single};                                             
                        end

                    exponent_s_1 = operand_a[30:23];
                    exponent_s_2 = operand_b[30:23];

                    if(exponent_s_1 != 1'd0)
                        begin
                            mantisa_a = {1'b1,operand_a[22:0]};
                        end

                    
                    if(exponent_s_2 != 1'd0)
                        begin
                            mantisa_b = {1'b1,operand_b[22:0]};
                        end

                    diff_exponents = exponent_s_1 - exponent_s_2;

                    shift_operand_b = mantisa_b >> diff_exponents;

                    exponent_b_new = exponent_s_2 + diff_exponents;

                    if(exponent_s_1 == exponent_b_new)
                        begin
                            sum_end = shift_operand_b + mantisa_a;
                        end
                    
                    if(sum_end[24] == 1'b1)
                        begin
                            end_sum [22:0] = sum_end[23:1];
                            end_sum [30:23] = 1'b1 + operand_a[30:23]; 
                            end_sum [31] =1'b0;
                        end
                    else 
                        begin
                            end_sum [22:0] = sum_end[22:0];
                            end_sum [30:23] = operand_a[30:23]; 
                            end_sum [31] = 1'b0; 
                        end


                    alu_float_result = {end_sum,{32{1'b0}}};
                end
        end
    else if(cop==5'b10001)//
        begin
            if(func==6'b000000)
                begin

                    
                end            
        end

end


endmodule