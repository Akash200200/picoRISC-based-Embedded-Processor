`include "alucodes.svh"
//------------------------------------------------
module testbench;
logic clk;  // clock signal
logic reset; // nreset
logic ready; // Connect to SW[8]
logic [7:0] sw; // Switches SW0..SW7
logic [7:0] LED; // LEDs
//------------------------------------------------
// create object
picoMIPS p1 (.*);
//------------------------------------------------
initial 
begin 
	clk = 1'b0;
	forever #1ns clk = ~clk; // 50MHz Altera DE0 clock
end

initial    
begin
	//sw[8] = 1'b0;
	sw = '0;
	ready = 1'b0;
	reset = 1'b0;
	#50ns reset = 1'b1;

	// wait 0, wait 1 and input x1 twice
	#50ns ready = 1'b0;
	sw[7:0] = 8'b0010010;
	#50ns ready = 1'b1;
	

	// wait 0, wait 1 and input y1 twice
	#50ns ready = 1'b0;
	sw[7:0] = 8'b00100001;
	#50ns ready = 1'b1;

	// wait 0, calculate and display x2
	#50ns ready = 1'b0;
	
	// wait 1 and display y2
	#50ns ready = 1'b1;

	// wait 0
	#50ns ready = 1'b0;
	// repeat
	//#100 $stop;

end
endmodule // end of module picoMIPS_tb