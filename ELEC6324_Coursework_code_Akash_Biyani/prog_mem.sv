//-----------------------------------------------------
// File Name : prog_mem.sv
// Author: Akash
// Last rev. 19 Apr 2024
//-----------------------------------------------------
module prog_mem #(parameter p = 6, i = 24) // p - address size, i - instruction size
					(input logic [p-1:0] addr,
					output logic [i:0] instr_code); // I - instruction code

logic [i:0] prog_mem[(1<<p)-1:0];

// access memory from hex file
initial
  $readmemh("prog.hex", prog_mem);
  
// program memory read 
always_comb
  instr_code = prog_mem[addr];
  
endmodule // end of module prog