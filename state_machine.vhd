library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity state_machine is
    port(
        clk : in std_logic;
        rst : in std_logic;
        state : out std_logic
    );
end entity;

architecture a_state_machine of state_machine is
    signal internal_state: std_logic;
begin
    process(clk,rst)
    begin
        if rst='1' then
            internal_state <= '0';
        elsif rising_edge(clk) then
            internal_state <= not internal_state;
        end if;
    end process;

    state <= internal_state;
end architecture;
