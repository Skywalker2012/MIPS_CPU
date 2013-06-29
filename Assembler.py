#! /usr/bin//env python 
# By Skywalker 2013/6/30

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

Shamt_Keywords = {'nop':'00000',
                  'lw':'','sw':'','lui':'',
                  'add':'00000','addu':'00000',
                  'sub':'00000','subu':'00000',
                  'addi':'','addiu':'',
                  'and':'00000','or':'00000',
                  'xor':'00000','nor':'00000',
                  'andi':'',
                  'sll':'sa','srl':'sa','sra':'sa',
                  'slt':'00000','slti':'','sltiu':'',
                  'beq':'','bne':'',
                  'blez':'','bgtz':'','bltz':'',
                  'j':'','jal':'',
                  'jr':'00000','jalr':'00000' }

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

def NumberToBinaryCode(ImNumber,length):
    ImBinary = bin(ImNumber).replace('b','')
    ImBinary = (length-len(ImBinary)) * '0' + ImBinary
    return ImBinary

