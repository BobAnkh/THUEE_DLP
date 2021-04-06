`timescale 1ns / 1ps

module top(
input [1:0] testmode ,
input sysclk ,
input modecontrol,
input rst,
output highfreq,
output [6:0]cathodes,
output[3:0] an
);

wire sigin;

siginput signalin(
.testmode(testmode),
.sysclk(sysclk),
.rst(rst),
.sigin1(sigin)
);

frequency freq(
.sigin(sigin),
.sysclk(sysclk),
.modecontrol(modecontrol),
.rst(rst),
.highfreq(highfreq),
.cathodes(cathodes),
.an(an)
);

endmodule
