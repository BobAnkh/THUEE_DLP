`timescale 1ns / 1ps

module clockgenerator(
input sysclk,
input rst,
output reg clk_1,
output reg clk_1k
    );
reg [25:0] count_1;
reg [15:0] count_1k;
always @(posedge sysclk or negedge rst) begin
    if (~rst) begin
        clk_1 <= 0;
        count_1 <= 0;
    end
    else begin
        if (count_1==0) begin
            clk_1 <= ~clk_1;
        end
        count_1 <= count_1 + 26'd1;
        if (count_1==26'd50_000) begin
            count_1 <= 0;
        end
    end
end
always @(posedge sysclk or negedge rst) begin
    if (~rst) begin
        clk_1k <= 0;
        count_1k <= 0;
    end
    else begin
        if (count_1k==0) begin
            clk_1k <= ~clk_1k;
        end
        count_1k <= count_1k + 16'd1;
        if (count_1k==16'd50) begin
            count_1k <= 0;
        end
    end
end

endmodule
