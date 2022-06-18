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
    signal address_int: integer;
    signal data_in: unsigned(9 downto 0);
    signal data_out: unsigned(13 downto 0);
    constant x: unsigned(9 downto 0) := "0000000011";
    constant rom_content : mem := (
        0 => B"0011_100_000_0000", -- MOV R4,R0
        1 => B"0001_1_111_000010", -- ADD R7,2
        2 => B"0100_100_111_0000", -- MOVREAD R4,R7
        3 => B"0011_011_000_0000", -- MOV R3, R0
        4 => B"0001_1_011_101010", -- ADD R3, 42
        5 => B"0011_111_000_0000", -- MOV R7, R0
        6 => B"0001_1_111_000011", -- ADD R7 3
        7 => B"0110_111_011_0000", -- MOVWRITE R7, R3
        8 => B"0010_1_011_011110", -- SUB R3 30
        9 => B"0011_011_010_0000", -- MOV R3 <- R2 (retornar o valor de R3)
        10 => B"1110_01_00001000", -- JMPR - 8
        11 => B"0011_101_100_0000", -- MOV R5 <- R4
        -- 0 => B"0011_100_000_0000", -- MOV R4,R0
        -- 1 => B"0001_1_111_000010", -- ADD R7,2
        -- 2 => B"0100_100_111_0000", -- MOVREAD R4,R7
        others => (others => '0')
    );
begin
    process(clk)
    begin
        if(rising_edge(clk)) then
            address_int <= to_integer(address);
            data_in <= address;
            data_out <= rom_content(9);
            data <= rom_content(to_integer(address));
        end if;
    end process;
end architecture;


-- Instruções Assembly:

-- ADD R3,#0
-- ADD R4,#0
-- MOV R2,R3
-- ADD R3,R4
-- MOV R4,R3
-- MOV R3,R2
-- ADD R3,#1
-- MOV R2,R3
-- SUB R3,#30
-- MOV R3,R2
-- JMPR cc_ULT,#8
-- MOV R5,R4


