library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity xor_op is
    port(
        x, y: in unsigned(15 downto 0);
        output: out unsigned(15 downto 0)
    );
end entity;

architecture a_xor_op of xor_op is
begin
    output <= x XOR y;
end architecture;