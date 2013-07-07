module EXT_32bits(datain,EXTOP,dataout);
input [15:0]datain;
input EXTOP;
output [31:0]dataout;
wire f;
assign dataout[15:0]=datain[15:0];
assign dataout[31:16]={16{f}};
Mux_1to2_1bit mux1(.a0(0),.a1(datain[15]),.c(f),.s(EXTOP));

endmodule