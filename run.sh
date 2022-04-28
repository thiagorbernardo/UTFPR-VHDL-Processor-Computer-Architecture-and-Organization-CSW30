ghdl -a alu.vhd
ghdl -a alu_tb.vhd

ghdl -a reg16bits.vhd
ghdl -a reg16bits_tb.vhd

ghdl -a reg_bank.vhd
ghdl -a reg_bank_tb.vhd

ghdl -a processor.vhd
ghdl -a processor_tb.vhd

ghdl -r processor_tb --wave=processor_tb.ghw
gtkwave processor_tb.ghw