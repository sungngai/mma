
create_clock -period 20 -name clk [get_ports {clk}]

create_clock -period 21 -name oclk [get_ports {oclk}]

derive_clock_uncertainty

derive_pll_clocks

