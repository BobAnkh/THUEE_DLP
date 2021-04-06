module DataMemory(
    input clk,
	input rst_n,
	input [31:0] Address,
    input [31:0] Write_data,
	input MemRead,
    input MemWrite,
	output [31:0] Read_data
);
	parameter RAM_SIZE = 256;
	parameter RAM_SIZE_BIT = 8;
	
	reg [31:0] RAM_data[RAM_SIZE - 1: 0];
	assign Read_data = MemRead? RAM_data[Address[RAM_SIZE_BIT + 1:2]]: 32'h00000000;
	
	integer i;
	always @(posedge clk or negedge rst_n)
		if (~rst_n)
			for (i = 0; i < RAM_SIZE; i = i + 1)
				RAM_data[i] <= 32'h00000000;
		else 
		if (MemWrite)
			RAM_data[Address[RAM_SIZE_BIT + 1:2]] <= Write_data;
			
endmodule
