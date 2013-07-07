module Logic_32bits(A,B,C,ALUFun);
input [31:0]A;
input [31:0]B;
input [3:0]ALUFun;
output [31:0]C;

assign C=(~A&~B&{32{ALUFun[0]}})|(A&~B&{32{ALUFun[1]}})|(~A&B&{32{ALUFun[2]}})|(A&B&{32{ALUFun[3]}});

endmodule
