module pc_tb;

parameter p = 6;

logic clock;
logic reset;
logic pc_inc, pc_absbranch, pc_relbranch;
logic [p-1:0] branchaddr;
//logic [p-1:0] r_branch;
logic [p-1:0] pc_out;

// create pc object 
pc #(.p(p)) pc (.*);
//------------------------------------------------
initial 
begin 
	clock = 1'b0;
	forever #5ns clock = ~clock;
end

initial 
begin // for 50ns
	reset = 1'b0; 
	pc_inc = 1'b0; pc_absbranch = 1'b0; pc_relbranch = 1'b0;
	branchaddr = 5'b00000;

	// test pc increment
	#10ns reset = 1'b1; 
	pc_inc = 1'b1;
	
	// test pc relative branch
	#10ns pc_inc = 1'b0; 
	pc_relbranch = 1'b1; 
	branchaddr = 5'b00011;

	// test pc absolute branch
	#10ns pc_relbranch = 1'b0;
	pc_absbranch = 1'b1; 
	branchaddr = 5'b00010;

	// reset
	#10ns reset = 1'b0; 
end 
endmodule