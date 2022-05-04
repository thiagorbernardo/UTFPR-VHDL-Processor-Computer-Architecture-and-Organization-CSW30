library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uc is
    port(
        clk : IN  std_logic;
        rst : IN  std_logic;
        instruction : IN unsigned (14 downto 0);
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
    
    component state_machine is
        port
        (
            clk : in std_logic;
            rst : in std_logic;
            state : out std_logic
        );
    end component state_machine;

    
    signal PC_in, PC_out : unsigned(15 downto 0);
    signal opcode : unsigned(3 downto 0);
    signal state, PC_wr_en, jump_en : std_logic;
    
begin
    PC_reg: reg16bits
    port map
    (
        clk      => clk,
        rst      => rst,
        wr_en    => PC_wr_en,
        data_in  => PC_in,
        data_out => PC_out
    );
    
    stateMachine: state_machine
    port map
    (
        clk   => clk,
        rst   => rst,
        state => state
    );

    PC_wr_en <= state;
    
    opcode <= instruction(14 downto 11); -- AVERIGUAR

    jump_en <= '1' when opcode = "1111" else
    '0';

    PC_in <= PC_out(15 downto 11) & instruction (10 downto 0) when jump_en = '1' else
    PC_in + "0000000000000001";
    
    PC <= PC_in;
    
end architecture a_uc;