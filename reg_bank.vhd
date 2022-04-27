library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg_bank is
    port(
        clk, rst, wr_en : in std_logic;
        select_reg_a, select_reg_b, select_write_reg : in unsigned(2 downto 0);
        write_data: in unsigned(15 downto 0);
        reg_a, reg_b : out unsigned(15 downto 0)
    );
end entity;

architecture a_reg_bank of reg_bank is
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

    signal wr_en_1, wr_en_2, wr_en_3, wr_en_4, wr_en_5, wr_en_6, wr_en_7, wr_en_8 : std_logic;
    signal data_out_reg_1, data_out_reg_2, data_out_reg_3, data_out_reg_4, data_out_reg_5, data_out_reg_6, data_out_reg_7, data_out_reg_8: unsigned(15 downto 0);
begin
    reg1: reg16bits port map(clk => clk, rst => rst, wr_en => wr_en_1, data_in => write_data, data_out => data_out_reg_1);
    reg2: reg16bits port map(clk => clk, rst => rst, wr_en => wr_en_2, data_in => write_data, data_out => data_out_reg_2);
    reg3: reg16bits port map(clk => clk, rst => rst, wr_en => wr_en_3, data_in => write_data, data_out => data_out_reg_3);
    reg4: reg16bits port map(clk => clk, rst => rst, wr_en => wr_en_4, data_in => write_data, data_out => data_out_reg_4);
    reg5: reg16bits port map(clk => clk, rst => rst, wr_en => wr_en_5, data_in => write_data, data_out => data_out_reg_5);
    reg6: reg16bits port map(clk => clk, rst => rst, wr_en => wr_en_6, data_in => write_data, data_out => data_out_reg_6);
    reg7: reg16bits port map(clk => clk, rst => rst, wr_en => wr_en_7, data_in => write_data, data_out => data_out_reg_7);
   
    wr_en_1 <= wr_en when select_write_reg = "001" else '0';
    wr_en_2 <= wr_en when select_write_reg = "010" else '0';
    wr_en_3 <= wr_en when select_write_reg = "011" else '0';
    wr_en_4 <= wr_en when select_write_reg = "100" else '0';
    wr_en_5 <= wr_en when select_write_reg = "101" else '0';
    wr_en_6 <= wr_en when select_write_reg = "110" else '0';
    wr_en_7 <= wr_en when select_write_reg = "111" else '0';
  
    reg_a <= data_out_reg_1 when select_reg_a = "001" else 
      data_out_reg_2 when select_reg_a = "010" else 
      data_out_reg_3 when select_reg_a = "011" else 
      data_out_reg_4 when select_reg_a = "100" else 
      data_out_reg_5 when select_reg_a = "101" else 
      data_out_reg_6 when select_reg_a = "110" else 
      data_out_reg_7 when select_reg_a = "111" else 
      "0000000000000000";
  
    reg_b <= data_out_reg_1 when select_reg_b = "001" else 
      data_out_reg_2 when select_reg_b = "010" else 
      data_out_reg_3 when select_reg_b = "011" else 
      data_out_reg_4 when select_reg_b = "100" else 
      data_out_reg_5 when select_reg_b = "101" else 
      data_out_reg_6 when select_reg_b = "110" else 
      data_out_reg_7 when select_reg_b = "111" else 
      "0000000000000000";
end architecture;