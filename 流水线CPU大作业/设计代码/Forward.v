module Forward(
    input rst_n,
    input [4:0] rs,
    input [4:0] rt,
    input ID_EX_RegWrite,
    input [4:0] ID_EX_WriteAddr,
    input EX_MEM_RegWrite,
    input [4:0] EX_MEM_WriteAddr,
    input MEM_WB_RegWrite,
    input [4:0] MEM_WB_WriteAddr,
    output reg [1:0] ForwardA_ID,
    output reg [1:0] ForwardB_ID,
    output reg [1:0] ForwardA_EX,
    output reg [1:0] ForwardB_EX,
    output reg Forward_MEM
);

always @(*) begin
    if(~rst_n) begin
        ForwardA_ID = 2'b00;
        ForwardB_ID = 2'b00;
        ForwardA_EX = 2'b00;
        ForwardB_EX = 2'b00;
        Forward_MEM = 1'b0;
    end
    else begin
        if (EX_MEM_RegWrite && (EX_MEM_WriteAddr != 5'b0) && (EX_MEM_WriteAddr == rs)) ForwardA_ID = 2'b10;
        else if (MEM_WB_RegWrite && (MEM_WB_WriteAddr != 5'b0) && (MEM_WB_WriteAddr == rs) && ((EX_MEM_WriteAddr != rs) || ~EX_MEM_RegWrite)) ForwardA_ID = 2'b01;
        else ForwardA_ID = 2'b00;
        if (EX_MEM_RegWrite && (EX_MEM_WriteAddr != 5'b0) && (EX_MEM_WriteAddr == rt)) ForwardB_ID = 2'b10;
        else if (MEM_WB_RegWrite && (MEM_WB_WriteAddr != 5'b0) && (MEM_WB_WriteAddr == rt) && ((EX_MEM_WriteAddr != rt) || ~EX_MEM_RegWrite)) ForwardB_ID = 2'b01;
        else ForwardB_ID = 2'b00;

        if (ID_EX_RegWrite && (ID_EX_WriteAddr != 5'b0) && (ID_EX_WriteAddr == rs)) ForwardA_EX = 2'b10;
        else if (EX_MEM_RegWrite && (EX_MEM_WriteAddr != 5'b0) && (EX_MEM_WriteAddr == rs) && ((ID_EX_WriteAddr != rs) || ~ID_EX_RegWrite)) ForwardA_EX = 2'b01;
        else ForwardA_EX = 2'b00;
        if (ID_EX_RegWrite && (ID_EX_WriteAddr != 5'b0) && (ID_EX_WriteAddr == rt)) ForwardB_EX = 2'b10;
        else if (EX_MEM_RegWrite && (EX_MEM_WriteAddr != 5'b0) && (EX_MEM_WriteAddr == rt) && ((ID_EX_WriteAddr != rs) || ~ID_EX_RegWrite)) ForwardB_EX = 2'b01;
        else ForwardB_EX = 2'b00;

        if (ID_EX_RegWrite && (ID_EX_WriteAddr != 5'b0) && (ID_EX_WriteAddr == rt)) Forward_MEM = 1'b1;
        else Forward_MEM = 1'b0;
    end
end

endmodule