library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu is
    port(
        x, y: in unsigned(15 downto 0);
        select_op: in unsigned(2 downto 0);
        output: out unsigned(15 downto 0)
    );
    variable sum_out, sub_out, and_out, xor_out, or_out, gte_out, is_odd_out, not_out: unsigned(15 downto 0);
end entity;

architecture a_alu of alu is
begin
    sum_ezx: sum
    port map
    (
        x      => x,
        y      => y,
        output => sum_out
    );
    
    sub: sub
    port map
    (
        x      => x,
        y      => y,
        output => sub_out
    );
    
    and_op: and_op
    port map
    (
        x      => x,
        y      => y,
        output => and_out
    );
    
    xor_op: xor_op
    port map
    (
        x      => x,
        y      => y,
        output => xor_out
    );

    greater_or_equal: greater_or_equal
    port map
    (
        x      => x,
        y      => y,
        output => greater_or_equal
    );
end architecture;