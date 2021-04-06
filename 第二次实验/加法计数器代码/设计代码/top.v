`timescale 1ns / 1ps
module top (
    input clk,
    input reset,
    input en,
    output wire [6:0] leds
);

wire [3:0] bcd;
cnt bcdcounter (.clk(clk), .reset(reset), .cnt_out(bcd));
bcd7 bcd27seg (.din(bcd),.en(en), .dout(leds));

endmodule

