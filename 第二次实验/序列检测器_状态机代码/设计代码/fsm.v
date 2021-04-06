`timescale 1ns / 1ps

module fsm(
    input clk,
    input in,
    input reset,
    output reg seq_out
    );

reg [2:0] current_state, next_state;

always @(negedge reset or posedge clk)
begin
    if(~reset)  current_state <= 3'b0;
    else current_state <= next_state;
end

always @(*) begin
case(current_state)
    3'd0: begin
        seq_out <= 0;
        if(in) next_state <= 3'd1;
        else next_state <= 3'd0;
    end
    3'd1: begin
        seq_out <= 0;
        if(in) next_state <= 3'd1;
        else next_state <= 3'd2;
    end
    3'd2: begin
        seq_out <= 0;
        if(in) next_state <= 3'd3;
        else next_state <= 3'd0;
    end
    3'd3: begin
        seq_out <= 0;
        if(in) next_state <= 3'd1;
        else next_state <= 3'd4;
    end
    3'd4: begin
        seq_out <= 0;
        if(in) next_state <= 3'd5;
        else next_state <= 3'd0;
    end
    3'd5: begin
        seq_out <= 0;
        if(in) next_state <= 3'd6;
        else next_state <= 3'd4;
    end
    3'd6: begin
        seq_out <= 1;
        if(in) next_state <= 3'd1;
        else next_state <= 3'd2;
    end
    default: begin
        seq_out <= 0;
        next_state <= 3'b0;
    end
endcase
end

endmodule
