#10MHz
set_property -dict {PACKAGE_PIN P17 IOSTANDARD LVCMOS33} [get_ports {clk}]
create_clock -period 100.000 -name CLK -waveform {0.000 50.000} [get_ports clk]

#S6
set_property -dict {PACKAGE_PIN P4 IOSTANDARD LVCMOS33} [get_ports {reset}]

#SW
set_property -dict {PACKAGE_PIN N4 IOSTANDARD LVCMOS33} [get_ports {select[1]}]
set_property -dict {PACKAGE_PIN R1 IOSTANDARD LVCMOS33} [get_ports {select[0]}]

#LED
set_property -dict {PACKAGE_PIN B4 IOSTANDARD LVCMOS33} [get_ports {register_low[0]}]
set_property -dict {PACKAGE_PIN A4 IOSTANDARD LVCMOS33} [get_ports {register_low[1]}]
set_property -dict {PACKAGE_PIN A3 IOSTANDARD LVCMOS33} [get_ports {register_low[2]}]
set_property -dict {PACKAGE_PIN B1 IOSTANDARD LVCMOS33} [get_ports {register_low[3]}]
set_property -dict {PACKAGE_PIN A1 IOSTANDARD LVCMOS33} [get_ports {register_low[4]}]
set_property -dict {PACKAGE_PIN B3 IOSTANDARD LVCMOS33} [get_ports {register_low[5]}]
set_property -dict {PACKAGE_PIN B2 IOSTANDARD LVCMOS33} [get_ports {register_low[6]}]
set_property -dict {PACKAGE_PIN D5 IOSTANDARD LVCMOS33} [get_ports {register_low[7]}]
