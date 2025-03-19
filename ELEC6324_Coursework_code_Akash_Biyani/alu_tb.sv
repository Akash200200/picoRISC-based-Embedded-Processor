`include "alucodes.svh"
//------------------------------------------------
module alu_tb;

parameter n = 8; // data bus width

logic [n-1:0] a, b; // ALU input operands   
logic [2:0] func; // ALU func code
logic [3:0] flags; // ALU flags N,Z,C,V
logic [n-1:0] out; // ALU result

// create alu object
alu #(.n(n)) alu1 (.*);
//------------------------------------------------
initial    
begin // for 30ns
	a = 8'h1;
	b = 8'h3; 
	func = `RADD;   // result = a + b
	#10ns func = `RSUB;   // result = a - b
	#10ns func = `RMUL;   // result = a * b
end
endmodule