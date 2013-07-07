module ALU_32bits(A,B,ALUFun,Sign,ALUOut);

input [31:0]A;
input [31:0]B;
input [5:0]ALUFun;
input Sign;
output [31:0]ALUOut;

wire V,Z,N;

wire [31:0]asOut,shOut,lgcOut,cmpOut,mout0,mout1;


Mux_1to2_32bits m0(.a0(asOut),.a1(lgcOut),.c(mout0),.s(ALUFun[4]));
Mux_1to2_32bits m1(.a0(shOut),.a1(cmpOut),.c(mout1),.s(ALUFun[4]));
Mux_1to2_32bits m2(.a0(mout0),.a1(mout1),.c(ALUOut),.s(ALUFun[5]));

Shifter_32bits shifter(.A(A),.B(B),.ALUFun(ALUFun[1:0]),.C(shOut));
AddSub_32bits addsub(.s(Sign),.A(A),.B(B),.ALUFun0(ALUFun[0]),.Z(Z),.V(V),.N(N),.result(asOut));
Logic_32bits logic(.A(A),.B(B),.C(lgcOut),.ALUFun(ALUFun[3:0]));
CMP cmper(.V(V),.Z(Z),.N(N),.ALUFun(ALUFun[3:1]),.C(cmpOut));

endmodule