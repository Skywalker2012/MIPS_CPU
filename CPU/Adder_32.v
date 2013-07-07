//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:58:42 06/29/2013 
// Design Name: 
// Module Name:    Adder_32bits 
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
module Adder_32bits(cin,A,B,cout,sum,cin9);
input cin;
input [31:0] A,B;
output cout,cin9;
output [31:0] sum;

wire cin2,cin3,cin4,cin5,cin6,cin7,cin8;

Adder_4bits adder1(.cin(cin),.cout(cin2),.a(A[3:0]),.b(B[3:0]),.s0(sum[0]),.s1(sum[1]),.s2(sum[2]),.s3(sum[3]),.c3());
Adder_4bits adder2(.cin(cin2),.cout(cin3),.a(A[7:4]),.b(B[7:4]),.s0(sum[4]),.s1(sum[5]),.s2(sum[6]),.s3(sum[7]),.c3());
Adder_4bits adder3(.cin(cin3),.cout(cin4),.a(A[11:8]),.b(B[11:8]),.s0(sum[8]),.s1(sum[9]),.s2(sum[10]),.s3(sum[11]),.c3());
Adder_4bits adder4(.cin(cin4),.cout(cin5),.a(A[15:12]),.b(B[15:12]),.s0(sum[12]),.s1(sum[13]),.s2(sum[14]),.s3(sum[15]),.c3());
Adder_4bits adder5(.cin(cin5),.cout(cin6),.a(A[19:16]),.b(B[19:16]),.s0(sum[16]),.s1(sum[17]),.s2(sum[18]),.s3(sum[19]),.c3());
Adder_4bits adder6(.cin(cin6),.cout(cin7),.a(A[23:20]),.b(B[23:20]),.s0(sum[20]),.s1(sum[21]),.s2(sum[22]),.s3(sum[23]),.c3());
Adder_4bits adder7(.cin(cin7),.cout(cin8),.a(A[27:24]),.b(B[27:24]),.s0(sum[24]),.s1(sum[25]),.s2(sum[26]),.s3(sum[27]),.c3());
Adder_4bits adder8(.cin(cin8),.cout(cout),.a(A[31:28]),.b(B[31:28]),.s0(sum[28]),.s1(sum[29]),.s2(sum[30]),.s3(sum[31]),.c3(cin9));

endmodule
