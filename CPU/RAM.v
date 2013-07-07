module RAM (reset,clk,rd,wr,addr,wdata,rdata,led,switch,digi,irqout);

input reset,clk;
input rd,wr;
input [31:0] addr;
input [31:0] wdata;
output [31:0] rdata;
output [7:0] led;
input [7:0] switch;
output [11:0] digi;
output irqout;
wire [31:0]rdata1;
wire [31:0]rdata2;

Mux_1to2_32bits datamux(.a0(rdata1),.a1(rdata2),.c(rdata),.s(addr[31]|addr[30]));

DataMem  mem(.reset(reset),.clk(clk),.rd(rd),.wr(wr),.addr(addr),.wdata(wdata),.rdata(rdata1));
Peripheral peri(.reset(reset),.clk(clk),.rd(rd),.wr(wr),.addr(addr),.wdata(wdata),.rdata(rdata2),.led(led),.switch(switch),.digi(digi),.irqout(irqout));



endmodule
