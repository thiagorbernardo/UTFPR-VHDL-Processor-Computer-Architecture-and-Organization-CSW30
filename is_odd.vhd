library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity is_odd is
    port
    (
        x : in unsigned(15 downto 0);
        output: out unsigned(15 downto 0)
    );
end entity;

architecture a_is_odd of is_odd is
begin

    output <=
    "0000000000000001" when x(0) = '1' else
    "0000000000000000" when x(0) = '0' else
    "0000000000000000";
end architecture;