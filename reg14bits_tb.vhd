library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg14bits_tb is
end;

architecture a_reg14bits_tb of reg14bits_tb is
    component reg14bits is
        port
        (
            clk      : IN std_logic ;
            rst      : IN std_logic ;
            wr_en    : IN std_logic ;
            data_in  : IN unsigned (13 downto 0);
            data_out : OUT unsigned (13 downto 0)
        );
    end component;
    constant period_time : time := 100 ns; -- tempo do clock
    signal finished : std_logic := '0'; -- booleano para indicar se o processo acabou
    signal clk, rst, wr_en : std_logic; -- clock, reset, write enable
    signal data_in, data_out : unsigned(13 downto 0); -- input e output
begin
    uut: reg14bits
    port map
    (
        clk      => clk,
        rst      => rst,
        wr_en    => wr_en,
        data_in  => data_in,
        data_out => data_out
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
    
    process -- sinais de teste
    begin
        wr_en <= '0';
        data_in <= "00000000000001";
        wait for 200 ns;
        wr_en <= '1';
        data_in <= "00000000000010";
        wait for 200 ns;
        wr_en <= '0';
        data_in <= "00000000000100";
        wait;
    end process;
    
end architecture;