# Configuration for TimeQuest timing analyzer

# Create generated clocks based on PLLs
derive_pll_clocks -use_tan_name

# Clock frequencies
create_clock -period "20.000 ns" -name {OSC_50} {OSC_50}

# Multicycle paths
set_multicycle_path -end -setup -to [get_keepers {*div_out_reg*}] 5
set_multicycle_path -end -hold -to [get_keepers {*div_out_reg*}] 4

set_multicycle_path -end -setup -to [get_keepers {*mult_out_reg*}] 2
set_multicycle_path -end -hold -to [get_keepers {*mult_out_reg*}] 1

# Cuts
set_false_path -to [get_keepers {*sync_reg_out*}]
set_false_path -from [get_keepers {ram:u27*}] -to [get_keepers {ram:u27*}]
