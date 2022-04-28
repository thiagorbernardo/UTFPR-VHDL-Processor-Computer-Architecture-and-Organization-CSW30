library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processor is
    port(
        clk : IN  std_logic;
        rst : IN  std_logic;
        wr_en : IN std_logic;
        sel_y_alu : IN std_logic;
        select_reg_write : IN unsigned(2 downto 0);
        select_reg_a : IN unsigned(2 downto 0);
        select_reg_b : IN unsigned(2 downto 0);
        select_op: IN unsigned(2 downto 0);
        ext_in: IN unsigned(15 downto 0);
        output: OUT unsigned(15 downto 0)
    );
end entity processor;

architecture a_processor of processor is
    component alu is
        port
        (
            x         : IN unsigned (15 downto 0);
            y         : IN unsigned (15 downto 0);
            select_op : IN unsigned (2 downto 0);
            output    : OUT unsigned (15 downto 0)
        );
    end component alu;
    component reg_bank is
        port
        (
            clk              : IN std_logic ;
            rst              : IN std_logic ;
            wr_en            : IN std_logic ;
            select_reg_a     : IN unsigned (2 downto 0);
            select_reg_b     : IN unsigned (2 downto 0);
            select_write_reg : IN unsigned (2 downto 0);
            write_data       : IN unsigned (15 downto 0);
            reg_a            : OUT unsigned (15 downto 0);
            reg_b            : OUT unsigned (15 downto 0)
        );
    end component reg_bank;
    
    signal x_alu, y_alu, output_alu, reg_b, reg_a : unsigned(15 downto 0);
    
begin
    alu_instance: alu
    port map
    (
        x         =>   x_alu,
        y         =>   y_alu, -- 3) saida do mux na ula
        select_op =>   select_op,
        output    =>   output_alu
    );
    regs : reg_bank
    port map
    (
        clk              => clk,
        rst              => rst,
        wr_en            => wr_en,
        select_reg_a     => select_reg_a,
        select_reg_b     => select_reg_b,
        select_write_reg => select_reg_write,
        write_data       => output_alu, -- 1) saida da ula na entrada de dados do banco
        reg_a            => reg_a,
        reg_b            => reg_b
    );

    x_alu <= reg_a; -- 2) saida do banco direto na entrada da ula
    y_alu <= reg_b when sel_y_alu = '0' else -- 3) outra saida do banco no mux
               ext_in when sel_y_alu = '1' else -- 4) pino de entrada top level - cte externa
              "0000000000000000";
    
    output <= output_alu;

end architecture a_processor;