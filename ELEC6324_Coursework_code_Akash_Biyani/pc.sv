//-----------------------------------------------------
// File Name : regs.sv
// Function : picoMIPS 32 x n registers, %0 == 0
// Version 1 :
// Author: Akash
// Last rev. 19 Apr 2024
//-----------------------------------------------------

module pc #(parameter p = 6) (input logic clock, reset,
				input logic pc_inc, pc_relbranch, pc_absbranch,
				input logic [p-1:0] branchaddr,
				output logic [p-1:0] pc_out);
				
logic [p-1:0] temp_branch;
logic [p-1:0] pc_out_next;

always_comb
begin
pc_out_next = '0;
if (pc_inc)
	temp_branch = {{(p-1) {1'b0}}, 1'b1}; // increment by 1
else 
	temp_branch = branchaddr;
if (pc_inc | pc_relbranch)
		pc_out_next = pc_out + temp_branch;
else if (pc_absbranch)
		pc_out_next = branchaddr;	

end

always_ff @(posedge clock, negedge reset)
begin
	if (!reset)
		pc_out <= {(p){1'b0}};
	else 	
		pc_out <= pc_out_next;
end
endmodule
				
