library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity rom is
    port(
        clk: IN STD_LOGIC;
        address: IN unsigned(9 downto 0);
        data: OUT unsigned(13 downto 0)
    );
end entity rom;

architecture a_rom of rom is
    type mem is array (0 to 127) of unsigned(13 downto 0);
    constant rom_content : mem := (
        0 => B"0001_1_011_000000", -- ADD R3 0
        1 => B"0001_1_100_000000", -- ADD R4 0
        2 => B"0011_010_011_0000", -- MOV R2 <- R3 (salvar o valor de R3)
        3 => B"0001_0_011_100_000", -- ADD R3 R4
        4 => B"0011_100_011_0000", -- MOV R4 <- R3
        5 => B"0011_011_010_0000", -- MOV R3 <- R2 (retornar o valor de R3)
        6 => B"0001_1_011_000001", -- ADD R3 1
        7 => B"0011_010_011_0000", -- MOV R2 <- R3 (salvar o valor de R3)
        8 => B"0010_1_011_011110", -- SUB R3 30
        9 => B"0011_011_010_0000", -- MOV R3 <- R2 (retornar o valor de R3)
        10 => B"1110_01_00001000", -- JMPR < 8
        11 => B"0011_101_100_0000", -- MOV R5 <- R4
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


-- Instruções Assembly:

-- ADD R3 0 
-- ADD R4 0
-- MOV R2 R3
-- ADD R3 R4
-- MOV R4 R3
-- MOV R3 R2
-- ADD R3 1
-- MOV R2 R3
-- SUB R3 30
-- MOV R3 R2
-- JMPR 01 8
-- MOV R5 R4


