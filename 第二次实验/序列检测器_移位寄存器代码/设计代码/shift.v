`timescale 1ns / 1ps

module shift(
    input clk,
    input in,
    input reset,
    output reg seq_out
    );

reg [5:0] current_state, next_state;

always @(negedge reset or posedge clk)
begin
    if(~reset) current_state <= 0;
    else current_state <= next_state;
end

always @(*) begin
    if(current_state==6'b101011) seq_out <= 1;
    else seq_out <= 0;
    next_state <= {current_state[4:0], in};
end

endmodule