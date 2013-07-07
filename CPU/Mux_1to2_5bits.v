module Mux_1to2_5bits(a0,a1,c,s);


input [4:0]a0,a1;
input s;
output [4:0]c;

Mux_1to2_1bit mux0(.a0(a0[0]),.a1(a1[0]),.c(c[0]),.s(s));
Mux_1to2_1bit mux1(.a0(a0[1]),.a1(a1[1]),.c(c[1]),.s(s));
Mux_1to2_1bit mux2(.a0(a0[2]),.a1(a1[2]),.c(c[2]),.s(s));
Mux_1to2_1bit mux3(.a0(a0[3]),.a1(a1[3]),.c(c[3]),.s(s));
Mux_1to2_1bit mux4(.a0(a0[4]),.a1(a1[4]),.c(c[4]),.s(s));

endmodule