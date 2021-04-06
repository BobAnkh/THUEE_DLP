//~ `New testbench
`timescale  1ns / 1ps

module shift_tb;       

// shift Parameters    
parameter PERIOD  = 10;

// shift Inputs
reg   clk                                  = 0 ;
reg   in                                   = 0 ;
reg   reset                                = 0 ;

// shift Outputs
wire  seq_out                              ;

initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

shift  u_shfit (
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
