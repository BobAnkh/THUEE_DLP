`timescale 1ns / 1ps

module counter(
input en,
input zero,
input signal,
output reg [3:0] thousand,
output reg [3:0] hundred,
output reg [3:0] ten,
output reg [3:0] one
    );
always @(negedge signal or negedge zero) begin
    if (zero==0) begin
        thousand <= 4'd0;
        hundred <= 4'd0;
        ten <= 4'd0;
        one <= 4'd0;
    end 
    else begin
        if (en==0) begin
            thousand <= thousand;
            hundred <= hundred;
            ten <= ten;
            one <= one;
        end 
        else begin
            one = one + 4'd1;
            if (one == 4'd10) begin
                one = 4'd0;
                ten = ten + 4'd1;
            end
            if (ten == 4'd10) begin
                ten = 4'd0;
                hundred = hundred + 4'd1;
            end
            if (hundred == 4'd10) begin
                hundred = 4'd0;
                thousand = thousand + 4'd1;
            end
            if (thousand == 4'd10) begin
                thousand = 4'd9;
                hundred = 4'd9;
                ten = 4'd9;
                one = 4'd9;
            end
        end
    end
end
endmodule
