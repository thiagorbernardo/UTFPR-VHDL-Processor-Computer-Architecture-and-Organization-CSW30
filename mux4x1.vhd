library ieee;
use ieee.std_logic_1164.all;

entity mux4x1 is
    port( sel0, sel1: in std_logic;
        i0, i1, i2, i3: in std_logic;
        output: out std_logic
    );
end entity;

architecture a_mux4x1 of mux4x1 is
begin
    output <= i0 when sel1='0' and sel0='0' else
    i1 when sel1='0' and sel0='1' else
    i2 when sel1='1' and sel0='0' else
    i3 when sel1='1' and sel0='1' else
    '0';
end architecture;