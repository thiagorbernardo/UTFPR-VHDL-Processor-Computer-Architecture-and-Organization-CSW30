ghdl -a $1.vhd
ghdl -a $1_tb.vhd
ghdl -r $1_tb --wave=$1_tb.ghw
gtkwave $1_tb.ghw