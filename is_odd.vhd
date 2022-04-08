library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity is_odd is
    port
    (
        x : in unsigned(15 downto 0);
        output: out std_logic
    );
end entity;

architecture a_is_odd of is_odd is
begin
    output <= x(0);
end architecture;