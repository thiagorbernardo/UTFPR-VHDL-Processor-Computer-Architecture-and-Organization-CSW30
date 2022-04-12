library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity or_op is
    port(
        x, y: in unsigned(15 downto 0);
        output: out unsigned(15 downto 0)
    );
end entity;

architecture a_or_op of or_op is
begin
    output <= x OR y;
end architecture;