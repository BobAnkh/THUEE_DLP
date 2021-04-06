module IF(
    input clk,
    input rst_n,
    input PCWrite,
    input IF_ID_Flush,
    input IF_ID_Stall,
    input [31:0] branch_target,
    input [31:0] jump_target,   
    input [31:0] jr_target,     
    input [2:0] PCSrc,
    output reg [31:0] IF_ID_Instruction,
    output reg [31:0] IF_ID_PC_plus_4,
    output reg [31:0] PC
);


wire [31:0] PC_plus_4;
wire [31:0] instruction;

assign PC_plus_4 = {PC[31], PC[30:0] + 31'd4};   // 保持PC[31]

InstructionMemory instruction_memory(.Address(PC), .Instruction(instruction));

always @(posedge clk or negedge rst_n) begin
    if(~rst_n) begin
        PC <= 32'h8000_0000;
        IF_ID_Instruction <= 0;
        IF_ID_PC_plus_4 <= 0;
    end
    else begin 
        if(PCWrite) begin
            case (PCSrc)
                3'b000  : PC <= PC_plus_4;
                3'b001  : PC <= branch_target;         // branch
                3'b010  : PC <= jump_target;    // j and jal
                3'b011  : PC <= jr_target;      // jr and jalr
                3'b100  : PC <= 32'h8000_0004;  // Interrupt
                3'b101  : PC <= 32'h8000_0008;  // Exception
                default : PC <= 32'hffff_ffff;  // Unexpected behavior
            endcase
        end
        if (~IF_ID_Stall) begin
            IF_ID_Instruction <= IF_ID_Flush?32'b0:instruction;
            IF_ID_PC_plus_4 <= PC_plus_4;
        end

    end
end

endmodule