library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity state_machine is
    port(
        clk : in std_logic;
        rst : in std_logic;
        state : out unsigned(1 downto 0);
    );
end entity;

architecture a_state_machine of state_machine is
    signal internal_state: unsigned(1 downto 0);
begin
    process(clk,rst)
    begin
        if rst='1' then
            internal_state <= "00";
        elsif rising_edge(clk) then
            if (internal_state = "10") then
                internal_state <= "0";
            else
                internal_state <= internal_state + 1;
            end if;
        end if;
    end process;

    state <= internal_state;
end architecture;
