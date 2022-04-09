library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity and_op_tb is
end;

architecture a_and_op_tb of and_op_tb is
    component and_op is
        port
        (
            x,y: in unsigned(15 downto 0);
            output: out unsigned(15 downto 0)
        );
    end component;
    signal x,y: unsigned(15 downto 0);
    signal output: unsigned(15 downto 0);

begin
    uut: and_op
    port map
    (
        x      => x,
        y      => y,
        output => output
    );

    process
    begin
        x <= "0000000010000001";
        y <= "0000000000010001";
        wait for 25 ns;
        x <= "0000000000010001";
        y <= "0000000010000001";
        wait for 50 ns;
        wait;
    end process;
end architecture;