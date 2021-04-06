`timescale 1ns / 1ps


module decoder(
input [3:0] thousand,
input [3:0] hundred,
input [3:0] ten,
input [3:0] one,
input clk,
input rst,
output reg [6:0] leds,
output reg [3:0] an
    );
reg [1:0] state;
reg [3:0] bcd;
always @(posedge clk or negedge rst) begin
    if (~rst) begin
        state <= 2'd0;
    end
    else state <= state + 2'd1;
end

always @(*) begin
    case(state)
        2'b00:begin
            an <= 4'b1000;
            bcd <= thousand;
        end
        2'b01:begin
            an <= 4'b0100;
            bcd <= hundred;
        end
        2'b10:begin
            an <= 4'b0010;
            bcd <= ten;
        end
        2'b11:begin
            an <= 4'b0001;
            bcd <= one;
        end
    endcase
end

always @(*) begin
    case(bcd)
        4'd0:leds<=7'b0111111;
        4'd1:leds<=7'b0000110;
        4'd2:leds<=7'b1011011;
        4'd3:leds<=7'b1001111;
        4'd4:leds<=7'b1100110;
        4'd5:leds<=7'b1101101;
        4'd6:leds<=7'b1111101;
        4'd7:leds<=7'b0000111;
        4'd8:leds<=7'b1111111;
        4'd9:leds<=7'b1101111;
        default:leds<=7'b0;
    endcase
end
endmodule
