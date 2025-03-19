//-----------------------------------------------------
// File Name : alu.sv
// Author: Akash
// Last rev. 19 Apr 2024
//-----------------------------------------------------

`include "alucodes.svh"  
module alu #(parameter n =8) (input logic [n-1:0] a, b, 
								input logic [2:0] func, 
								output logic [3:0] flags,
								output logic [n-1:0] out); 

logic[n-1:0] ar,b1;   //add-sub result and temp
logic [(2*n)-1:0] temp_product;    //temp product to truncate
always_comb
begin
   if(func == `RSUB)
		b1 = ~b + 1'b1; // 2's complement
   else
		b1 = b;
ar = a+b1;
end
   
always_comb
begin
	flags = 4'b0000;
	out = 0; // initialized to avoid latches
	temp_product = '0;
	case(func)
	`RA: out = a;
	`RB: out = b;
	`RNOP : flags = 4'b0000;
	`RADD: 
		begin
			out = ar; // arithmetic addition
			flags[3] = a[7] & b[7] & ~out[7] | ~a[7] & ~b[7] & out[7]; // V (overflow)
			flags[0] = a[7] & b[7]  |  a[7] & ~out[7] | b[7] & ~out[7]; // C (Addition carry)
		end
	`RSUB:
		begin
			out = ar; // arithmetic subtraction  
			flags[3] = ~a[7] & b[7] & ~out[7] |  a[7] & ~b[7] & out[7]; // V (overflow)
			flags[0] = a[7] & ~b[7] |  a[7] & out[7] | ~b[7] & out[7]; // C (2's complement addition carry)
		end
	`RMUL:
		begin
			temp_product = a * b1;
			out = temp_product [7:0]; //truncated
			flags[3] = (~a[7] & ~b[7] & out[7]) | (~a[7] & b[7] & ~out[7]) | 
						(a[7] & ~b[7] & ~out[7]) | (a[7] & b[7] & out[7]);
		end
	
	default: ;
	endcase

	flags[1] = out == {n{1'b0}}; // Z
	flags[2] = out[n-1]; // N
end
endmodule

