//-----------------------------------------------------
// File Name : regs.sv
// Author: Akash
// Last rev. 19 Apr 2024
//-----------------------------------------------------

module regs #(parameter n = 8) (input logic clock, w_en, reset,
				input logic [n-1:0] w_data,
				input logic [4:0] r_addr1, r_addr2,
				output logic [n-1:0] reg_data1, reg_data2);
								
logic [n-1:0] gpr [31:0];
logic [n-1:0] next_gpr [31:0];

always_ff @ (posedge clock, negedge reset)  //write data to addr2
begin
	if (!reset)
		gpr <= '{32{'0}};
	else
		gpr <= next_gpr;
end

always_comb
begin
	next_gpr = gpr;
	if (r_addr1 == 5'b0)
		reg_data1 = {n{1'b0}};
	else 
		reg_data1 = gpr [r_addr1];
		
	if (r_addr2 == 5'b0)
		reg_data2 = {n{1'b0}};
	else 
		reg_data2 = gpr[r_addr2];
	if (w_en)
		next_gpr[r_addr2] = w_data;
		
end
endmodule
