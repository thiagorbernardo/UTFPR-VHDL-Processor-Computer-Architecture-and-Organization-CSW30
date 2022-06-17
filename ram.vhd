library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ram is
    port(
        clk: IN std_logic;
        wr_en: IN std_logic;
        address: IN unsigned(5 downto 0);
        data_in: IN unsigned(13 downto 0);
        data_out: OUT unsigned(13 downto 0)
    );
end entity ram;

architecture a_ram of ram is
    type mem is array (0 to 127) of unsigned(13 downto 0);
    signal ram_content : mem;
begin
    process(clk,wr_en)
    begin
        if rising_edge(clk) then
            if wr_en='1' then
                ram_content(to_integer(address)) <= data_in;
            end if;
        end if;
    end process;
    data_out <= ram_content(to_integer(address));
end architecture;
