module ID (
    input clk,
    input rst_n,
    input [31:0] instruction,
    input [31:0] PC_plus_4,
    input [31:0] PC_Interrupt,
    input EX_MEM_RegWrite,
    input [4:0] EX_MEM_WriteAddr,
    input MEM_WB_RegWrite,
    input [4:0] MEM_WB_WriteAddr,
    input [31:0] MEM_WB_WriteData,
    input [31:0] EX_Forward,
    input EX_MEM_MemRead,
    input IRQ,
    output [2:0] PCSrc,
    output BranchHazard,
    output [31:0] branch_target, 
    output [31:0] jump_target, 
    output [31:0] jr_target,
    output exception,
    output DataHazard,
    output JumpHazard,
    output reg [31:0] ID_EX_rs_data,
    output reg [31:0] ID_EX_rt_data,
    output reg ID_EX_RegWrite,
    output reg [4:0] ID_EX_WriteAddr,
    output reg ID_EX_MemRead,
	output reg ID_EX_MemWrite,
	output reg [1:0] ID_EX_MemToReg,
	output reg ID_EX_ALUSrc1,
	output reg ID_EX_ALUSrc2,
    output reg [31:0] ID_EX_LU_out,
    output reg [1:0] ID_EX_ForwardA,
    output reg [1:0] ID_EX_ForwardB,
    output reg ID_EX_Forward_MEM,
    output reg [31:0] ID_EX_PC_plus_4,
    output reg [3:0] ID_EX_ALUOp,
    output reg [5:0] ID_EX_Funct,
    output reg [4:0] ID_EX_Shamt
);
wire Supervise = PC_plus_4[31];
wire [5:0] inst_OpCode, inst_funct;
wire [4:0] inst_rs, inst_rt, inst_rd, inst_shamt;
wire [15:0] inst_imm;
wire [25:0] inst_target_addr;
wire [31:0] ID_rs, ID_rt;               //直接从寄存器中读取的结构
wire [31:0] ID_rs_data, ID_rt_data;     //从寄存器结果和转发中挑选的结果

assign inst_OpCode = instruction[31:26];
assign inst_rs = instruction[25:21];
assign inst_rt = instruction[20:16];
assign inst_rd = instruction[15:11];
assign inst_shamt = instruction[10:6];
assign inst_funct = instruction[5:0];
assign inst_imm = instruction[15:0];
assign inst_target_addr = instruction[25:0];


RegisterFile registerfile(
    .rst_n(rst_n), .clk(clk),
    .RegWrite(MEM_WB_RegWrite),
    .Read_register1(inst_rs),
    .Read_register2(inst_rt),
    .Write_register(MEM_WB_WriteAddr),
    .Write_data(MEM_WB_WriteData),
    .Read_data1(ID_rs),
    .Read_data2(ID_rt)
);

wire ExtOp;
wire LuOp;
wire Branch;
wire [2:0] BranchOp;

wire [3:0] ALUOp;
wire RegWrite;
wire [1:0] RegDst;
wire MemRead;
wire MemWrite;
wire [1:0] MemToReg;
wire ALUSrc1;
wire ALUSrc2;


Control control(
    .Supervise(Supervise),
	.OpCode(inst_OpCode),
	.Funct(inst_funct),
    .IRQ(IRQ),
	.Branch(Branch),
    .BranchOp(BranchOp),
	.PCSrc(PCSrc),
	.RegWrite(RegWrite),
	.RegDst(RegDst),
	.MemRead(MemRead),
	.MemWrite(MemWrite),
	.MemToReg(MemToReg),
	.ALUSrc1(ALUSrc1),
	.ALUSrc2(ALUSrc2),
	.ExtOp(ExtOp),
	.LuOp(LuOp),
	.ALUOp(ALUOp),
    .Exception(exception)
);

wire [1:0] ForwardA_ID;
wire [1:0] ForwardB_ID;
wire [1:0] ForwardA_EX;
wire [1:0] ForwardB_EX;
wire Forward_MEM;

Forward forward(
    .rst_n(rst_n),
    .rs(inst_rs),
    .rt(inst_rt),
    .ID_EX_RegWrite(ID_EX_RegWrite),
    .ID_EX_WriteAddr(ID_EX_WriteAddr),
    .EX_MEM_RegWrite(EX_MEM_RegWrite),
    .EX_MEM_WriteAddr(EX_MEM_WriteAddr),
    .MEM_WB_RegWrite(MEM_WB_RegWrite),
    .MEM_WB_WriteAddr(MEM_WB_WriteAddr),
    .ForwardA_ID(ForwardA_ID),
    .ForwardB_ID(ForwardB_ID),
    .ForwardA_EX(ForwardA_EX),
    .ForwardB_EX(ForwardB_EX),
    .Forward_MEM(Forward_MEM)
);

wire [4:0] WriteAddr;
assign WriteAddr = (RegDst == 2'b00)?inst_rt:
        (RegDst == 2'b01)?inst_rd:
        (RegDst == 2'b10)?5'd31: // $ra
        5'd26; // $k0 Exception

assign ID_rs_data = (ForwardA_ID==2'b10)?EX_Forward:(ForwardA_ID==2'b01)?MEM_WB_WriteData:ID_rs;
assign ID_rt_data = (ForwardB_ID==2'b10)?EX_Forward:(ForwardB_ID==2'b01)?MEM_WB_WriteData:ID_rt;

wire [31:0] Ext_out;
assign Ext_out = {ExtOp?{16{inst_imm[15]}}:16'h0000, inst_imm[15:0]};
wire [31:0] LU_out;
assign LU_out = LuOp?{inst_imm[15:0], 16'h0000}:Ext_out;

wire ConBA;
assign ConBA = (BranchOp == 3'b001)?(~(ID_rs_data == ID_rt_data)):
    (BranchOp == 3'b010)?(~(~ID_rs_data[31] && |ID_rt_data)):
    (BranchOp == 3'b011)?(~ID_rs_data[31] && |ID_rt_data):
    (BranchOp == 3'b100)?(ID_rs_data[31]):
    (ID_rs_data == ID_rt_data);
// BranchHazard和JumpHazard需要flush掉IF/ID
assign BranchHazard = Branch & ConBA;
assign branch_target = (BranchHazard)?(PC_plus_4 + {LU_out[29:0], 2'b00}):PC_plus_4;
assign jump_target = {PC_plus_4[31:28], inst_target_addr, 2'b00};
assign jr_target = ID_rs_data;
assign JumpHazard = (PCSrc == 3'b010) || (PCSrc == 3'b011);

// DataHazard发生的时候要flush掉ID/EX并stall住IF/ID和PC

Hazard hazard(
    .PCSrc(PCSrc),
    .ID_EX_MemRead(ID_EX_MemRead),
    .EX_MEM_MemRead(EX_MEM_MemRead),
    .ID_MemWrite(MemWrite),
    .ID_EX_RegWrite(ID_EX_RegWrite),
    .ID_EX_WriteAddr(ID_EX_WriteAddr),
    .EX_MEM_WriteAddr(EX_MEM_WriteAddr),
    .rs(inst_rs),
    .rt(inst_rt),
    .DataHazard(DataHazard)
);


wire ID_EX_Flush;
assign ID_EX_Flush = DataHazard;

always @(posedge clk or negedge rst_n) begin
    if(~rst_n) begin
        ID_EX_rs_data <= 0;
        ID_EX_rt_data <= 0;
        ID_EX_RegWrite <= 0;
        ID_EX_WriteAddr <= 0;
        ID_EX_MemRead <= 0;
        ID_EX_MemWrite <= 0;
        ID_EX_MemToReg <= 0;
        ID_EX_ALUSrc1 <= 0;
        ID_EX_ALUSrc2 <= 0;
        ID_EX_LU_out <= 0;
        ID_EX_ForwardA <= 0;
        ID_EX_ForwardB <= 0;
        ID_EX_PC_plus_4 <= 0;
        ID_EX_ALUOp <= 0;
        ID_EX_Funct <= 0;
        ID_EX_Shamt <= 0;
        ID_EX_Forward_MEM <= 0;
    end
    else begin 
        ID_EX_rs_data <= ID_rs_data;
        ID_EX_rt_data <= ID_rt_data;
        ID_EX_RegWrite <= ID_EX_Flush?1'b0:RegWrite;
        ID_EX_WriteAddr <= WriteAddr;
        ID_EX_MemRead <= ID_EX_Flush?1'b0:MemRead;
        ID_EX_MemWrite <= ID_EX_Flush?1'b0:MemWrite;
        ID_EX_MemToReg <= MemToReg;
        ID_EX_ALUSrc1 <= ALUSrc1;
        ID_EX_ALUSrc2 <= ALUSrc2;
        ID_EX_LU_out <= LU_out;
        ID_EX_ForwardA <= ForwardA_EX;
        ID_EX_ForwardB <= ForwardB_EX;
        ID_EX_PC_plus_4 <= ((IRQ || exception) && ~Supervise)?PC_Interrupt:PC_plus_4;
        ID_EX_ALUOp <= ALUOp;
        ID_EX_Funct <= inst_funct;
        ID_EX_Shamt <= inst_shamt;
        ID_EX_Forward_MEM <= Forward_MEM;
    end
end

endmodule