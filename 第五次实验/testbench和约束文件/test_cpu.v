
module test_cpu();
	
	reg reset;
	reg clk;
	reg [1:0] sel;
	wire [7:0] reg_low;
	CPU cpu1(reset, clk, sel, reg_low);
	
	initial begin
		reset = 1;
		clk = 1;
		sel = 2'b0;
		#100 reset = 0;
	end
	
	always #50 clk = ~clk;
		
endmodule
