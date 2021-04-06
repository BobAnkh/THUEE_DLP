`timescale 1ns / 1ps

module divide(
input signal_1,
input rst,
input select,
output reg signal_sel
    );
reg signal_10;
reg [2:0] count_10;

always @(posedge signal_1 or negedge rst) begin
    if (~rst) begin
        signal_10 <= 0;
        count_10 <= 0;
    end
    else begin
        if (count_10==0) begin
            signal_10 = ~signal_10;
        end
        count_10 = count_10 + 1;
        if (count_10==3'd5) begin
            count_10 = 0;
        end
    end
end

always @(*) begin
    if(select) signal_sel <= signal_10;
    else signal_sel <= signal_1;
end

endmodule
