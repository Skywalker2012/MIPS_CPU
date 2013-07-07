module SingleCycleCPU(led,switch,digi,reset,clkIn);

input reset;
input clkIn;
input [7:0]switch;
output [7:0]led;
output[11:0]digi;

wire irq;
wire clk;
wire[31:0]AlusrcA,AlusrcB,Immdata,EXTImm;
wire[31:0]DataBusA,DataBusB,DataBusC,ConBA,ALUOut;
wire[31:0]RamData,dataMemToReg,PC4;
wire [15:0]Imm16;
wire[4:0]Shamt,Rd,Rt,Rs,AddrC;
wire[5:0]ALUFun;
wire Sign,MemRd,MemWr,EXTOp,LUOp;
wire [1:0]MemToReg,RegDst;
assign clk=clkIn;



Instruction_Part instruction_part(.ConBA(ConBA),.DataBusA(DataBusA),.IRQ(irq),.ALUOut0(ALUOut),.PC4(PC4),.Reset(reset),
                        .Imm16(Imm16),.Shamt(Shamt),.Rd(Rd),.Rt(Rt),.Rs(Rs),
                        .RegDst(RegDst),.RegWr(RegWr),.ALUSrc1(ALUSrc1),.ALUSrc2(ALUSrc2),.ALUFun(ALUFun),.Sign(Sign),.MemWr(MemWr),
                        .MemRd(MemRd),.MemToReg(MemToReg),.EXTOp(EXTOp),.LUOp(LUOp),.Clk(clk));

Mux_1to2_32bits muxALUSrc1(.a0(DataBusA),.a1({{27{1'b0}},Shamt}),.c(AlusrcA),.s(ALUSrc1));
Mux_1to2_32bits muxALUSrc2(.a0(DataBusB),.a1(Immdata),.c(AlusrcB),.s(ALUSrc2));
Mux_1to2_32bits muxImm(.a0(EXTImm),.a1({Imm16,16'b0}),.c(Immdata),.s(LUOp));

Mux_1to2_32bits muxMemToReg1(.a0(ALUOut),.a1(RamData),.c(dataMemToReg),.s(MemToReg[0]));
Mux_1to2_32bits muxMemToReg2(.a0(dataMemToReg),.a1(PC4),.c(DataBusC),.s(MemToReg[1]));


Mux_2to4_5bits MuxRegDst(.a0(Rd),.a1(Rt),.a2(5'b11111),.a3(5'b11010),.c(AddrC),.s(RegDst));

Adder_32bits adder(.cin(1'b0),.A(PC4),.B({EXTImm[29:0],2'b00}),.cout(),.sum(ConBA),.cin9());

EXT_32bits extImm(.datain(Imm16),.EXTOP(EXTOp),.dataout(EXTImm));
RAM ram(.reset(reset),.clk(clk),.rd(MemRd),.wr(MemWr),.addr(ALUOut),.wdata(DataBusB),.rdata(RamData),.led(led),.switch(switch),.digi(digi),.irqout(irq));
ALU_32bits alu(.A(AlusrcA),.B(AlusrcB),.ALUFun(ALUFun),.Sign(Sign),.ALUOut(ALUOut));
RegFile regfile(.reset(reset),.clk(clk),.addr1(Rs),.data1(DataBusA),.addr2(Rt),.data2(DataBusB),.wr(RegWr),.addr3(AddrC),.data3(DataBusC));


endmodule