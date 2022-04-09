library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity not_op is
    port
    (
        x : in unsigned(15 downto 0);
        output: out unsigned(15 downto 0)
    );
end entity;

architecture a_not_op of not_op is
begin

    output <= NOT x;
end architecture;