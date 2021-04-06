module EX (
    input clk,
    input rst_n,
    input [31:0] ID_EX_rs_data,
    input [31:0] ID_EX_rt_data,
    input ID_EX_RegWrite,
    input [4:0] ID_EX_WriteAddr,
    input ID_EX_MemRead,
	input ID_EX_MemWrite,
	input [1:0] ID_EX_MemToReg,
	input ID_EX_ALUSrc1,
	input ID_EX_ALUSrc2,
    input [31:0] ID_EX_LU_out,
    input [1:0] ID_EX_ForwardA,
    input [1:0] ID_EX_ForwardB,
    input ID_EX_Forward_MEM,
    input [31:0] ID_EX_PC_plus_4,
    input [3:0] ID_EX_ALUOp,
    input [5:0] ID_EX_Funct,
    input [4:0] ID_EX_Shamt,
    input [31:0] MEM_Forward,
    output reg [31:0] EX_MEM_ALU_OUT,
    output reg [31:0] EX_MEM_rt_data,
    output reg [31:0] EX_MEM_PC_plus_4,
    output reg EX_MEM_RegWrite,
    output reg [4:0] EX_MEM_WriteAddr,
    output reg EX_MEM_MemRead,
	output reg EX_MEM_MemWrite,
	output reg [1:0] EX_MEM_MemToReg,
    output reg EX_MEM_Forward_MEM
);

wire [4:0] ALUCtl;
wire Sign;
ALUControl alucontrol(.ALUOp(ID_EX_ALUOp), .Funct(ID_EX_Funct), .ALUCtl(ALUCtl), .Sign(Sign));

wire [31:0] EX_rs_data;
wire [31:0] EX_rt_data;
assign EX_rs_data = (ID_EX_ForwardA==2'b10)?EX_MEM_ALU_OUT:(ID_EX_ForwardA==2'b01)?MEM_Forward:ID_EX_rs_data;
assign EX_rt_data = (ID_EX_ForwardB==2'b10)?EX_MEM_ALU_OUT:(ID_EX_ForwardB==2'b01)?MEM_Forward:ID_EX_rt_data;

wire [31:0] ALU_in1;
wire [31:0] ALU_in2;
wire [31:0] ALU_out;
assign ALU_in1 = ID_EX_ALUSrc1?{27'h00000, ID_EX_Shamt}:EX_rs_data;
assign ALU_in2 = ID_EX_ALUSrc2?ID_EX_LU_out:EX_rt_data;
ALU alu(.in1(ALU_in1), .in2(ALU_in2), .ALUCtl(ALUCtl), .Sign(Sign), .out(ALU_out));

always @(posedge clk or negedge rst_n) begin
    if(~rst_n) begin
        EX_MEM_ALU_OUT <= 0;
        EX_MEM_rt_data <= 0;
        EX_MEM_WriteAddr <= 0;
        EX_MEM_PC_plus_4 <= 0;
        EX_MEM_RegWrite <= 0;
        EX_MEM_MemRead <= 0;
        EX_MEM_MemWrite <= 0;
        EX_MEM_MemToReg <= 0;
        EX_MEM_Forward_MEM <= 0;
    end
    else begin 
        EX_MEM_ALU_OUT <= ALU_out;
        EX_MEM_rt_data <= EX_rt_data;
        EX_MEM_WriteAddr <= ID_EX_WriteAddr;
        EX_MEM_PC_plus_4 <= ID_EX_PC_plus_4;
        EX_MEM_RegWrite <= ID_EX_RegWrite;
        EX_MEM_MemRead <= ID_EX_MemRead;
        EX_MEM_MemWrite <= ID_EX_MemWrite;
        EX_MEM_MemToReg <= ID_EX_MemToReg;
        EX_MEM_Forward_MEM <= ID_EX_Forward_MEM;
    end
end

endmodule