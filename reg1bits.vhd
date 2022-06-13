library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg1bits is
    port(
        clk : in std_logic;
        rst : in std_logic;
        wr_en : in std_logic;
        data_in : in std_logic;
        data_out : out std_logic
    );
end entity;

architecture a_reg1bits of reg1bits is
    signal reg: std_logic;
begin
    process(clk,rst,wr_en)
    begin
        if rst='1' then
            reg <= '0';
        elsif wr_en='1' then
            if rising_edge(clk) then
                reg <= data_in;
            end if;
        end if;
    end process;

    data_out <= reg;
end architecture;