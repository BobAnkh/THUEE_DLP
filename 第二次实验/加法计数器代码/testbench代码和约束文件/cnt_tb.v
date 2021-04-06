//~ `New testbench
`timescale  1ns / 1ps

module cnt_tb;       

// top Parameters    
parameter PERIOD  = 10;


// top Inputs
reg   clk                                  = 0 ;
reg   reset                                = 0 ;
reg   en                                   = 0 ;

// top Outputs
wire  [6:0]  leds                          ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

top  u_top (
    .clk                     ( clk          ),
    .reset                   ( reset        ),
    .en                      ( en           ),
    .leds                    ( leds   [6:0] )
);

initial
begin
    reset  =  1'b1;
    clk  =  1'b0;
    en  =  1'b1;
    #(PERIOD) reset  =  1'b0;
    #(PERIOD*10) reset  =  1'b1;
    $display("Simulation Start!");
    #(PERIOD*30) reset  =  1'b0;
    #(PERIOD*5)
    $finish;
end

endmodule