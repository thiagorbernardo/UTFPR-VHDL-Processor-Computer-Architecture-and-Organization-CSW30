library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity state_machine_tb is
end;

architecture a_state_machine_tb of state_machine_tb is
    component state_machine is
        port
        (
            clk : in std_logic;
            rst : in std_logic;
            state : out std_logic
        );
    end component;
    constant period_time : time := 100 ns; -- tempo do clock
    signal finished : std_logic := '0'; -- booleano para indicar se o processo acabou
    signal clk, rst, state : std_logic; -- clock, reset, state
begin
    uut: state_machine
    port map
    (
        clk      => clk,
        rst      => rst,
        state    => state
    );
    
    reset_global: process -- a cada duas vezes o período reseta o registro
    begin
        rst <= '1';
        wait for period_time*2;
        rst <= '0';
        wait;
    end process;
    
    sim_time_proc: process
    begin
        wait for 10 us; -- tempo de simulação
        finished <= '1';
        wait;
    end process sim_time_proc;
    
    clk_proc: process
    begin
        while finished /= '1' loop -- gera clock até que sim_time_proc termine
            clk <= '0';
            wait for period_time / 2;
            clk <= '1';
            wait for period_time / 2; -- subida
        end loop;
        wait;
    end process clk_proc;
    
end architecture;