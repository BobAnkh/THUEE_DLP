`timescale 1ns / 1ps

module control(
input clk,
input rst,
output reg en,
output reg zero,
output reg save
);

always @(posedge clk or negedge rst) begin
    if (~rst) begin
        en <= 1;
        zero <= 1;
        save <= 0;
    end 
    else begin
        en <= ~en;
        zero <= ~zero;
        save <= ~save;
    end
end

endmodule