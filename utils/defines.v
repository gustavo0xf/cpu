/* aliases para facilitar o desenvolvimento */

// opcodes da Mini-CPU 
`define LOAD    3'b000
`define ADD     3'b001
`define ADDI    3'b010
`define SUB     3'b011
`define SUBI    3'b100
`define MUL     3'b101
`define CLEAR   3'b110
`define DISPLAY 3'b111
// ordem dos bits segundo às especificações do projeto
`define OPCODE   17:15
`define DST_REG  14:11
`define SRC_REG1 10:7
`define SRC_REG2 6:3
`define SGNI     6
`define MAGI     5:0