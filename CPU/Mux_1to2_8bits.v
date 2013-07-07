module Mux_1to2_8bits(a0,a1,c,s);
	input [7:0]a0;
	input [7:0]a1;
	input s;
	output [7:0]c;
	
	Mux_1to2_1bit m0(.a0(a0[0]),.a1(a1[0]),.c(c[0]),.s(s));
	Mux_1to2_1bit m1(.a0(a0[1]),.a1(a1[1]),.c(c[1]),.s(s));
	Mux_1to2_1bit m2(.a0(a0[2]),.a1(a1[2]),.c(c[2]),.s(s));
	Mux_1to2_1bit m3(.a0(a0[3]),.a1(a1[3]),.c(c[3]),.s(s));
	Mux_1to2_1bit m4(.a0(a0[4]),.a1(a1[4]),.c(c[4]),.s(s));
	Mux_1to2_1bit m5(.a0(a0[5]),.a1(a1[5]),.c(c[5]),.s(s));
	Mux_1to2_1bit m6(.a0(a0[6]),.a1(a1[6]),.c(c[6]),.s(s));
	Mux_1to2_1bit m7(.a0(a0[7]),.a1(a1[7]),.c(c[7]),.s(s));
	
endmodule