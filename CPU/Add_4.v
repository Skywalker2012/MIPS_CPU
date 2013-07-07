//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:57:42 06/29/2013 
// Design Name: 
// Module Name:    add_4 
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

module Adder_4bits(cin,cout,a,b,s0,s1,s2,s3,c3);
input [3:0] a;
input [3:0] b;
input cin;
output s0,s1,s2,s3;
output cout,c3;
wire [3:0] g;
wire [3:0] p;
wire c3,c1,c2;
assign g[0]=a[0]&b[0];
assign g[1]=a[1]&b[1];
assign g[2]=a[2]&b[2];
assign g[3]=a[3]&b[3];
assign p[0]=(a[0]&~b[0])|(~a[0]&b[0]);
assign p[1]=(a[1]&~b[1])|(~a[1]&b[1]);
assign p[2]=(a[2]&~b[2])|(~a[2]&b[2]);
assign p[3]=(a[3]&~b[3])|(~a[3]&b[3]);
assign c1=g[0]|(p[0]&cin);
assign c2=g[1]|(p[1]&g[0])|(p[1]&p[0]&cin);
assign c3=g[2]|(p[2]&g[1])|(p[2]&p[1]&g[0])|(p[2]&p[1]&p[0]&cin);
assign cout=g[3]|(p[3]&g[2])|(p[3]&p[2]&g[1])|(p[3]&p[2]&p[1]&g[0])|(p[3]&p[2]&p[1]&p[0]&cin);
assign s0=(~a[0]&~b[0]&cin)|(~a[0]&b[0]&~cin)|(a[0]&~b[0]&~cin)|(a[0]&b[0]&cin);
assign s1=(~a[1]&~b[1]&c1)|(~a[1]&b[1]&~c1)|(a[1]&~b[1]&~c1)|(a[1]&b[1]&c1);
assign s2=(~a[2]&~b[2]&c2)|(~a[2]&b[2]&~c2)|(a[2]&~b[2]&~c2)|(a[2]&b[2]&c2);
assign s3=(~a[3]&~b[3]&c3)|(~a[3]&b[3]&~c3)|(a[3]&~b[3]&~c3)|(a[3]&b[3]&c3);
endmodule

