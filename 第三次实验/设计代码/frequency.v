`timescale 1ns / 1ps


module frequency(
input sigin,
input sysclk,
input modecontrol,
input rst,
output reg highfreq,
output [6:0] cathodes,
output [3:0] an
    );

wire signal_m;
wire clk_1;
wire clk_1k;
wire en;
wire zero;
wire save;
wire [3:0] thousand;
wire [3:0] hundred;
wire [3:0] ten;
wire [3:0] one;
wire [3:0] thousand_o;
wire [3:0] hundred_o;
wire [3:0] ten_o;
wire [3:0] one_o;

always @(*) begin
    highfreq <= modecontrol;
end

divide divide_feq(
.signal_1(sigin),
.rst(rst),
.select(modecontrol),
.signal_sel(signal_m)
);

clockgenerator system_clock(
.sysclk(sysclk),
.rst(rst),
.clk_1(clk_1),
.clk_1k(clk_1k)
);

control controller(
.clk(clk_1),
.rst(rst),
.en(en),
.zero(zero),
.save(save)
);

counter count(
.en(en),
.zero(zero),
.signal(signal_m),
.thousand(thousand),
.hundred(hundred),
.ten(ten),
.one(one)
);

save_16 saver(
.thousand(thousand),
.hundred(hundred),
.ten(ten),
.one(one),
.save(save),
.thousand_o(thousand_o),
.hundred_o(hundred_o),
.ten_o(ten_o),
.one_o(one_o)
);

decoder decode(
.thousand(thousand_o),
.hundred(hundred_o),
.ten(ten_o),
.one(one_o),
.clk(clk_1k),
.rst(rst),
.leds(cathodes),
.an(an)
);

endmodule
