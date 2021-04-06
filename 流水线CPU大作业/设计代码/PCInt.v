`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/09/15 22:22:27
// Design Name: 
// Module Name: PCInt
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


module PCInt(
    input clk,
    input rst_n,
    input PCIntWrite,
    input [31:0] PC,
    output reg [31:0] PCInt
    );

always @(posedge clk or negedge rst_n)
begin
    if (~rst_n)
        PCInt <= 32'h00000000;
    else begin if (PCIntWrite)
        PCInt <= PC;
    end
end
endmodule
