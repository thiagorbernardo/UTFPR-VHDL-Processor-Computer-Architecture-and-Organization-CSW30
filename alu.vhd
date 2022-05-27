library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu is
    port(
        x, y: in unsigned(13 downto 0);
        select_op: in unsigned(2 downto 0);
        output: out unsigned(13 downto 0);
        carry : out std_logic;
        zero : out std_logic
    );
    signal is_odd: unsigned(13 downto 0);
end entity;

architecture a_alu of alu is
begin
    is_odd <=
    "00000000000001" when x(0) = '1' else
    "00000000000000" when x(0) = '0' else
    "00000000000000";
    
    output <=
    x+y when select_op="000" else
    x-y when select_op="001" else
    x AND y when select_op="010" else
    x XOR y when select_op="011" else
    NOT x when select_op="100" else
    x OR y when select_op="101" else
    is_odd when select_op="110" else
    "00000000000000";

    zero <= '1' when x-y = "00000000000000" else '0';
    
    carry <= '1' when y > x else '0';
    
end architecture;

-- subtração