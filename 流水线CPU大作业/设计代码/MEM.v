module MEM (
    input clk,
    input rst_n,
    input [31:0] EX_MEM_ALU_OUT,
    input [31:0] EX_MEM_rt_data,
    input [31:0] EX_MEM_PC_plus_4,
    input EX_MEM_RegWrite,
    input [4:0] EX_MEM_WriteAddr,
    input EX_MEM_MemRead,
	input EX_MEM_MemWrite,
	input [1:0] EX_MEM_MemToReg,
    input EX_MEM_Forward_MEM,
    output reg [31:0] MEM_WB_MEM_OUT,
    output reg [4:0] MEM_WB_WriteAddr,
    output reg MEM_WB_RegWrite,
    output [7:0] led,
    output [11:0] digi,
    output IRQ
);

wire IsPeripheral = (EX_MEM_ALU_OUT == 32'h40000000) || (EX_MEM_ALU_OUT == 32'h40000004) || (EX_MEM_ALU_OUT == 32'h40000008) || 
    (EX_MEM_ALU_OUT == 32'h4000000c) || (EX_MEM_ALU_OUT == 32'h40000010) || (EX_MEM_ALU_OUT == 32'h40000014);
wire [31:0] WriteData = EX_MEM_Forward_MEM?MEM_WB_MEM_OUT:EX_MEM_rt_data;
wire [31:0] ReadData1;
DataMemory dataram(
    .clk(clk),
    .rst_n(rst_n),
    .Address(EX_MEM_ALU_OUT),
    .Write_data(WriteData),
    .MemRead(EX_MEM_MemRead && ~IsPeripheral),
    .MemWrite(EX_MEM_MemWrite && ~IsPeripheral),
    .Read_data(ReadData1)
);

wire [31:0] ReadData2;
Peripheral peripheral(
    .clk(clk),
    .rst_n(rst_n),
    .MemRead(EX_MEM_MemRead && IsPeripheral),
    .MemWrite(EX_MEM_MemWrite && IsPeripheral),
    .Address(EX_MEM_ALU_OUT),
    .WriteData(EX_MEM_rt_data),
    .ReadData(ReadData2),
    .led(led),
    .digi(digi),
    .IRQ(IRQ)
);

wire [31:0] MEM_DATA;
assign MEM_DATA = IsPeripheral?ReadData2:ReadData1;
wire [31:0] MEM_OUT;
assign MEM_OUT = (EX_MEM_MemToReg == 2'b00)?EX_MEM_ALU_OUT:
    (EX_MEM_MemToReg == 2'b01)?MEM_DATA:
    EX_MEM_PC_plus_4;


always @(posedge clk or negedge rst_n) begin
    if(~rst_n) begin
        MEM_WB_MEM_OUT <= 0;
        MEM_WB_WriteAddr <= 0;
        MEM_WB_RegWrite <= 0;
    end
    else begin 
        MEM_WB_MEM_OUT <= MEM_OUT;
        MEM_WB_WriteAddr <= EX_MEM_WriteAddr;
        MEM_WB_RegWrite <= EX_MEM_RegWrite;
    end
end

endmodule