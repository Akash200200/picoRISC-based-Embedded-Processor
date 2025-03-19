
`include "opcodes.svh"
//------------------------------------------------
module decoder_tb;

logic [5:0] opcode; // top 6 bits of instruction
logic [3:0] flags; // ALU flags V,N,Z,C
logic ready, br_cond; // // Branch status, connected to specified switch
// PC control, imm MUX control, register file control & Branch condition
logic PCincr, PCabsbranch, PCrelbranch;
logic [2:0] ALUfunc; // ALU function
logic imm;
logic w;
logic store, disp;

// create dec object
decoder dec (
        .opcode(opcode),
        .flags(flags),
		.ready(ready),  // Branch status
        .br_cond(br_cond), // Branch condition
        .pc_incr(PCincr),
        .pc_absbranch(PCabsbranch),
        .pc_relbranch(PCrelbranch),
        .ALUfunc(ALUfunc),
        .imm(imm),
		.w(w),
        .store(store),
		.disp(disp));
//------------------------------------------------
initial 
	begin // for 100ns
    br_cond = 1'b0; ready = 1'b1; // if Bstus == Bcond, hold status.
    flags = 4'b0;

		opcode = `NOP;  //opcode: NOP  -> 6'b111111
    #10ns opcode = `ADD;  //opcode: ADD  -> 6'b000000
		#10ns opcode = `ADDI; //opcode: ADDI -> 6'b000001
    #10ns opcode = `ADDF; //opcode: ADDF -> 6'b000110
    #10ns opcode = `MUL;  //opcode: MUL  -> 6'b000100
		#10ns opcode = `MULI; //opcode: MULI -> 6'b000101
		#10ns opcode = `BREL;  //opcode: BAT  -> 6'b000111
    #10ns ready = 1'b0; opcode = `BABS;
	#10ns ready = 1'b1; opcode = `DISP;
	end 

endmodule // end of module decoder_tb