library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uc is
    port(
        clk : IN  std_logic;
        rst : IN  std_logic;
        wr_en : IN std_logic;
        PC: OUT unsigned(15 downto 0)
    );
end entity uc;

architecture a_uc of uc is
    component reg16bits is
        port
        (
            clk      : IN std_logic ;
            rst      : IN std_logic ;
            wr_en    : IN std_logic ;
            data_in  : IN unsigned (15 downto 0);
            data_out : OUT unsigned (15 downto 0)
        );
    end component;
    
    signal PC_in, PC_out : unsigned(15 downto 0);
begin
    PC_reg: reg16bits
    port map
    (
        clk      => clk,
        rst      => rst,
        wr_en    => '1',
        data_in  => PC_in,
        data_out => PC_out
    );

    output <= output_alu;

end architecture a_uc;