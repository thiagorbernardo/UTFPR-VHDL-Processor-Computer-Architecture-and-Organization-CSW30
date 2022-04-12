library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu_tb is
end;

architecture a_alu_tb of alu_tb is
    component alu is
        port
        (
            x         : IN unsigned (15 downto 0);
            y         : IN unsigned (15 downto 0);
            select_op : IN unsigned (2 downto 0);
            output    : OUT unsigned (15 downto 0)
        );
    end component;
    signal x, y, output: unsigned(15 downto 0);
    signal select_op: unsigned(2 downto 0);

begin
    uut: alu
    port map
    (
        x         => x,
        y         => y,
        select_op => select_op,
        output    => output
    );


    process
    begin
        select_op <= "000"; --SUM
        x <= "0000000010000001";
        y <= "1111111101111110";
        wait for 50 ns;
        select_op <= "001"; --SUB
        x <= "0000000010000001";
        y <= "1111111101111110";
        wait for 50 ns;
        select_op <= "010"; --AND
        x <= "0000000010000001";
        y <= "1111111101111110";
        wait for 50 ns;
        select_op <= "011"; --XOR
        x <= "0000000010000001";
        y <= "1111111101111101";
        wait for 50 ns;
        select_op <= "100"; --NOT
        x <= "0000000010000001";
        y <= "1111111101111110";
        wait for 50 ns;
        select_op <= "101"; --OR
        x <= "0000000010000001";
        y <= "1111111101111110";
        wait for 50 ns;
        select_op <= "110"; --IS ODD
        x <= "0000000010000001";
        wait for 50 ns;
        select_op <= "111"; -- GREATER OR EQUAL
        x <= "0000000010000001";
        y <= "1111111101111101";
        wait for 50 ns;
        wait;
    end process;
end architecture;