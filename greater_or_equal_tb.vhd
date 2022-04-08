library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity greater_or_equal_tb is
end;

architecture greater_or_equal_tb of greater_or_equal_tb is
    component greater_or_equal is
        port
        (
            x: in unsigned(15 downto 0);
            y: in unsigned(15 downto 0);
            output: out unsigned(15 downto 0)
        );
    end component;
    signal x, y: unsigned(15 downto 0);
    signal output: unsigned(15 downto 0);

begin
    uut: greater_or_equal
    port map
    (
        x  => x,
        y  => y,
        output => output
    );

    process
    begin
        x <= "0000000010000000";
        y <= "1000000000000001";
        wait for 50 ns;
        x <= "0000000011111111";
        y <= "0000000000000010";
        wait for 50 ns;
        wait;
    end process;
end architecture;