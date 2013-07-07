module Mux_1to2_32bits(a0,a1,c,s);
	input [31:0]a0;
	input [31:0]a1;
	input s;
	output [31:0]c;
	
	Mux_1to2_8bits m0(.a0(a0[7:0]),.a1(a1[7:0]),.c(c[7:0]),.s(s));
	Mux_1to2_8bits m1(.a0(a0[15:8]),.a1(a1[15:8]),.c(c[15:8]),.s(s));
	Mux_1to2_8bits m2(.a0(a0[23:16]),.a1(a1[23:16]),.c(c[23:16]),.s(s));
	Mux_1to2_8bits m3(.a0(a0[31:24]),.a1(a1[31:24]),.c(c[31:24]),.s(s));
	
endmodule