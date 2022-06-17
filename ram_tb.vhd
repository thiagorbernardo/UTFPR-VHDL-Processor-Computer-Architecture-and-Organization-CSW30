library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ram_tb is
end;

architecture a_ram_tb of ram_tb is
    component ram is
        port
        (
            clk      : IN std_logic ;
            wr_en    : IN std_logic ;
            address  : IN unsigned (5 downto 0);
            data_in  : IN unsigned (13 downto 0);
            data_out : OUT unsigned (13 downto 0)
        );
    end component;
    
    constant period_time : time := 100 ns; -- tempo do clock
    signal finished : std_logic := '0'; -- booleano para indicar se o processo acabou
    signal clk : std_logic; -- clock, reset
    signal address: unsigned(5 downto 0); -- endereco
    signal data : unsigned(13 downto 0); -- output
begin
    uut: ram
    port map
    (
        clk     => clk,
        address => address,
        data    => data
    );
    
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
        address <= "0000000";
        wait for 100 ns;
        address <= "0000001";
        wait for 100 ns;
        address <= "0000010";
        wait for 100 ns;
        address <= "0000011";
        wait for 100 ns;
        address <= "0000100";
        wait for 100 ns;
        address <= "0000101";
        wait for 100 ns;
        address <= "0000110";
        wait for 100 ns;
        address <= "0000111";
        wait for 100 ns;
        address <= "0001000";
        wait for 100 ns;
        address <= "0001001";
        wait for 100 ns;
        address <= "0001010";
        wait for 100 ns;
        wait;
    end process;
    
end architecture;