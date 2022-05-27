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
        0 => B"0001_1_011_000000", -- Add R3 0
        1 => B"0001_1_100_000000", -- Add R4 0
        2 => B"0011_010_011_000000", -- Mov R2 <- R3 (salvar o valor de R3)
        3 => B"0001_0_011_100_000", -- Add R3 R4
        4 => B"0011_100_011_000000", -- Mov R4 <- R3
        5 => B"0011_011_010_000000", -- Mov R3 <- R2 (retornar o valor de R3)
        6 => B"0001_1_011_000001", -- Add R3 1
        7 => B"0000_0000000000",
        8 => B"0000_0000000000",
        9 => B"0000_0000000000",
        10 => B"0000_0000000000",
        11 => B"0000_0000000000",
        12 => B"0000_0000000000",
        13 => B"0000_0000000000",
        14 => B"0000_0000000000",
        15 => B"0000_0000000000",
        16 => B"0000_0000000000",
        17 => B"0000_0000000000",
        18 => B"0000_0000000000",
        19 => B"0000_0000000000",
        20 => B"0011_011_101_0000",
        21 => B"1111_0000000011",
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

-- ASSEMBLY
-- ADD R3 5: 0001_1_011_000101
-- ADD R4 8: 0001_1_100_001000
-- ADD R3 R4: 0001_0_011_100_000
-- SUB R5 1: 0010_1_101_000001
-- JMPS 20: 1111_0000010100
-- MOV R3 R5: 0011_011_101_000000
-- JMPS terceira-instrucao: 1111_0000000011



-- JMPA 1110_0_001_000
-- JMPA opcode_selectAlu_reg
-- Colocar bits pro delta

-- Usar dois flip flop para dizer se faz carry ou não no top level, se for ula altera os flip flop, quando é condicional ve os flip flop