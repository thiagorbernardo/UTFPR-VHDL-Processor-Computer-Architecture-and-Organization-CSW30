library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity and_op is
    port(
        x, y: in unsigned(15 downto 0);
        output: out std_logic
    );
end entity;

architecture a_and_op of and_op is
begin
    output <= x AND y;
end architecture;