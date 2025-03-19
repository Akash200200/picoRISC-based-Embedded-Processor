//-----------------------------------------------------
// File Name : opcodes.svh
// Author: Akash Biyani
// Last rev. 19 Apr 2024
//-----------------------------------------------------

// NOP
`define NOP  6'b000000
// ADD %d, %s;  %d = %d+%s
`define ADD  6'b000001
// ADDI %d, %s, imm ;  %d = %s + imm
`define ADDI 6'b000010
// SUB %d, %s;  %d = %d+%s
`define MUL  6'b000101
// MULI %d, %s, imm ; %d = %s * imm
`define MULI 6'b000110

`define DISP 6'b000111
//to store
`define ADDF 6'b001000

`define BREL 6'b001001

`define BABS 6'b001010


