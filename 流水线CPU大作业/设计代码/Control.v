
module Control(
	input Supervise,
	input [5:0] OpCode,
	input [5:0] Funct,
    input IRQ,
	output Branch,
	output [2:0] BranchOp,
	output [2:0] PCSrc,
	output RegWrite,
	output [1:0] RegDst,
	output MemRead,
	output MemWrite,
	output [1:0] MemToReg,
	output ALUSrc1,
	output ALUSrc2,
	output ExtOp,
	output LuOp,
	output [3:0] ALUOp,
    output Exception
);

assign Branch = ((OpCode == 6'h04 || OpCode == 6'h05 || OpCode == 6'h06 || OpCode == 6'h07 || OpCode == 6'h01) && ~((IRQ || Exception) && ~Supervise))?1'b1:1'b0;
assign BranchOp = (OpCode == 6'h05)?3'b001:
	(OpCode == 6'h06)?3'b010:
	(OpCode == 6'h07)?3'b011:
	(OpCode == 6'h01)?3'b100:
	3'b000;
assign Exception = ((OpCode == 6'h00 && (Funct == 6'h08 ||
Funct == 6'h09 || Funct == 6'h20 || Funct == 6'h21 || Funct == 6'h22 || Funct == 6'h23 ||
Funct == 6'h24 || Funct == 6'h25 || Funct == 6'h26 || Funct == 6'h27 || Funct == 6'h0 ||
Funct == 6'h02 || Funct == 6'h03 || Funct == 6'h04 || Funct == 6'h06 || Funct == 6'h2a || Funct == 6'h2b)) ||
(OpCode == 6'h04 || OpCode == 6'h05 || OpCode == 6'h06 || OpCode == 6'h07 || OpCode == 6'h01) ||
OpCode == 6'h02 || OpCode == 6'h03 || OpCode == 6'h23 || OpCode == 6'h2b || OpCode == 6'h0f || OpCode == 6'h08 || OpCode == 6'h09 || 
OpCode == 6'h0a || OpCode == 6'h0b || OpCode == 6'h0c || OpCode == 6'h0d)?1'b0:1'b1;
assign PCSrc[2:0] = 
	( ~Supervise && Exception)?3'b101:
	( ~Supervise && IRQ)?3'b100:
	(OpCode == 6'h00 && (Funct == 6'h08 || Funct == 6'h09))?3'b011:	//jr jalr
	(OpCode == 6'h02 || OpCode == 6'h03)?3'b010:		//j jal
	(OpCode == 6'h04 || OpCode == 6'h05 || OpCode == 6'h06 || OpCode == 6'h07 || OpCode == 6'h01)?3'b001:	//branch
	3'b000;
assign RegWrite = (((IRQ || Exception) && ~Supervise) || ~(OpCode == 6'h2b || OpCode == 6'h01 || OpCode == 6'h04 || OpCode == 6'h05 || OpCode == 6'h06 || OpCode == 6'h07 || OpCode == 6'h02 ||(OpCode == 6'h00 && Funct == 6'h08)))?1'b1:1'b0;
// RegDst 2'b 11 是 IRQ 或 exception, 2'b10 是 jal, 2'b00 是 rt, 2'b01 是 rd
assign RegDst[1:0] = ((IRQ || Exception) && ~Supervise)?2'b11:(OpCode == 6'h03)?2'b10: (OpCode == 6'h0)?2'b01:2'b00;
assign MemRead = (OpCode == 6'h23 && ~((IRQ || Exception) && ~Supervise))?1'b1:1'b0;
assign MemWrite = (OpCode == 6'h2b && ~((IRQ || Exception) && ~Supervise))?1'b1:1'b0;
// MemToReg 2'b10 是 pc, 2'b01 是 mem.out, 2'b0 是 alu.out
assign MemToReg[1:0] = (((IRQ || Exception) && ~Supervise) || OpCode == 6'h03 || (OpCode == 6'h00 && Funct == 6'h09))?2'b10: (OpCode == 6'h23)?2'b01:2'b00;
assign ALUSrc1 = (OpCode == 6'h00 && (Funct == 6'h00 || Funct == 6'h02  || Funct == 6'h03 ))? 1'b1:1'b0;
assign ALUSrc2 = (OpCode == 6'h00)?1'b0:1'b1;
assign ExtOp = (OpCode == 6'h0c || OpCode == 6'h0d)?1'b0:1'b1;
assign LuOp = (OpCode == 6'h0f)?1'b1:1'b0;

assign ALUOp[2:0] = 
	(OpCode == 6'h00)? 3'b010: 
	(OpCode == 6'h04)? 3'b001: 
	(OpCode == 6'h0c)? 3'b100: 
	(OpCode == 6'h0d)? 3'b110:
	(OpCode == 6'h0a || OpCode == 6'h0b)? 3'b101: 
	3'b000;

assign ALUOp[3] = OpCode[0];

endmodule