module cnt(
    input clk,
    input reset,
    output reg [3:0] cnt_out
);
always @(negedge reset or posedge clk)
begin
    if(~reset)
        cnt_out <= 4'b0000;
    else begin
        if (cnt_out==4'b1001) cnt_out<=4'b0000;
        else cnt_out<=cnt_out+1;
    end
end
endmodule
