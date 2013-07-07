module Instruction_Part(ConBA,DataBusA,IRQ,ALUOut0,PC4,Reset,
                        Imm16,Shamt,Rd,Rt,Rs,
                        RegDst,RegWr,ALUSrc1,ALUSrc2,ALUFun,Sign,MemWr,
                        MemRd,MemToReg,EXTOp,LUOp,Clk);
input [31:0] ConBA,DataBusA;
input IRQ,ALUOut0,Clk,Reset;
output [15:0] Imm16;
output [4:0] Shamt,Rd,Rt,Rs;
output [1:0] RegDst,MemToReg;
output RegWr,ALUSrc1,ALUSrc2,Sign,MemWr,MemRd,EXTOp,LUOp;
output [5:0] ALUFun;
output [31:0] PC4;

reg [31:0] PC;
wire [31:0] Instruct,ALUOut_Def;
wire [25:0] JT;
wire [2:0] PCSrc;


ROM R(.addr(PC),.data(Instruct));

Control C(.Instruct(Instruct),.IRQ(IRQ),.JT(JT),.Imm16(Imm16),.Shamt(Shamt),
          .Rd(Rd),.Rt(Rt),.Rs(Rs),.PCSrc(PCSrc),
          .RegDst(RegDst),.RegWr(RegWr),.ALUSrc1(ALUSrc1),.ALUSrc2(ALUSrc2),
          .ALUFun(ALUFun),.Sign(Sign),.MemWr(MemWr),
          .MemRd(MemRd),.MemToReg(MemToReg),.EXTOp(EXTOp),.LUOp(LUOp));
          
parameter ILLOP=32'h80000004;
parameter XADR=32'h80000008;

assign PC4={PC[31],PC[30:0]+31'd4};

assign ALUOut_Def=PC4&{32{~ALUOut0}}|ConBA&{32{ALUOut0}};

always @ (posedge Clk)
begin
  if(Reset)
    begin
      PC<=32'h80000000;
    end
  else
  begin
  case(PCSrc)
    3'b000:PC<=PC4;
    3'b001:PC<=ALUOut_Def;
    3'b010:PC<={PC[31:28],JT,2'b0};
    3'b011:PC<=DataBusA;
    3'b100:PC<=ILLOP;
    3'b101:PC<=XADR;
    default:PC<=PC4;
  endcase
  end
end

endmodule

