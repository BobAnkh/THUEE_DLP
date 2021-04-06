set_property -dict {PACKAGE_PIN K2 IOSTANDARD LVCMOS33} [get_ports {seq_out}]
set_property -dict {PACKAGE_PIN N4 IOSTANDARD LVCMOS33} [get_ports {in}]

set_property -dict {PACKAGE_PIN U4 IOSTANDARD LVCMOS33} [get_ports {reset}]
set_property -dict {PACKAGE_PIN R15 IOSTANDARD LVCMOS33} [get_ports {clk}]

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets clk_IBUF]
