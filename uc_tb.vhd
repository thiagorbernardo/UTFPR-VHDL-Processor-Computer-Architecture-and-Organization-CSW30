library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uc_tb is
end;

architecture a_uc_tb of uc_tb is
    component uc is
        port
        (
            clk : IN  std_logic;
            rst : IN  std_logic;
            instruction : IN unsigned (14 downto 0);
            PC: OUT unsigned(15 downto 0)
        );
    end component;
    
    constant period_time : time := 100 ns;
    signal finished : std_logic := '0';
    
    signal clk, rst: std_logic;
    signal instruction : unsigned (14 downto 0);
    signal PC : unsigned(15 downto 0);
    
begin
    uut : uc
    port map
    (
        clk         => clk,
        rst         => rst,
        instruction => instruction,
        PC          => PC
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
        
        instruction <= "000000000000000";
        wait for period_time * 22;
        
        instruction <= "111101100100001";
        wait for period_time * 2;
        
        instruction <= "000000000000000";
        wait;
        
    end process;
    
end architecture a_uc_tb;