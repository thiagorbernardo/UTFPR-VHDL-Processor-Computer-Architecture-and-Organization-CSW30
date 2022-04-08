library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity is_odd_tb is
end;

architecture a_is_odd_tb of is_odd_tb is
    component is_odd is
        port
        (
            x: in unsigned(15 downto 0);
            output: out unsigned(15 downto 0)
        );
    end component;
    signal x: unsigned(15 downto 0);
    signal output: unsigned(15 downto 0);

begin
    uut: is_odd
    port map
    (
        x      => x,
        output => output
    );

    process
    begin
        x <= "0000000000101000";
        wait for 25 ns;
        x <= "0000000000000110";
        wait for 50 ns;
        wait;
    end process;
end architecture;