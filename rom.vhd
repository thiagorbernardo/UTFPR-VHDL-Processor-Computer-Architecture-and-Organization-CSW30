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
    type mem is array (0 to 511) of unsigned(13 downto 0);
    signal address_int: integer;
    signal data_in: unsigned(9 downto 0);
    signal data_out: unsigned(13 downto 0);
    constant x: unsigned(9 downto 0) := "0000000011";
    constant rom_content : mem := (
        0 => B"0011_001_000_0000", -- MOV R1,R0
        1 => B"0001_1_001_000001", -- ADD R1,1
        2 => B"0001_1_001_000001", -- ADD R1,1
        3 => B"0011_111_001_0000", -- MOV R7, R1
        4 => B"0110_111_001_0000", -- MOVWRITE R7, R1
        5 => B"0011_010_001_0000", -- MOV R2, R1
        6 => B"0010_1_001_100000", -- SUB R1 32
        7 => B"0011_001_010_0000", -- MOV R1, R2
        8 => B"1110_01_00000110", -- JMPR - 6 -- IT WORKS
        9 => B"0011_001_000_0000", -- MOV R1,R0
        10 => B"0011_010_000_0000", -- MOV R2,R0
        11 => B"0001_1_001_000001", -- ADD R1,1
        12 => B"0001_1_001_000001", -- ADD R1,1
        13 => B"0011_111_001_0000", -- MOV R7,R1
        14 => B"0001_0_111_001_000", -- ADD R7,R1
        15 => B"0110_111_000_0000", -- MOVWRITE R7,R0
        16 => B"0011_010_111_0000", -- MOV R2,R7
        17 => B"0010_1_010_100000", -- SUB R2,32
        18 => B"1110_01_00000100", -- JUMPREL 10,4
        19 => B"0011_010_001_0000", -- MOV R2,R1
        20 => B"0010_1_010_000110", -- SUB R2,6
        21 => B"1110_01_00001001", -- JUMPREL 10,9

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


