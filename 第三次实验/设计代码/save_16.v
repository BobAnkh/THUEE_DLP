`timescale 1ns / 1ps


module save_16(
input [3:0] thousand,
input [3:0] hundred,
input [3:0] ten,
input [3:0] one,
input save,
output reg [3:0] thousand_o,
output reg [3:0] hundred_o,
output reg [3:0] ten_o,
output reg [3:0] one_o
    );
always @(*) begin
    if (~save) begin
        {thousand_o[3:0], hundred_o[3:0], ten_o[3:0], one_o[3:0]} <= {thousand[3:0], hundred[3:0], ten[3:0], one[3:0]};
    end
    else begin
        thousand_o <= thousand_o;
        hundred_o <= hundred_o;
        ten_o <= ten_o;
        one_o <= one_o;
    end
end

endmodule
