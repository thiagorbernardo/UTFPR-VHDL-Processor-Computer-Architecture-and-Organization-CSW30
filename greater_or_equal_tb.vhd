library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity greater_or_equal_tb is
end;

architecture greater_or_equal_tb of greater_or_equal_tb is
    component greater_or_equal is
        port
        (
            x: in unsigned(7 downto 0);
            y: in unsigned(7 downto 0);
            output: out std_logic
        );
    end component;
    signal x, y: unsigned(7 downto 0);
    signal output: std_logic;

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
        x <= "00000001";
        y <= "01000000";
        wait for 50 ns;
        x <= "11111111";
        y <= "00000010";
        wait for 50 ns;
        wait;
    end process;
end architecture;