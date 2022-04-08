library ieee;
use ieee.std_logic_1164.all;

entity mux8x1_tb is
end;

architecture a_mux8x1_tb of mux8x1_tb is
    component mux8x1 is
        port
        (
            sel0   : in std_logic ;
            sel1   : in std_logic ;
            sel2   : in std_logic ;
            i0     : in std_logic ;
            i1     : in std_logic ;
            i2     : in std_logic ;
            i3     : in std_logic ;
            i4     : in std_logic ;
            i5     : in std_logic ;
            i6     : in std_logic ;
            i7     : in std_logic ;
            output : out std_logic
        );
    end component;
    signal sel2, sel1, sel0, i0, i1, i2, i3, i4, i5, i6, i7, output: std_logic;
begin
    uut: mux8x1
    port map
    (
        sel0   => sel0,
        sel1   => sel1,
        sel2   => sel2,
        i0     => i0,
        i1     => i1,
        i2     => i2,
        i3     => i3,
        i4     => i4,
        i5     => i5,
        i6     => i6,
        i7     => i7,
        output => output
    );

    
    process
    begin
        i0 <= '1';
        i1 <= '0';
        i2 <= '1';
        i3 <= '0';
        i4 <= '1';
        i5 <= '0';
        i6 <= '1';
        i7 <= '0';
        sel0 <= '0';
        sel1 <= '0';
        sel2 <= '0';
        wait for 50 ns;
        sel0 <= '1';
        sel1 <= '0';
        sel2 <= '0';
        wait for 50 ns;
        sel0 <= '0';
        sel1 <= '1';
        sel2 <= '0';
        wait for 50 ns;
        sel0 <= '1';
        sel1 <= '1';
        sel2 <= '0';
        wait for 50 ns;
        sel0 <= '0';
        sel1 <= '0';
        sel2 <= '1';
        wait for 50 ns;
        sel0 <= '1';
        sel1 <= '0';
        sel2 <= '1';
        wait for 50 ns;
        sel0 <= '0';
        sel1 <= '1';
        sel2 <= '1';
        wait for 50 ns;
        sel0 <= '1';
        sel1 <= '1';
        sel2 <= '1';
        wait for 50 ns;
        wait;
    end process;
end architecture;