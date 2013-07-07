//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:28:49 06/29/2013 
// Design Name: 
// Module Name:    add_sub 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module AddSub_32bits(s,A,B,ALUFun0,Z,V,N,result);
input s,ALUFun0;
input [31:0] A,B;
output Z,V,N;
output [31:0] result;

wire rem_cout,rem_cin8;
wire [31:0] temp;

assign temp=B^{32{ALUFun0}};


Adder_32bits add_sub(.cin(ALUFun0),.A(A),.B(temp),.cout(rem_cout),.sum(result),.cin9(rem_cin8));

assign V=(rem_cout^rem_cin8)&s|(~s)&(rem_cout^ALUFun0);

assign Z=~(|result);

assign N=(~s)&V&ALUFun0|s&(V&(~result[31])|result[31]&s&(~V));

endmodule
