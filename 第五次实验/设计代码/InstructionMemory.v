
module InstructionMemory(Address, Instruction);
	input [31:0] Address;
	output reg [31:0] Instruction;
	
	always @(*)
		case (Address[9:2])
			// addi $a0, $zero, 12345 #(0x3039)
			//8'd0:    Instruction <= {6'h08, 5'd0 , 5'd4 , 16'h3039};
			// addiu $a1, $zero, -11215 #(0xd431)
			//8'd1:    Instruction <= {6'h09, 5'd0 , 5'd5 , 16'hd431};
			// sll $a2, $a1, 16
			//8'd2:    Instruction <= {6'h00, 5'd0 , 5'd5 , 5'd6 , 5'd16 , 6'h00};
			// sra $a3, $a2, 16
			//8'd3:    Instruction <= {6'h00, 5'd0 , 5'd6 , 5'd7 , 5'd16 , 6'h03};
			// beq $a3, $a1, L1
			//8'd4:    Instruction <= {6'h04, 5'd7 , 5'd5 , 16'h0001};
			// lui $a0, -11111 #(0xd499)
			//8'd5:    Instruction <= {6'h0f, 5'd0 , 5'd4 , 16'hd499};
			// L1:
			// add $t0, $a2, $a0
			//8'd6:    Instruction <= {6'h00, 5'd6 , 5'd4 , 5'd8 , 5'd0 , 6'h20};
			// sra $t1, $t0, 8
			//8'd7:    Instruction <= {6'h00, 5'd0 , 5'd8 , 5'd9 , 5'd8 , 6'h03};
			// addi $t2, $zero, -12345 #(0xcfc7)
			//8'd8:    Instruction <= {6'h08, 5'd0 , 5'd10, 16'hcfc7};
			// slt $v0, $a0, $t2
			//8'd9:    Instruction <= {6'h00, 5'd4 , 5'd10 , 5'd2 , 5'd0 , 6'h2a};
			// sltu $v1, $a0, $t2
			//8'd10:   Instruction <= {6'h00, 5'd4 , 5'd10 , 5'd3 , 5'd0 , 6'h2b};
			// Loop:
			// j Loop
			//8'd11:   Instruction <= {6'h02, 26'd11};
			//default: Instruction <= 32'h00000000;

			// New instructions

			// addi $a0, $zero, 4 
			8'd0:    Instruction <= 32'b00100000000001000000000000000100;
			// jal sum
			8'd1:    Instruction <= 32'b00001100000000000000000000000011;
			// Loop: 
			// beq $zero, $zero, Loop
			8'd2:    Instruction <= 32'b00010000000000001111111111111111;
			// sum:
			// addi $sp, $sp, -8
			8'd3:    Instruction <= 32'b00100011101111011111111111111000;
			// sw $ra, 4($sp) 
			8'd4:    Instruction <= 32'b10101111101111110000000000000100;
			// sw $a0, 0($sp) 
			8'd5:    Instruction <= 32'b10101111101001000000000000000000;
			// slti $t0, $a0, 1
			8'd6:    Instruction <= 32'b00101000100010000000000000000001;
			// beq $t0, $zero, L1
			8'd7:    Instruction <= 32'b00010001000000000000000000000011;
			// xor $v0, $zero, $zero
			8'd8:    Instruction <= 32'b00000000000000000001000000100110;
			// addi $sp, $sp, 8
			8'd9:    Instruction <= 32'b00100011101111010000000000001000;
			// jr $ra
			8'd10:    Instruction <= 32'b00000011111000000000000000001000;
			// L1: 
			// addi $a0, $a0, -1
			8'd11:    Instruction <= 32'b00100000100001001111111111111111;
			// jal sum
			8'd12:    Instruction <= 32'b00001100000000000000000000000011;
			// lw $a0, 0($sp)
			8'd13:    Instruction <= 32'b10001111101001000000000000000000;
			// lw $ra, 4($sp)
			8'd14:    Instruction <= 32'b10001111101111110000000000000100;
			// addi $sp, $sp, 8
			8'd15:    Instruction <= 32'b00100011101111010000000000001000;
			// add $v0, $a0, $v0
			8'd16:    Instruction <= 32'b00000000100000100001000000100000;
			// jr $ra
			8'd17:    Instruction <= 32'b00000011111000000000000000001000;
			default:  Instruction <= 32'b0;
		endcase
		
endmodule
