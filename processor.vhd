library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processor is
    port(
        clk : IN  std_logic;
        rst : IN  std_logic;
        wr_en : IN std_logic;
        sel_in1_alu : IN std_logic;
        select_reg_write : IN unsigned(2 downto 0);
        select_reg_a : IN unsigned(2 downto 0);
        select_reg_b : IN unsigned(2 downto 0);
        select_op: IN unsigned(2 downto 0);
        ext_in: IN unsigned(15 downto 0);
        output: OUT unsigned(15 downto 0)
    );
end entity processor;

architecture a_processor of processor is
        component alu is
            port
            (
                x         : IN unsigned (15 downto 0);
                y         : IN unsigned (15 downto 0);
                select_op : IN unsigned (2 downto 0);
                output    : OUT unsigned (15 downto 0)
            );
        end component alu;
    component reg_bank is
        port
        (
            clk              : IN std_logic ;
            rst              : IN std_logic ;
            wr_en            : IN std_logic ;
            select_reg_a     : IN unsigned (2 downto 0);
            select_reg_b     : IN unsigned (2 downto 0);
            select_write_reg : IN unsigned (2 downto 0);
            write_data       : IN unsigned (15 downto 0);
            reg_a            : OUT unsigned (15 downto 0);
            reg_b            : OUT unsigned (15 downto 0)
        );
    end component reg_bank;
    
    signal in0_alu, in1_alu, out_alu : unsigned(15 downto 0);
    signal reg_b: unsigned(15 downto 0);
    
   begin
    alu_instance: alu
    port map
    (
        x         =>   in0_alu,
        y         =>   in1_alu,
        select_op =>   select_op,
        output    =>   out_alu
    );
    regs : reg_bank
    port map
    (
        clk              => clk,
        rst              => rst,
        wr_en            => wr_en,
        select_reg_a     => select_reg_a,
        select_reg_b     => select_reg_b,
        select_write_reg => select_reg_write,
        write_data       => out_alu,
        reg_a            => in0_alu,
        reg_b            => reg_b
    );
    
    in1_alu <= reg_b when sel_in1_alu = '0' else
              ext_in when sel_in1_alu = '1' else 
              "0000000000000000";
              
    output <= out_alu;

end architecture a_processor;