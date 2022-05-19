library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity processor is
    port (
        clk       : in  std_logic;
        rst       : in  std_logic;
        state    : out unsigned(1 downto 0);
        PC        : out unsigned(13 downto 0);
        instruction : out unsigned(13 downto 0);
        reg1      : out unsigned(13 downto 0);
        reg2      : out unsigned(13 downto 0);
        output     : out unsigned(13 downto 0)
    );
end entity processor;

architecture a_processor of processor is
    component rom
    port(
        clk    : in  std_logic;
        address : in  unsigned(9 downto 0);
        data     : out unsigned(13 downto 0)
    );
end component rom;

component UC
port (
    clk           : in  std_logic;
    rst         : in  std_logic;
    instruction_in  : in  unsigned(13 downto 0);
    instruction_out : out unsigned(13 downto 0);
    state        : out unsigned(1 downto 0);
    fetch         : out std_logic;
    decode        : out std_logic;
    execute       : out std_logic;
    PC            : out unsigned(13 downto 0)
);
end component UC;

component ALU is
    port (
        x, y                      : in  unsigned(13 downto 0);
        sel_op                            : in  unsigned(2 downto 0);
        output                             : out unsigned(13 downto 0)
    );
end component ALU;

component reg_bank is
    port (
        clk         : in  std_logic;
        rst         : in  std_logic;
        wr_en       : in  std_logic;
        sel_write_reg : in  unsigned(2 downto 0);
        sel_reg_a     : in  unsigned(2 downto 0);
        sel_reg_b     : in  unsigned(2 downto 0);
        write_data   : in  unsigned(13 downto 0);
        reg_a        : out unsigned(13 downto 0);
        reg_b        : out unsigned(13 downto 0)
    );
end component reg_bank;

signal alu_x, alu_y, alu_out, reg_b : unsigned(13 downto 0);

signal reg_wr_en, sel_in_alu                         : std_logic;
signal sel_write_reg, sel_reg_a, sel_reg_b, sel_op                       : unsigned(2 downto 0);

signal instruction_address : unsigned(9 downto 0);
signal PC_in         : unsigned(13 downto 0);
signal memory_out      : unsigned(13 downto 0);

signal state_in         : unsigned(1 downto 0);
signal fetch, execute, decode : std_logic;

signal instruction_reg : unsigned(13 downto 0);
signal opcode        : unsigned(13 downto 11);

signal sel_operator_arithmetic    : std_logic;
signal top_level                    : unsigned(13 downto 0);
signal sel_reg_arithmetic : unsigned(2 downto 0);


constant opcode_nop : unsigned(3 downto 0) := "0000";
constant opcode_add : unsigned(3 downto 0) := "0001";
constant opcode_sub : unsigned(3 downto 0) := "0010";
constant opcode_move  : unsigned(3 downto 0) := "0011";
constant opcode_jump  : unsigned(3 downto 0) := "1111";
begin
    rom1: rom
    port map (
        clk => clk,
        address => instruction_address,
        data => memory_out
    );
    
    uc1: UC
    port map (
        clk => clk,
        rst => rst,
        instruction_in => memory_out,
        instruction_out => instruction_reg,
        state => state_in,
        fetch => fetch,
        decode => decode,
        execute => execute,
        PC => PC_in
    );
    
    alu1 : alu
    port map
    (
        x => alu_x,
        y => alu_y,
        sel_op => sel_op,
        output => alu_out
    );
    
    regs: reg_bank
    port map(
        clk => clk,
        rst => rst,
        wr_en => reg_wr_en,
        sel_write_reg => sel_write_reg,
        sel_reg_a => sel_reg_a,
        sel_reg_b => sel_reg_b,
        write_data => alu_out,
        regA => alu_x,
        regB => reg_b
    );
    
    opcode <= instruction_reg(13 downto 10); -- opcode esta nos 3 primeiros MSB

    sel_operator_arithmetic <= instruction_reg(9); -- select do add e sub 
    
    top_level <= "0000000" & instruction_reg(6 downto 0) when opcode = opcode_add or opcode = opcode_sub else -- Resto do add é a constante da operação executada
                   "00000000000000";
    
    sel_reg_arithmetic <= instruction_reg(6 downto 4) when opcode = opcode_move else
    instruction_reg(5 downto 3) when ((opcode = opcode_add or opcode = opcode_sub) and sel_operator_arithmetic = 1) else
                          "000";

    reg_wr_en <= '1' when execute = '1' and (opcode = opcode_add or opcode = opcode_sub or opcode = opcode_move) else
    '0';

    sel_in_alu <= '0' when (((opcode = opcode_add or opcode = opcode_sub) and sel_operator_arithmetic = "0") or opcode = opcode_move) else
    '1';


    sel_write_reg <= instruction_reg(8 downto 6) when (opcode = opcode_add or opcode = opcode_sub) else
                     instruction_reg(9 downto 7) when (opcode = opcode_move) else
                     "000"; -- Sempre escreve no reg_a
    
    sel_reg_a <= sel_write_reg;
    

    sel_reg_b <= sel_reg_arithmetic;

    sel_op <= "000" when opcode = opcode_add or opcode = opcode_move else
              "001" when opcode = opcode_sub else
              "000";

    instruction_address <= PC_in(9 downto 0); 

    alu_y <= reg_b      when sel_in_alu = '0' else
             top_level  when sel_in_alu = '1' else
             "0000000000000";
    
    state <= state_in;
    PC <= PC_in;
    output <= alu_out;
    instruction <= instruction_reg;
    reg1 <= alu_x;
    reg2 <= reg_b;
    
end architecture a_processor;