library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processor_tb is
end;

architecture a_processor_tb of processor_tb is
    component processor is
        port
        (
            clk         : IN std_logic ;
            rst         : IN std_logic ;
            state       : OUT unsigned (1 downto 0);
            PC          : OUT unsigned (13 downto 0);
            instruction : OUT unsigned (13 downto 0);
            regA        : OUT unsigned (13 downto 0);
            regB        : OUT unsigned (13 downto 0);
            output      : OUT unsigned (13 downto 0)
        );
    end component;
    
    constant period_time : time := 100 ns;
    signal finished : std_logic := '0';
    
    signal clk, rst, wr_en, sel_y_alu : std_logic;
    signal select_reg_write, select_reg_a, select_reg_b, select_op : unsigned (2 downto 0);
    signal ext_in, output : unsigned(15 downto 0);
    
begin
    uut : processor
    port map
    (
        clk              => clk,
        rst              => rst,
        wr_en            => wr_en,
        sel_y_alu      => sel_y_alu,
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
    end process reset_global;
    
    sim_time_proc: process
    begin
        wait for 100 us;
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
    
    process
    begin
        wr_en <= '1';
        sel_y_alu <= '1';
        select_reg_a <= "000";
        select_reg_b <= "001";
        select_op <= "100";
        
        select_reg_write <= "001";
        ext_in <= "0000000000000001";
        wait for period_time*2;
        
        select_op <= "000";
        select_reg_b <= "010";
        select_reg_write <= "010";
        ext_in <= "0000000000000010";
        wait for period_time*2;

        select_reg_b <= "011";
        select_reg_write <= "011";
        ext_in <= "0000000000000100";
        wait for period_time*2;
        
        select_reg_b <= "100";
        select_reg_write <= "100";
        ext_in <= "0000000000001000";
        wait for period_time*2;
        
        select_reg_b <= "101";
        select_reg_write <= "101";
        ext_in <= "0000000000010000";
        wait for period_time*2;
        
        select_reg_b <= "110";
        select_reg_write <= "110";
        ext_in <= "0000000000100000";
        wait for period_time*2;
        
        select_reg_b <= "111";
        select_reg_write <= "111";
        ext_in <= "0000000001000000";
        wait for period_time*2;
        
        sel_y_alu <= '0'; -- soma reg a com reg b, porém write enable desativado
        wr_en <= '0';
        select_reg_write <= "111";
        select_reg_a <= "111";
        select_reg_b <= "100";
        select_op <= "000";
        wait for period_time*2;
        
        -- soma reg a com reg b e salva no 101
        wr_en <= '1';
        wait for period_time*2;
        
        wr_en <= '0';
        select_reg_a <= "101";
        select_reg_b <= "101";
        wait for period_time*2;
        wait;
    end process;

end architecture a_processor_tb;