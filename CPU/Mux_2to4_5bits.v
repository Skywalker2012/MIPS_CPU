module Mux_2to4_5bits(a0,a1,a2,a3,c,s);

input [4:0]a0,a1,a2,a3;
input [1:0]s;
output [4:0]c;
wire [4:0]c1,c2;

Mux_1to2_5bits mux0(.a0(a0),.a1(a1),.c(c1),.s(s[0]));
Mux_1to2_5bits mux1(.a0(a2),.a1(a3),.c(c2),.s(s[0]));
Mux_1to2_5bits mux2(.a0(c1),.a1(c2),.c(c),.s(s[1]));


endmodule