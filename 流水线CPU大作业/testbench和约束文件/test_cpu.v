`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/09/13 13:31:39
// Design Name: 
// Module Name: test_cpu
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module test_cpu();
	reg reset;
	reg clk;
	wire [7:0] led;
    wire [11:0] digi;
	CPU_pipeline cpu1(clk, reset, led, digi);
	
	initial begin
		//$readmemh("G:/Xilinx/cpu_pipeline/cpu_pipeline.srcs/sim_1/new/data.txt", cpu1.memory.dataram.RAM_data);
		reset = 1;
		clk = 1;
		#5 reset = 0;
		#5 reset = 1;
	end
	
	always #5 clk = ~clk;
endmodule
