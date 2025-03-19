module regs_tb;

parameter n = 8;

logic clock, w_en, reset;
logic [n-1:0] w_data;
logic [4:0] r_addr1, r_addr2;
logic [n-1:0] reg_data1, reg_data2;

// create regs object
regs #(.n(n)) u_reg (.*);
//------------------------------------------------
initial
begin // for 50ns
  clock = 1'b0;
  forever #5ns clock = ~clock;
end

initial
begin
	reset = 1'b0;
	#10ns reset = 1'b1;
  w_en = 1'b0;
  w_data = 8'b00000111;
  r_addr1 = 5'b00001; r_addr2 = 5'b00000;

  #10ns r_addr1 = 5'b00000; r_addr2 = 5'b00010;

  // test write 0 to dest reg (raddr2)
  #10ns w_en = 1'b1;
  @(posedge clock);
  #10ns w_en = 1'b1; w_data = 8'b00000110;
  @(posedge clock);
end

endmodule