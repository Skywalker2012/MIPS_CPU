#! /usr/bin//env python 
# By Skywalker 2013/6/30

#Results tested in MARS 4.3

import string

Register_Keywords = {'$zero':'00000','$at':'00001',
                     '$v0':'00010','$v1':'00011',
                     '$a0':'00100','$a1':'00101',
                     '$a2':'00110','$a3':'00111',
                     '$t0':'01000','$t1':'01001',
                     '$t2':'01010','$t3':'01011',
                     '$t4':'01100','$t5':'01101',
                     '$t6':'01110','$t7':'01111',
                     '$s0':'10000','$s1':'10001',
                     '$s2':'10010','$s3':'10011',
                     '$s4':'10100','$s5':'10101',
                     '$s6':'10110','$s7':'10111',
                     '$t8':'11000','$t9':'11001',
                     '$k0':'11010','$k1':'11011',
                     '$gp':'11100','$sp':'11101',
                     '$fp':'11110','$ra':'11111' }

Opcode_Keywords = {'nop':'000000',
                   'lw':'100011','sw':'101011','lui':'001111',
                   'add':'000000','addu':'000000',
                   'sub':'000000','subu':'000000',
                   'addi':'001000','addiu':'001001',
                   'and':'000000','or':'000000',
                   'xor':'000000','nor':'000000',
                   'andi':'001100',
                   'sll':'000000','srl':'000000','sra':'000000',
                   'slt':'000000','slti':'001010','sltiu':'001011',
                   'beq':'000100','bne':'000101',
                   'blez':'000110','bgtz':'000111','bltz':'000001',
                   'j':'000010','jal':'000011',
                   'jr':'000000','jalr':'000000' }

Type_Keywords = {'nop':'R',
                 'lw':'I','sw':'I','lui':'I',
                 'add':'R','addu':'R',
                 'sub':'R','subu':'R',
                 'addi':'I','addiu':'I',
                 'and':'R','or':'R',
                 'xor':'R','nor':'R',
                 'andi':'I',
                 'sll':'R','srl':'R','sra':'R',
                 'slt':'R','slti':'I','sltiu':'I',
                 'beq':'I','bne':'I',
                 'blez':'I','bgtz':'I','bltz':'I',
                 'j':'J','jal':'J',
                 'jr':'R','jalr':'R' }


Funct_Keywords = {'nop':'000000',
                  'lw':'','sw':'','lui':'',
                  'add':'100000','addu':'100001',
                  'sub':'100010','subu':'100011',
                  'addi':'','addiu':'',
                  'and':'100100','or':'100101',
                  'xor':'100110','nor':'100111',
                  'andi':'',
                  'sll':'000000','srl':'000010','sra':'000011',
                  'slt':'101010','slti':'','sltiu':'',
                  'beq':'','bne':'',
                  'blez':'','bgtz':'','bltz':'',
                  'j':'','jal':'',
                  'jr':'001000','jalr':'001001' }

Mode_Keywords = {'nop':'000',
                 'lw':'I','sw':'I','lui':'I',
                 'add':'231','addu':'231',
                 'sub':'231','subu':'231',
                 'addi':'I','addiu':'I',
                 'and':'231','or':'231',
                 'xor':'231','nor':'231',
                 'andi':'I',
                 'sll':'021','srl':'021','sra':'021',
                 'slt':'231','slti':'I','sltiu':'I',
                 'beq':'I','bne':'I',
                 'blez':'I','bgtz':'I','bltz':'I',
                 'j':'J','jal':'J',
                 'jr':'100','jalr':'201' }  # Not support "jalr rs"(rd = 31 implied)


RType_IsShift_Keywords = {'nop':False,
                          'add':False,'addu':False,
                          'sub':False,'subu':False,
                          'and':False,'or':False,
                          'xor':False,'nor':False,
                          'sll':True,'srl':True,'sra':True,
                          'slt':False,
                          'jr':False,'jalr':False }

#Test_data

#R-Type
Test_nop = ['nop']  #AC
Test_add = ['add','$t6','$a1','$s2']  #AC
Test_addu = ['addu','$s0','$zero','$v0']  #AC
Test_sub = ['sub','$t5','$t1','$t3']  #AC
Test_subu = ['subu','$t5','$t1','$t3']  #AC
Test_and = ['and','$t5','$t1','$t3']  #AC
Test_or = ['or','$t5','$t1','$t3']  #AC
Test_xor = ['xor','$t5','$t1','$t3']  #AC
Test_nor = ['nor','$t5','$t1','$t3']  #AC
Test_sll = ['sll','$a1','$a1','2']  #AC
Test_srl = ['srl','$a1','$a1','2']  #AC
Test_sra = ['sra','$a1','$a1','23']  #AC
Test_slt = ['slt','$s1','$s2','$s3']  #AC
Test_jr = ['jr','$ra']  #AC
Test_jalr = ['jalr','$s1','$s2']  #AC

def NumberToBinaryCode(ImNumber,length):
    if ImNumber >=0 :
        ImBinary = bin(ImNumber).replace('b','')
	if length >= len(ImBinary):
            ImBinary = (length-len(ImBinary)) * '0' + ImBinary
	else:
	    ImBinary = ImBinary[-length:]
        return ImBinary
    else:
        pass
        return False






def RTypeCode(Instruction):
    Code = Opcode_Keywords[Instruction[0]]

    for i in xrange(0,3):
	reg = string.atoi(Mode_Keywords[Instruction[0]][i])
	if reg > 0:
	    Code += Register_Keywords[Instruction[reg]]
	else:
	    Code += '00000'

    if RType_IsShift_Keywords[Instruction[0]]:
	Code += NumberToBinaryCode(string.atoi(Instruction[-1]),5)
    else:
    	Code += '00000'

    Code += Funct_Keywords[Instruction[0]]

    return Code


def ITypeCode(Instruction):
    Code = Opcode_Keywords[Instruction[0]]
    return Code
def JTypeCode(Instruction):
    Code = Opcode_Keywords[Instruction[0]]
    return Code

print RTypeCode(Test_jalr)

