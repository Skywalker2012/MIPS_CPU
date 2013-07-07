module Shifter_32bits(A,B,ALUFun,C);

	input [31:0]A;
	input [31:0]B;
	input [1:0]ALUFun;
	output [31:0]C;
	
	wire [31:0]a0;
	wire [31:0]a1;
	wire [31:0]a2;
	wire [31:0]a3;
	wire [31:0]a4;
	wire [31:0]a5;
	wire f;
	
	Mux_1to2_1bit fill(.a0(0),.a1(B[31]),.c(f),.s(ALUFun[1]));
	
	Inverter_32bits inver1(.a(B),.c(a0),.s(~ALUFun[0]));
	
	Mux_1to2_32bits m0(.a0(a0),.a1({{1{f}},a0[31:1]}),.c(a1),.s(A[0]));
	Mux_1to2_32bits m1(.a0(a1),.a1({{2{f}},a1[31:2]}),.c(a2),.s(A[1]));
	Mux_1to2_32bits m2(.a0(a2),.a1({{4{f}},a2[31:4]}),.c(a3),.s(A[2]));
	Mux_1to2_32bits m3(.a0(a3),.a1({{8{f}},a3[31:8]}),.c(a4),.s(A[3]));
	Mux_1to2_32bits m4(.a0(a4),.a1({{16{f}},a4[31:16]}),.c(a5),.s(A[4]));
	
	Inverter_32bits inver2(.a(a5),.c(C),.s(~ALUFun[0]));
endmodule