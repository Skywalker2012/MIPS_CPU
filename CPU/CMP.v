module CMP(V,Z,N,ALUFun,C);
input V,Z,N;
input [2:0]ALUFun;
output [31:0]C;

wire c0=(Z&ALUFun[2]&~ALUFun[0])|(N&ALUFun[1]&~ALUFun[0])|(~N&ALUFun[2]&~ALUFun[1])|(Z&~ALUFun[2]&ALUFun[0])|(~Z&~ALUFun[2]&~ALUFun[1]&~ALUFun[0])|(~Z&~N&ALUFun[1]&ALUFun[0]);
assign C={{31{1'b0}},c0};


endmodule
