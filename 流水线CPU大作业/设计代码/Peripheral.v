module Peripheral(
    input clk,
    input rst_n,
    input MemRead,
    input MemWrite,
    input [31:0] Address,
    input [31:0] WriteData,
    output reg [31:0] ReadData,
    output reg [7:0] led,
    output reg [11:0] digi,
    output IRQ
);

reg [31:0] TH;
reg [31:0] TL;
reg [2:0] TCON;
reg [31:0] systick;

assign IRQ = TCON[2];

always @(*) 
begin
    case(Address)
            32'h40000000: ReadData <= MemRead?TH:32'b0;
            32'h40000004: ReadData <= MemRead?TL:32'b0;
            32'h40000008: ReadData <= MemRead?{29'b0,TCON}:32'b0;
            32'h4000000c: ReadData <= MemRead?{24'b0,led}:32'b0;
            32'h40000010: ReadData <= MemRead?{20'b0,digi}:32'b0;
            32'h40000014: ReadData <= MemRead?systick:32'b0;
            default: ReadData <= 32'b0;
        endcase
end


always @(posedge clk or negedge rst_n) begin
    if(~rst_n) begin
        TH <= 32'b0;
        TL <= 32'b0;
        TCON <= 3'b0;
        led <= 8'b0;
        digi <= 12'b0;
        systick <= 32'b0;
    end
    else begin
        systick <= systick + 1;
        if (MemWrite)
            case(Address)
                32'h40000000: TH <= WriteData;
                32'h40000004: TL <= WriteData;
                32'h40000008: TCON <= WriteData[2:0];
                32'h4000000c: led <= WriteData[7:0];
                32'h40000010: digi <= WriteData[11:0];
            endcase
        if(TCON[0]) begin	    //timer is enabled
            if(TL==32'hffffffff) begin
                TL <= TH;
                if(TCON[1]) TCON[2] <= 1'b1;		//irq is enabled
            end
            else TL <= TL + 1;
        end
    end
end

endmodule