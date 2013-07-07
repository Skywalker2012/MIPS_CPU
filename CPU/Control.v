module Control(Instruct,IRQ,JT,Imm16,Shamt,Rd,Rt,Rs,PCSrc,
               RegDst,RegWr,ALUSrc1,ALUSrc2,ALUFun,Sign,MemWr,
               MemRd,MemToReg,EXTOp,LUOp);
  input [31:0] Instruct;
  input IRQ;
  output [25:0] JT;
  output [15:0] Imm16;
  output [4:0] Shamt,Rd,Rt,Rs;
  output [2:0] PCSrc;
  output [1:0] RegDst,MemToReg;
  output RegWr,ALUSrc1,ALUSrc2,Sign,MemWr,MemRd,EXTOp,LUOp;
  output [5:0] ALUFun;
  
  assign JT=Instruct[25:0];
  assign Imm16=Instruct[15:0];
  assign Shamt=Instruct[10:6];
  assign Rd=Instruct[15:11];
  assign Rt=Instruct[20:16];
  assign Rs=Instruct[25:21];
  
  wire def_R1,def_R2,def_R3,def_I1,def_I2,def_I3,def_J,def_error,nop;
  
  assign def_R1=(~Instruct[31]&~Instruct[30]&~Instruct[29]&~Instruct[28]&~Instruct[27]&~Instruct[26])&
                (~Instruct[10]&~Instruct[9]&~Instruct[8]&~Instruct[7]&~Instruct[6])&
                (Instruct[5]&~Instruct[4]&(~Instruct[3]|(~Instruct[2]&Instruct[1]&~Instruct[0])));
                //???R????xor,subu,sub,add,addu,and,nor,or,slt
  
  assign def_R2=(~Instruct[31]&~Instruct[30]&~Instruct[29]&~Instruct[28]&~Instruct[27]&~Instruct[26]&
                 ~Instruct[10]&~Instruct[9]&~Instruct[8]&~Instruct[7]&~Instruct[6]&
                 ~Instruct[20]&~Instruct[19]&~Instruct[18]&~Instruct[17]&~Instruct[16]&
                 ~Instruct[5]&~Instruct[4]&Instruct[3]&~Instruct[2]&~Instruct[1]&
                 (Instruct[0]|(~Instruct[0]&~Instruct[15]&~Instruct[14]&~Instruct[13]&~Instruct[12]&~Instruct[11])));
                 //???????R????jr,jalr
                 
  assign def_R3=(~Instruct[31]&~Instruct[30]&~Instruct[29]&~Instruct[28]&~Instruct[27]&~Instruct[26]&
                 ~Instruct[25]&~Instruct[24]&~Instruct[23]&~Instruct[22]&~Instruct[21]&
                 ~Instruct[5]&~Instruct[4]&~Instruct[3]&~Instruct[2]&(Instruct[1]|~Instruct[0]));
                 //???R????sll,sra,srl
  
  assign def_J=(~Instruct[31]&~Instruct[30]&~Instruct[29]&~Instruct[28]&Instruct[27]);//?????J????j,jal

  assign def_I1=(~Instruct[31]&~Instruct[30]&Instruct[29]&(~Instruct[28]|~Instruct[27]&~Instruct[26]));
                //??I????addi,addiu,andi,slti,sltiu
  
  assign def_I2=(~Instruct[31]&~Instruct[30]&~Instruct[29]&
                (Instruct[28]&~Instruct[27]|((Instruct[28]&Instruct[27]|~Instruct[28]&~Instruct[27]&Instruct[26])&
                 ~Instruct[20]&~Instruct[19]&~Instruct[18]&~Instruct[17]&~Instruct[16])));
                 //??I????beq,bgtz,blez,bltz,bne
  
  assign def_I3=(~Instruct[30]&Instruct[27]&Instruct[26]&
                (Instruct[31]&~Instruct[28]|~Instruct[31]&Instruct[28]&Instruct[29]&
                 ~Instruct[25]&~Instruct[24]&~Instruct[23]&~Instruct[22]&~Instruct[21]));
                 //??I????lui,lw,sw
                 
  assign nop=~(|Instruct);//nop??
  
  assign def_error=~def_R1&~def_R2&~def_R3&~def_I1&~def_I2&~def_I3&~def_J&~nop;//????
  
  assign PCSrc[0]=(def_I2|def_R2)&~IRQ|def_error;
  assign PCSrc[1]=(def_J|def_R2)&~IRQ;
  assign PCSrc[2]=IRQ|def_error;
  //PCSrc?????
  
  assign RegDst[0]=def_I1|def_I2|def_I3|IRQ|def_error;
  assign RegDst[1]=IRQ|def_error|(~Instruct[31]&~Instruct[30]&~Instruct[29]&~Instruct[28]&Instruct[27]&Instruct[26]);
  //RegDst?????
  
  assign EXTOp=~(~Instruct[31]&~Instruct[30]&Instruct[29]&(~Instruct[28]&Instruct[26]|Instruct[28]&~Instruct[27]&~Instruct[26]));
  //EXTOp?????
  
  assign LUOp=(~Instruct[31]&~Instruct[30]&Instruct[29]&Instruct[28]&Instruct[27]&Instruct[26]&
               ~Instruct[25]&~Instruct[24]&~Instruct[23]&~Instruct[22]&~Instruct[21]);
  //LUOp?????
  
  assign ALUSrc1=def_R3;
  assign ALUSrc2=def_I1|def_I3;
  //ALUSrc?????
  
  assign Sign=~((~Instruct[31]&~Instruct[30]&~Instruct[29]&~Instruct[28]&~Instruct[27]&~Instruct[26]&
               ~Instruct[10]&~Instruct[9]&~Instruct[8]&~Instruct[7]&~Instruct[6]&
               Instruct[5]&~Instruct[4]&~Instruct[3]&~Instruct[2]&Instruct[0])|
               (~Instruct[31]&~Instruct[30]&Instruct[29]&~Instruct[28]&Instruct[26])|
               (Instruct[31]&~Instruct[30]&~Instruct[28]&Instruct[27]&Instruct[26]));
  //Sign?????
  
  assign MemRd=(Instruct[31]&~Instruct[30]&~Instruct[29]&~Instruct[28]&Instruct[27]&Instruct[26])&~IRQ;
  //MemRd???
  
  assign MemWr=(Instruct[31]&~Instruct[30]&Instruct[29]&~Instruct[28]&Instruct[27]&Instruct[26])&~IRQ;
  //MemWr???
  
  assign RegWr=(def_R1|def_R3|def_I1|def_I3|def_error|IRQ|(
                ~Instruct[31]&~Instruct[30]&~Instruct[29]&~Instruct[28]&~Instruct[27]&~Instruct[26]&
                ~Instruct[20]&~Instruct[19]&~Instruct[18]&~Instruct[17]&~Instruct[16]&
                ~Instruct[10]&~Instruct[9]&~Instruct[8]&~Instruct[7]&~Instruct[6]&
                ~Instruct[5]&~Instruct[4]&Instruct[3]&~Instruct[2]&~Instruct[1]&Instruct[0])|
               (~Instruct[31]&~Instruct[30]&~Instruct[29]&~Instruct[28]&Instruct[27]&Instruct[26]))&
               ~nop&~(Instruct[31]&~Instruct[30]&Instruct[29]&~Instruct[28]&Instruct[27]&Instruct[26]&~IRQ);
  //RegWr???
  
  assign MemToReg[0]=Instruct[31]&~Instruct[30]&~Instruct[29]&~Instruct[28]&Instruct[27]&Instruct[26]&~IRQ;
  assign MemToReg[1]=(~Instruct[31]&~Instruct[30]&~Instruct[29]&~Instruct[28]&Instruct[27]&Instruct[26])|
                     (~Instruct[31]&~Instruct[30]&~Instruct[29]&~Instruct[28]&~Instruct[27]&~Instruct[26]&
                      ~Instruct[20]&~Instruct[19]&~Instruct[18]&~Instruct[17]&~Instruct[16]&
                      ~Instruct[10]&~Instruct[9]&~Instruct[8]&~Instruct[7]&~Instruct[6]&
                      ~Instruct[5]&~Instruct[4]&Instruct[3]&~Instruct[2]&~Instruct[1]&Instruct[0])|
                      def_error|IRQ;
  //MemToReg???
  
  assign ALUFun[0]=(~Instruct[31]&~Instruct[30]&~Instruct[29]&~Instruct[28]&~Instruct[27]&~Instruct[26]&
                   ((~Instruct[10]&~Instruct[9]&~Instruct[8]&~Instruct[7]&~Instruct[6]&Instruct[5]&~Instruct[4]&Instruct[1]&
                    (~Instruct[3]&Instruct[0]|~Instruct[2]&~Instruct[0]))|
                    (~Instruct[25]&~Instruct[24]&~Instruct[23]&~Instruct[22]&~Instruct[21]&
                    ~Instruct[5]&~Instruct[4]&~Instruct[3]&~Instruct[2]&Instruct[1])))|
                    (def_I2|(~Instruct[31]&~Instruct[30]&Instruct[29]&~Instruct[28]&Instruct[27]));
  assign ALUFun[1]=(def_R2|(~Instruct[31]&~Instruct[30]&~Instruct[29]&~Instruct[28]&~Instruct[27]&~Instruct[26]&
                    ((~Instruct[10]&~Instruct[9]&~Instruct[8]&~Instruct[7]&~Instruct[6]&
                     Instruct[5]&~Instruct[4]&~Instruct[3]&Instruct[2]&(Instruct[0]^Instruct[1]))|
                     (~Instruct[25]&~Instruct[24]&~Instruct[23]&~Instruct[22]&~Instruct[21]&
                     ~Instruct[5]&~Instruct[4]&~Instruct[3]&~Instruct[2]&Instruct[1]&Instruct[0]))))|
                   (~Instruct[31]&~Instruct[30]&Instruct[28]&(Instruct[27]&Instruct[26]|
                   ~Instruct[29]&~Instruct[27]&~Instruct[26]));
  assign ALUFun[2]=(~Instruct[31]&~Instruct[30]&~Instruct[29]&~Instruct[28]&~Instruct[27]&~Instruct[26]&
                    ~Instruct[10]&~Instruct[9]&~Instruct[8]&~Instruct[7]&~Instruct[6]&
                    Instruct[5]&~Instruct[4]&((~Instruct[3]&Instruct[2]&~Instruct[1]&Instruct[0])
                    |(~Instruct[3]&Instruct[2]&Instruct[1]&~Instruct[0])|(Instruct[3]&~Instruct[2]&Instruct[1]&~Instruct[0])))|
                    (~Instruct[31]&~Instruct[30]&((~Instruct[29]&Instruct[28]&Instruct[27])|
                    (Instruct[29]&~Instruct[28]&Instruct[27])|(Instruct[28]&Instruct[27]&Instruct[26])|
                    (~Instruct[29]&~Instruct[28]&~Instruct[27]&Instruct[26])));
  assign ALUFun[3]=(def_R2|(~Instruct[31]&~Instruct[30]&~Instruct[29]&~Instruct[28]&~Instruct[27]&~Instruct[26]&
                    ~Instruct[10]&~Instruct[9]&~Instruct[8]&~Instruct[7]&~Instruct[6]&
                     Instruct[5]&~Instruct[4]&~Instruct[3]&Instruct[2]&~Instruct[1]))|
                    (~Instruct[31]&~Instruct[30]&Instruct[28]&((Instruct[29]&~Instruct[27]&~Instruct[26])|
                    (~Instruct[29]&Instruct[27])|(Instruct[27]&Instruct[26])));
  assign ALUFun[4]=(def_R2|(~Instruct[31]&~Instruct[30]&~Instruct[29]&~Instruct[28]&~Instruct[27]&~Instruct[26]&
                    ~Instruct[10]&~Instruct[9]&~Instruct[8]&~Instruct[7]&~Instruct[6]&Instruct[5]&~Instruct[4]
                    &(~Instruct[3]&Instruct[2]|Instruct[3]&~Instruct[2]&Instruct[1]&~Instruct[0])))|
                    (def_I2|(~Instruct[31]&~Instruct[30]&Instruct[29]&((Instruct[28]&~Instruct[27]&~Instruct[26])|
                    (Instruct[27]&Instruct[26])|(~Instruct[28]&Instruct[27]))));
  assign ALUFun[5]=(def_R3|(~Instruct[31]&~Instruct[30]&~Instruct[29]&~Instruct[28]&~Instruct[27]&~Instruct[26]&
                    ~Instruct[10]&~Instruct[9]&~Instruct[8]&~Instruct[7]&~Instruct[6]&
                    Instruct[5]&~Instruct[4]&Instruct[3]&~Instruct[2]&Instruct[1]&~Instruct[0]))|
                    (def_I2|(~Instruct[31]&~Instruct[30]&Instruct[29]&~Instruct[28]&Instruct[27]));
  //ALUFun?????
  
endmodule