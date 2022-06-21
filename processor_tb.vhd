library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processor_tb is
end;

architecture a_processor_tb of processor_tb is
    component processor is
        port
        (
            clk          : IN std_logic ;
            rst          : IN std_logic ;
            state        : OUT unsigned (1 downto 0);
            PC           : OUT unsigned (13 downto 0);
            instruction  : OUT unsigned (13 downto 0);
            reg_a_output : OUT unsigned (13 downto 0);
            reg_b_output : OUT unsigned (13 downto 0);
            output       : OUT unsigned (13 downto 0)
        );
    end component;
    
    constant period_time : time := 100 ns;
    signal finished : std_logic := '0';
    
    signal clk, rst: std_logic;
    signal output, PC, instruction, reg_a_output, reg_b_output : unsigned(13 downto 0);
    signal state : unsigned(1 downto 0); -- estado da maquina de estados
    
begin
    uut: processor
    port map
    (
        clk          => clk,
        rst          => rst,
        state        => state,
        PC           => PC,
        instruction  => instruction,
        reg_a_output => reg_a_output,
        reg_b_output => reg_b_output,
        output       => output
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
        wait for 1000 us;
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

end architecture a_processor_tb;