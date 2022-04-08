library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity not_op_tb is
end;

architecture a_not_op_tb of not_op_tb is
    component not_op is
        port
        (
            x: in unsigned(15 downto 0);
            output: out unsigned(15 downto 0)
        );
    end component;
    signal x: unsigned(15 downto 0);
    signal output: unsigned(15 downto 0);

begin
    uut: not_op
    port map
    (
        x      => x,
        output => output
    );

    process
    begin
        x <= "0000000000000001";
        wait for 25 ns;
        x <= "0000000000000110";
        wait for 50 ns;
        wait;
    end process;
end architecture;