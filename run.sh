# deletar o work

ghdl -a alu.vhd
ghdl -a alu_tb.vhd

ghdl -a processor.vhd
ghdl -a processor_tb.vhd

ghdl -a reg_bank.vhd
ghdl -a reg_bank_tb.vhd

ghdl -a reg14bits.vhd
ghdl -a reg14bits_tb.vhd

# ghdl -a rom.vhd
# ghdl -a rom_tb.vhd

# ghdl -a state_machine.vhd
# ghdl -a state_machine_tb.vhd

# ghdl -a uc.vhd
# ghdl -a uc_tb.vhd

ghdl -r processor_tb --wave=processor_tb.ghw
gtkwave processor_tb.ghw