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
        0 => "00000000000000",
        1 => "00000000000001",
        2 => "00000000000010",
        3 => "00000000000100",
        4 => "00000000001000",
        5 => "00000000010000",
        6 => "00000000100000",
        7 => "00000001000000",
        8 => "00000010000000",
        9 => "00000100000000",
        10 => "00000100000000",
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