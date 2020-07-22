module floating_alu_add(a,b,alu_op_float,alu_float_result);
input [31:0] a,b;
input [1:0] alu_op_float;
output [31:0] alu_float_result;


//valores de los inputs
wire sign_a,sign_b;
wire [7:0] exponente_sesgado_a,exponente_sesgado_b;
wire [23:0] mantisa_norm_a,mantisa_norm_b;
//diferencia de las exponentes sesgados
wire [7:0] diff_exponents;
//su actualizacion
wire [7:0] menor_exponente;
wire [7:0] mayor_exponente;
//nuevo valor del exponente menor 
wire [23:0] new_mantisa_shift;
wire [23:0] mantisa_mayor;
//suma de la mantisa final 
wire [22:0] mantisa_final;
wire sign_final;


//ADD 
assign sign_a = a[31];
assign sign_b = b[31];

assign exponente_sesgado_a = a[30:23];
assign exponente_sesgado_b = b[30:23];

assign mantisa_norm_a = {1'b1,a[22:0]};
assign mantisa_norm_b = {1'b1,b[22:0]};


assign diff_exponents = (exponente_sesgado_a >= exponente_sesgado_b ) ? exponente_sesgado_a - exponente_sesgado_b : exponente_sesgado_b - exponente_sesgado_a;

assign menor_exponente = (exponente_sesgado_a >= exponente_sesgado_b) ? exponente_sesgado_b : exponente_sesgado_a;
//halla mayor exponente 
assign mayor_exponente = (menor_exponente == exponente_sesgado_a ) ? exponente_sesgado_b : exponente_sesgado_a;

assign new_mantisa_shift = (menor_exponente == exponente_sesgado_a) ? mantisa_norm_a >> diff_exponents : mantisa_norm_b >> diff_exponents;
assign mantisa_mayor = (menor_exponente == exponente_sesgado_a ) ? mantisa_norm_b : mantisa_norm_a;

assign mantisa_final = (new_mantisa_shift[22:0] + mantisa_mayor[22:0]);

assign sign_final = sign_a & sign_b;

assign alu_float_result = (alu_op_float==2'b) ?{sign_final,mayor_exponente,mantisa_final};



endmodule
