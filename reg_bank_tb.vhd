library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg_bank_tb is
end;

architecture a_reg_bank_tb of reg_bank_tb is
    component reg_bank is
        port
        (
            clk              : IN std_logic ;
            rst              : IN std_logic ;
            wr_en            : IN std_logic ;
            select_reg_a     : IN unsigned (2 downto 0);
            select_reg_b     : IN unsigned (2 downto 0);
            select_write_reg : IN unsigned (2 downto 0);
            write_data       : IN unsigned (13 downto 0);
            reg_a            : OUT unsigned (13 downto 0);
            reg_b            : OUT unsigned (13 downto 0)
        );
    end component;
    constant period_time : time := 100 ns; -- tempo do clock
    signal finished : std_logic := '0'; -- booleano para indicar se o processo acabou

    signal clk, rst, wr_en : std_logic; -- clock, reset, write enable
    signal select_reg_a, select_reg_b, select_write_reg: unsigned(2 downto 0);
    signal write_data, reg_a, reg_b : unsigned(13 downto 0); -- input e output
begin
    uut: reg_bank
    port map
    (
        clk              => clk,
        rst              => rst,
        wr_en            => wr_en,
        select_reg_a     => select_reg_a,
        select_reg_b     => select_reg_b,
        select_write_reg => select_write_reg,
        write_data       => write_data,
        reg_a            => reg_a,
        reg_b            => reg_b
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
        wr_en <= '1';
        write_data <= "00000000000010"; -- deve escrever 2 no registrador B (5)
        select_reg_a <= "010";
        select_reg_b <= "100";
        select_write_reg <= "100";
        wait for period_time*3;
        write_data <= "00000000001000"; -- deve escrever 4 no registrador A (3)
        select_write_reg <= "010";
        wait for period_time*2;

        wr_en <= '0'; -- desativando o write enable
        write_data <= "00000000000001"; -- dado que supostamente seria escrito no registrador A (3)
        select_reg_a <= "010";
        select_reg_b <= "100";
        select_write_reg <= "010";
        wait for period_time*2;

        wr_en <= '1'; -- ativando o write enable
        write_data <= "00000000000001"; -- dado que supostamente seria escrito no registrador A (0), porém é o zero
        select_reg_a <= "000";
        select_reg_b <= "111";
        select_write_reg <= "000";
        wait for period_time*2;

        -- testando todos os registradores

        wr_en <= '1'; -- ativando o write enable
        select_reg_b <= "111";

        write_data <= "00000000000001";
        select_reg_a <= "001";
        select_write_reg <= "001";
        wait for period_time*3;

        write_data <= "00000000000010";
        select_reg_a <= "010";
        select_write_reg <= "010";
        wait for period_time*3;

        write_data <= "00000000000100";
        select_reg_a <= "011";
        select_write_reg <= "011";
        wait for period_time*3;

        write_data <= "00000000001000";
        select_reg_a <= "100";
        select_write_reg <= "100";
        wait for period_time*3;

        write_data <= "00000000010000";
        select_reg_a <= "101";
        select_write_reg <= "101";
        wait for period_time*3;

        write_data <= "00000000100000";
        select_reg_a <= "110";
        select_write_reg <= "110";
        wait for period_time*3;

        write_data <= "00000001000000";
        select_reg_a <= "111";
        select_reg_b <= "000";
        select_write_reg <= "111";
        wait for period_time*3;
        wait;
    end process;
    
end architecture;