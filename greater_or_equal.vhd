library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity greater_or_equal is
    port(
        x, y: in unsigned(15 downto 0);
        output: out std_logic
    );
end entity;

architecture a_greater_or_equal of greater_or_equal is
begin
    output <=
    '1' when x >= y else
    '0' when x < y else
    '0';
end architecture;