library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sum_and_sub_tb is
end;

architecture sum_and_sub_tb of sum_and_sub_tb is
    component sum_and_sub is
        port
        (
            x: in unsigned(7 downto 0);
            y: in unsigned(7 downto 0);
            sum: out unsigned(7 downto 0);
            sub: out unsigned(7 downto 0)
        );
    end component;
    signal x, y, sum, sub: unsigned(7 downto 0);

begin
    uut: sum_and_sub
    port map
    (
        x   => x,
        y   => y,
        sum => sum,
        sub => sub
    );

    process
    begin
        x <= "00000001";
        y <= "00000001";
        wait for 50 ns;
        x <= "00000001";
        y <= "00000010";
        wait for 50 ns;
        wait;
    end process;
end architecture;