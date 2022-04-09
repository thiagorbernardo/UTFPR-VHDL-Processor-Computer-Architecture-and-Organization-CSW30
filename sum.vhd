library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sum is
    port(
        x, y: in unsigned(15 downto 0);
        output: out unsigned(15 downto 0)
    );
end entity;

architecture a_sum of sum is
begin
    output <= x+y;
end architecture;