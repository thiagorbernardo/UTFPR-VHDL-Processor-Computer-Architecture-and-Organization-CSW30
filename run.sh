ghdl -a alu.vhd
ghdl -a alu_tb.vhd

ghdl -a processor.vhd
ghdl -a processor_tb.vhd

ghdl -a reg_bank.vhd
ghdl -a reg_bank_tb.vhd

ghdl -a reg16bits.vhd
ghdl -a reg16bits_tb.vhd

ghdl -a rom.vhd
ghdl -a rom_tb.vhd

ghdl -a state_machine.vhd
ghdl -a state_machine_tb.vhd

ghdl -a uc.vhd
ghdl -a uc_tb.vhd

ghdl -r uc_tb --wave=uc_tb.ghw
gtkwave uc_tb.ghw