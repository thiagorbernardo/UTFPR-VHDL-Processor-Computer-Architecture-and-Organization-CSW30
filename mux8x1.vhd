library ieee;
use ieee.std_logic_1164.all;

entity mux8x1 is
    port( sel0, sel1, sel2: in std_logic;
        i0, i1, i2, i3, i4, i5, i6, i7: in std_logic;
        output: out std_logic
    );
end entity;

architecture a_mux8x1 of mux8x1 is
begin
    output <=
    i0 when sel2='0' and sel1='0' and sel0='0' else
    i1 when sel2='0' and sel1='0' and sel0='1' else
    i2 when sel2='0' and sel1='1' and sel0='0' else
    i3 when sel2='0' and sel1='1' and sel0='1' else
    i4 when sel2='1' and sel1='0' and sel0='0' else
    i5 when sel2='1' and sel1='0' and sel0='1' else
    i6 when sel2='1' and sel1='1' and sel0='0' else
    i7 when sel2='1' and sel1='1' and sel0='1' else
    '0';
end architecture;