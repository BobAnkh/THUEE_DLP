`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/09/07 15:49:50
// Design Name: 
// Module Name: cpu_pipeline
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


module CPU_pipeline(
    input clk,
    input rst_n,
    output [7:0] led,
    output [11:0] digi
    );

wire [31:0] IF_ID_Instruction;
wire [31:0] IF_ID_PC_plus_4;
wire [31:0] PCInt;
wire [31:0] branch_target;
wire [31:0] jump_target;
wire [31:0] jr_target;
wire [2:0] PCSrc;
wire [31:0] PC;
wire DataHazard;
wire JumpHazard;
wire BranchHazard;

wire Supervise = PC[31];
wire IRQ;
wire Exception;

wire EX_MEM_RegWrite;
wire [4:0] EX_MEM_WriteAddr;
wire MEM_WB_RegWrite;
wire [4:0] MEM_WB_WriteAddr;
wire [31:0] MEM_WB_WriteData;
wire EX_MEM_MemRead;

wire [31:0] ID_EX_rs_data;
wire [31:0] ID_EX_rt_data;
wire ID_EX_RegWrite;
wire [4:0] ID_EX_WriteAddr;
wire ID_EX_MemRead;
wire ID_EX_MemWrite;
wire [1:0] ID_EX_MemToReg;
wire ID_EX_ALUSrc1;
wire ID_EX_ALUSrc2;
wire [31:0] ID_EX_LU_out;
wire [1:0] ID_EX_ForwardA;
wire [1:0] ID_EX_ForwardB;
wire ID_EX_Forward_MEM;
wire [31:0] ID_EX_PC_plus_4;
wire [3:0] ID_EX_ALUOp;
wire [5:0] ID_EX_Funct;
wire [4:0] ID_EX_Shamt;

wire [31:0] EX_MEM_ALU_OUT;
wire [31:0] EX_MEM_rt_data;
wire [31:0] EX_MEM_PC_plus_4;
wire EX_MEM_MemWrite;
wire [1:0] EX_MEM_MemToReg;
wire EX_MEM_Forward_MEM;

IF instructionfetch(
    .clk(clk),
    .rst_n(rst_n),
    .PCWrite(~DataHazard || ((IRQ || Exception) && ~Supervise)),
    .IF_ID_Flush(JumpHazard || BranchHazard || ((IRQ || Exception) && ~Supervise)),
    .IF_ID_Stall(DataHazard && ~((IRQ || Exception) && ~Supervise)),
    .branch_target(branch_target),
    .jump_target(jump_target),   
    .jr_target(jr_target),     
    .PCSrc(PCSrc),
    .IF_ID_Instruction(IF_ID_Instruction),
    .IF_ID_PC_plus_4(IF_ID_PC_plus_4),
    .PC(PC)
);
PCInt pcint(
    .clk(clk),
    .rst_n(rst_n),
    .PCIntWrite(~(DataHazard || JumpHazard || BranchHazard|| ((IRQ || Exception) && ~Supervise))),
    .PC(PC),
    .PCInt(PCInt)
    );

ID instructiondecode(
    .clk(clk),
    .rst_n(rst_n),
    .instruction(IF_ID_Instruction),
    .PC_plus_4(IF_ID_PC_plus_4),
    .PC_Interrupt(PCInt),
    .EX_MEM_RegWrite(EX_MEM_RegWrite),
    .EX_MEM_WriteAddr(EX_MEM_WriteAddr),
    .MEM_WB_RegWrite(MEM_WB_RegWrite),
    .MEM_WB_WriteAddr(MEM_WB_WriteAddr),
    .MEM_WB_WriteData(MEM_WB_WriteData),
    .EX_Forward(EX_MEM_ALU_OUT),
    .EX_MEM_MemRead(EX_MEM_MemRead),
    .IRQ(IRQ),
    .PCSrc(PCSrc),
    .BranchHazard(BranchHazard),
    .branch_target(branch_target), 
    .jump_target(jump_target), 
    .jr_target(jr_target),
    .exception(Exception),
    .DataHazard(DataHazard),
    .JumpHazard(JumpHazard),
    .ID_EX_rs_data(ID_EX_rs_data),
    .ID_EX_rt_data(ID_EX_rt_data),
    .ID_EX_RegWrite(ID_EX_RegWrite),
    .ID_EX_WriteAddr(ID_EX_WriteAddr),
    .ID_EX_MemRead(ID_EX_MemRead),
	.ID_EX_MemWrite(ID_EX_MemWrite),
	.ID_EX_MemToReg(ID_EX_MemToReg),
	.ID_EX_ALUSrc1(ID_EX_ALUSrc1),
	.ID_EX_ALUSrc2(ID_EX_ALUSrc2),
    .ID_EX_LU_out(ID_EX_LU_out),
    .ID_EX_ForwardA(ID_EX_ForwardA),
    .ID_EX_ForwardB(ID_EX_ForwardB),
    .ID_EX_Forward_MEM(ID_EX_Forward_MEM),
    .ID_EX_PC_plus_4(ID_EX_PC_plus_4),
    .ID_EX_ALUOp(ID_EX_ALUOp),
    .ID_EX_Funct(ID_EX_Funct),
    .ID_EX_Shamt(ID_EX_Shamt)
);

EX excution(
    .clk(clk),
    .rst_n(rst_n),
    .ID_EX_rs_data(ID_EX_rs_data),
    .ID_EX_rt_data(ID_EX_rt_data),
    .ID_EX_RegWrite(ID_EX_RegWrite),
    .ID_EX_WriteAddr(ID_EX_WriteAddr),
    .ID_EX_MemRead(ID_EX_MemRead),
	.ID_EX_MemWrite(ID_EX_MemWrite),
	.ID_EX_MemToReg(ID_EX_MemToReg),
	.ID_EX_ALUSrc1(ID_EX_ALUSrc1),
	.ID_EX_ALUSrc2(ID_EX_ALUSrc2),
    .ID_EX_LU_out(ID_EX_LU_out),
    .ID_EX_ForwardA(ID_EX_ForwardA),
    .ID_EX_ForwardB(ID_EX_ForwardB),
    .ID_EX_Forward_MEM(ID_EX_Forward_MEM),
    .ID_EX_PC_plus_4(ID_EX_PC_plus_4),
    .ID_EX_ALUOp(ID_EX_ALUOp),
    .ID_EX_Funct(ID_EX_Funct),
    .ID_EX_Shamt(ID_EX_Shamt),
    .MEM_Forward(MEM_WB_WriteData),
    .EX_MEM_ALU_OUT(EX_MEM_ALU_OUT),
    .EX_MEM_rt_data(EX_MEM_rt_data),
    .EX_MEM_PC_plus_4(EX_MEM_PC_plus_4),
    .EX_MEM_RegWrite(EX_MEM_RegWrite),
    .EX_MEM_WriteAddr(EX_MEM_WriteAddr),
    .EX_MEM_MemRead(EX_MEM_MemRead),
	.EX_MEM_MemWrite(EX_MEM_MemWrite),
	.EX_MEM_MemToReg(EX_MEM_MemToReg),
    .EX_MEM_Forward_MEM(EX_MEM_Forward_MEM)
);

MEM memory(
    .clk(clk),
    .rst_n(rst_n),
    .EX_MEM_ALU_OUT(EX_MEM_ALU_OUT),
    .EX_MEM_rt_data(EX_MEM_rt_data),
    .EX_MEM_PC_plus_4(EX_MEM_PC_plus_4),
    .EX_MEM_RegWrite(EX_MEM_RegWrite),
    .EX_MEM_WriteAddr(EX_MEM_WriteAddr),
    .EX_MEM_MemRead(EX_MEM_MemRead),
	.EX_MEM_MemWrite(EX_MEM_MemWrite),
	.EX_MEM_MemToReg(EX_MEM_MemToReg),
    .EX_MEM_Forward_MEM(EX_MEM_Forward_MEM),
    .MEM_WB_MEM_OUT(MEM_WB_WriteData),
    .MEM_WB_WriteAddr(MEM_WB_WriteAddr),
    .MEM_WB_RegWrite(MEM_WB_RegWrite),
    .led(led),
    .digi(digi),
    .IRQ(IRQ)
);

endmodule
