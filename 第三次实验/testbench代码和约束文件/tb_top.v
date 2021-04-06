//~ `New testbench
`timescale  1ns / 1ps

module tb_top;

// top Parameters    
parameter PERIOD  = 10;


// top Inputs
reg   [1:0]  testmode                      = 0 ;
reg   sysclk                               = 0 ;
reg   modecontrol                          = 0 ;
reg   rst                                  = 0 ;

// top Outputs
wire  highfreq                             ;
wire  [6:0]  cathodes                      ;
wire  [3:0]  an                            ;


initial
begin
    forever #(PERIOD/2)  sysclk=~sysclk;
end

initial
begin
    #(PERIOD*2) rst  =  1;
end

top  u_top (
    .testmode                ( testmode     [1:0] ),
    .sysclk                  ( sysclk             ),
    .modecontrol             ( modecontrol        ),
    .rst                     ( rst                ),

    .highfreq                ( highfreq           ),
    .cathodes                ( cathodes     [6:0] ),
    .an                      ( an           [3:0] )
);

initial
begin
    rst <= 1;
    sysclk <= 0;
    testmode <= 2'b00;
    modecontrol <= 0;
    #(PERIOD*2) rst <= 0;
    #(PERIOD*10) rst <= 1;
    #(PERIOD*300000) testmode <= 2'b01;
    #(PERIOD*200000) testmode <= 2'b10;
    #(PERIOD*200000) testmode <= 2'b11;
    #(PERIOD*200000) modecontrol <= 1;
    #(PERIOD*200000);
    $finish;
end

endmodule