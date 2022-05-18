library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity rom is
    port(
        clk: IN STD_LOGIC;
        address: IN unsigned(6 downto 0);
        data: OUT unsigned(13 downto 0)
    );
end entity rom;

architecture a_rom of rom is
    type mem is array (0 to 127) of unsigned(13 downto 0);
    constant rom_content : mem := (
        0 => B"0000_0000000000", -- NOP
        1 => B"0001_0_001_011_000", -- ADD (Registrador) (Registrador)
        2 => B"0001_1_000_000000", -- ADD (Registrador) constante
        3 => B"0010_0_000_000_000", -- SUB (Registrador) (Registrador)
        4 => B"0010_1_000_000000", -- SUB (Registrador) constante
        5 => B"0011_001_011_0000", -- MOV (Registrador) (Registrador)
        6 => B"0000_0000000000", -- NOP
        7 => B"0000_0000000000", -- NOP
        8 => B"0000_0000000000", -- NOP
        9 => B"0000_0000000000", -- NOP
        10 => B"1111_0000000000", -- JA ADDR
        others => (others => '0')
    );
begin
    process(clk)
    begin
        if(rising_edge(clk)) then
            data <= rom_content(to_integer(address));
        end if;
    end process;
end architecture;