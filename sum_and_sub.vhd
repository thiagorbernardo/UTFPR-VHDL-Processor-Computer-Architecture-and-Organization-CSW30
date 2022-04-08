library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity sum_and_sub is
    port(
        x,y: in unsigned(7 downto 0);
        sum, sub: out unsigned(7 downto 0)
    );
end entity;

architecture a_sum_and_sub of sum_and_sub is
begin
    sum <= x+y;
    sub <= x-y;
end architecture;