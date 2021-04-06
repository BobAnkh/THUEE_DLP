//~ `New testbench
`timescale  1ns / 1ps

module fsm_tb;       

// fsm Parameters    
parameter PERIOD  = 10;

// fsm Inputs
reg   clk                                  = 0 ;
reg   in                                   = 0 ;
reg   reset                                = 0 ;

// fsm Outputs
wire  seq_out                              ;

initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

fsm  u_fsm (
    .clk                     ( clk       ),
    .in                      ( in        ),
    .reset                   ( reset     ),

    .seq_out                 ( seq_out   )
);

initial
begin
    reset  =  1'b1;
    clk  =  1'b0;
    in  =  1'b0;
    #(PERIOD) reset  =  1'b0;
    #(PERIOD*10) reset  =  1'b1;
    #(PERIOD/10) $display("Simulation Start!"); $write("Test begin:  ");
    #(PERIOD) in  =  0; $write("%b",seq_out);
    #(PERIOD) in  =  0; $write("%b",seq_out);
    #(PERIOD) in  =  1; $write("%b",seq_out);
    #(PERIOD) in  =  0; $write("%b",seq_out);
    #(PERIOD) in  =  1; $write("%b",seq_out);
    #(PERIOD) in  =  0; $write("%b",seq_out);
    #(PERIOD) in  =  1; $write("%b",seq_out);
    #(PERIOD) in  =  1; $write("%b",seq_out);
    #(PERIOD) in  =  0; $write("%b",seq_out);
    #(PERIOD) in  =  1; $write("%b",seq_out);
    #(PERIOD) in  =  0; $write("%b",seq_out);
    #(PERIOD) in  =  1; $write("%b",seq_out);
    #(PERIOD) in  =  1; $write("%b",seq_out);
    #(PERIOD) in  =  1; $write("%b",seq_out);
    #(PERIOD) in  =  0; $write("%b",seq_out);
    #(PERIOD) in  =  0; $write("%b",seq_out);
    #(PERIOD) in  =  0; $write("%b",seq_out);
    #(PERIOD) in  =  1; $write("%b",seq_out);
    #(PERIOD) in  =  0; $write("%b",seq_out);
    #(PERIOD) in  =  1; $write("%b",seq_out);
    #(PERIOD) in  =  0; $write("%b",seq_out);
    #(PERIOD) in  =  1; $write("%b",seq_out);
    #(PERIOD) in  =  1; $write("%b",seq_out);
    #(PERIOD) in  =  0; $write("%b",seq_out);
    #(PERIOD) in  =  0; $write("%b",seq_out);
    #(PERIOD) $display("  test finish!");
    $finish;
end

endmodule
