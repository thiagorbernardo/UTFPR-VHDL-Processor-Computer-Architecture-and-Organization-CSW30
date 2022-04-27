library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processor_tb is
end entity processor_tb;

architecture a_processor_tb of processor_tb is

    component processor is
        port
        (
            clk              : IN std_logic ;
            rst              : IN std_logic ;
            wr_en            : IN std_logic ;
            sel_in1_alu      : IN std_logic ;
            select_reg_write : IN unsigned (2 downto 0);
            select_reg_a     : IN unsigned (2 downto 0);
            select_reg_b     : IN unsigned (2 downto 0);
            select_op        : IN unsigned (2 downto 0);
            ext_in           : IN unsigned (15 downto 0);
            output           : OUT unsigned (15 downto 0)
        );
    end component processor;
    
    constant period_time : time := 100 ns;
    signal finished : std_logic := '0';
    signal clk, rst, wr_en : std_logic;
    signal sel_in1_alu, select_reg_write, select_reg_a, select_reg_b, select_op : unsigned (2 downto 0);
    signal ext_in, output : unsigned(15 downto 0);
    
    
begin
    uut : processor
    port map
    (
        clk              => clk,
        rst              => rst,
        wr_en            => wr_en,
        sel_in1_alu      => sel_in1_alu,
        select_reg_write => select_reg_write,
        select_reg_a     => select_reg_a,
        select_reg_b     => select_reg_b,
        select_op        => select_op,
        ext_in           => ext_in,
        output           => output
    );

    reset_global: process
    begin
        rst <= '1';
        wait for period_time*2;
        rst <= '0';
        wait;
    end process;
    
    sim_time_proc: process
    begin
        wait for 10 us;
        finished <= '1';
        wait;
    end process sim_time_proc;
    
    clk_proc: process
    begin
        while finished /= '1' loop 
            clk <= '0';
            wait for period_time / 2;
            clk <= '1';
            wait for period_time / 2; 
        end loop;
        wait;
    end process clk_proc;
    
    testbench: process
begin
    
    wait;
end process testbench;

end architecture a_processor_tb;