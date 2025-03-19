`include "alucodes.svh"
`include "opcodes.svh"
//---------------------------------------------------------
module decoder ( input logic [5:0] opcode, // top 6 bits of instruction
				input [3:0] flags, // ALU flags
				input logic ready, br_cond,  //branch condition
				output logic pc_incr, pc_absbranch, pc_relbranch, //    PC control
				output logic [2:0] ALUfunc, //    ALU control
				output logic imm,	//// imm mux control
				output logic w,  //   register file control
				output logic store, disp); 

logic branch;

always_comb 
begin
	pc_incr = 1'b1;
	pc_absbranch = 1'b0;
	pc_relbranch = 1'b0;
	w = '0;
	ALUfunc = `RNOP;
	imm = 1'b0;
	store = 1'b0;
	disp = 1'b0;
	branch = 1'b0;
	
	case (opcode)
		`NOP	:;
		`ADD	:begin 
					w = 1'b1;
					ALUfunc = `RADD;
					imm = 1'b0;
				 end
		`ADDI	:begin 
					w = 1'b1;
					imm = 1'b1;
					store = 1'b0;
					ALUfunc = `RADD;
				 end
		`MUL	:begin 
					w = 1'b1;
					imm = 1'b0;
					ALUfunc = `RMUL;
				 end
		`MULI	:begin 
					w = 1'b1;
					imm = 1'b1;
					store = 1'b0;
					ALUfunc = `RMUL;
				 end
		`DISP	:begin
					disp = 1'b1;
					imm = 1'b0;
					ALUfunc = `RADD;
				end
		`ADDF	:begin
					store = 1'b1;
					ALUfunc = `RADD;
				end	
		`BREL  :begin
					if (ready == br_cond)
						branch = 1'b1;
				end
		`BABS  :begin
					pc_absbranch = 1'b0;
					pc_incr = 1'b0;
				end
	endcase
	if (branch)
	begin
		pc_relbranch = 1'b1;
		pc_incr = 1'b0;
	end
end
endmodule