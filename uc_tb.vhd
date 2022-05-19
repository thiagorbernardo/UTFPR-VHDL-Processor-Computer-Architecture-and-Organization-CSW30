library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uc_tb is
end;

architecture a_uc_tb of uc_tb is
    component uc is
        port
        (
            clk             : IN std_logic ;
            rst             : IN std_logic ;
            instruction_in  : IN unsigned (13 downto 0);
            instruction_out : OUT unsigned (13 downto 0);
            PC              : OUT unsigned (13 downto 0);
            fetch           : OUT std_logic ;
            decode          : OUT std_logic ;
            execute         : OUT std_logic ;
            state           : OUT unsigned (1 downto 0)
        );
    end component;
    
    constant period_time : time := 100 ns;
    signal finished : std_logic := '0';
    
    signal clk, rst: std_logic;
    signal instruction_in, instruction_out, PC : unsigned (13 downto 0);
    signal fetch, decode, execute: std_logic;
    signal state: unsigned (1 downto 0);

begin
    uut: uc
    port map
    (
        clk             => clk,
        rst             => rst,
        instruction_in  => instruction_in,
        instruction_out => instruction_out,
        PC              => PC,
        fetch           => fetch,
        decode          => decode,
        execute         => execute,
        state           => state
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
        -- resumo: program counter ira somar por 10 periodos
        -- depois ira fazer um jump para o endereco 3
        -- depois ira continuar incrementando 1 no program counter
        instruction_in <= "00000000000000"; -- NOP
        wait for period_time * 10;
        
        instruction_in <= "11110001110011"; -- JUMP
        wait for period_time * 2;
        
        instruction_in <= "00000000000000"; -- NOP
        wait for period_time * 10;

        instruction_in <= "11110000101010"; -- JUMP
        wait;
        
    end process;
    
end architecture a_uc_tb;