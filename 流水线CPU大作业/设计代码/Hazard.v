module Hazard(
    input [2:0] PCSrc,
    input ID_EX_MemRead,
    input EX_MEM_MemRead,
    input ID_MemWrite,
    input ID_EX_RegWrite,
    input [4:0] ID_EX_WriteAddr,
    input [4:0] EX_MEM_WriteAddr,
    input [4:0] rs,
    input [4:0] rt,
    output DataHazard
);
//处于 EX 阶段的指令需要用到前一条指令的 MEM 阶段的结果
wire EX_MEM_Hazard = (PCSrc == 3'b000) && ~ID_MemWrite && ID_EX_MemRead && ((ID_EX_WriteAddr != 5'b0) && (ID_EX_WriteAddr == rs || ID_EX_WriteAddr == rt));
//处于 ID 阶段的指令需要用到前一条指令的 EX 或 MEM 阶段的结果
wire ID_EX_MEM_Hazard = (PCSrc == 3'b001 || PCSrc == 3'b011) && ((ID_EX_MemRead || ID_EX_RegWrite) && (ID_EX_WriteAddr != 5'b0) && (ID_EX_WriteAddr == rs || ID_EX_WriteAddr == rt));
//处于 ID 阶段的指令需要用到前第二条指令的 MEM 阶段的结果
wire ID_MEM_Hazard = (PCSrc == 3'b001 || PCSrc == 3'b011) && EX_MEM_MemRead && ((EX_MEM_WriteAddr != 5'b0) && (EX_MEM_WriteAddr == rs || EX_MEM_WriteAddr == rt));

assign DataHazard = EX_MEM_Hazard || ID_EX_MEM_Hazard || ID_MEM_Hazard;
endmodule