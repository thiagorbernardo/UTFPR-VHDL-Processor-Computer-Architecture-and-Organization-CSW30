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
        reg_a_output      : out unsigned(13 downto 0);
        reg_b_output      : out unsigned(13 downto 0);
        output     : out unsigned(13 downto 0)
    );
end entity processor;

architecture a_processor of processor is
    component rom is
        port
        (
            clk     : IN STD_LOGIC ;
            address : IN unsigned (9 downto 0);
            data    : OUT unsigned (13 downto 0)
        );
    end component;
    
    component uc is
        port
        (
            clk             : IN std_logic ;
            rst             : IN std_logic ;
            jump_en         : IN std_logic ;
            address         : IN unsigned (9 downto 0);
            instruction_in  : IN unsigned (13 downto 0);
            instruction_out : OUT unsigned (13 downto 0);
            PC              : OUT unsigned (13 downto 0);
            fetch           : OUT std_logic ;
            decode          : OUT std_logic ;
            execute         : OUT std_logic ;
            state           : OUT unsigned (1 downto 0)
        );
    end component;

    component alu is
        port
        (
            x         : IN unsigned (13 downto 0);
            y         : IN unsigned (13 downto 0);
            select_op : IN unsigned (2 downto 0);
            output    : OUT unsigned (13 downto 0);
            carry     : OUT std_logic;
            zero      : OUT std_logic
        );
    end component;

    component reg_bank is
        port
        (
            clk              : IN std_logic ;
            rst              : IN std_logic ;
            wr_en            : IN std_logic ;
            select_reg_a     : IN unsigned (2 downto 0);
            select_reg_b     : IN unsigned (2 downto 0);
            select_write_reg : IN unsigned (2 downto 0);
            write_data       : IN unsigned (13 downto 0);
            reg_a            : OUT unsigned (13 downto 0);
            reg_b            : OUT unsigned (13 downto 0)
        );
    end component;
    
    component reg1bits is
        port
        (
            clk      : IN std_logic ;
            rst      : IN std_logic ;
            wr_en    : IN std_logic ;
            data_in  : IN std_logic ;
            data_out : OUT std_logic
        );
    end component;

    signal Z, C, wr_en_flags : std_logic; -- flag real -> somente atualizada em operacoes de ula (add, sub)
    signal zero_internal, carry_internal : std_logic; -- saida da ula indicando carry e zero
    signal alu_x, alu_y, alu_out, proc_regA, proc_regB : unsigned(13 downto 0); -- portas da ula

    signal reg_bank_wr_en, sel_in_alu : std_logic; -- enable para saber se vai escrever no banco, seletor de operacao da ula
    signal sel_write_reg, sel_reg_a, sel_reg_b, select_op : unsigned(2 downto 0);

    signal instruction_address : unsigned(9 downto 0); -- ROM input
    signal PC_internal : unsigned(13 downto 0); -- Resultado do PC
    signal rom_output : unsigned(13 downto 0); -- endereco da ROM
    signal jump_address: unsigned(9 downto 0);
    signal jump_en: STD_LOGIC;

    signal state_internal : unsigned(1 downto 0); -- estado da maquina de estados
    signal fetch, execute, decode : std_logic; -- booleano que indica qual estado esta a maquina de estados

    signal instruction_reg : unsigned(13 downto 0); -- registrador que guarda a intrucao usada
    signal opcode : unsigned(13 downto 10);

    signal select_add_sub_source : std_logic; -- flag que indica se a operacao usa registrador ou constante
    signal select_compare : unsigned(1 downto 0); -- 2 bits para indicar qual a comparacao
    signal top_level : unsigned(13 downto 0);


    constant opcode_nop : unsigned(3 downto 0) := "0000";
    constant opcode_add : unsigned(3 downto 0) := "0001";
    constant opcode_sub : unsigned(3 downto 0) := "0010";
    constant opcode_move : unsigned(3 downto 0) := "0011";
    constant opcode_jump : unsigned(3 downto 0) := "1111";
    constant opcode_jump_rel : unsigned(3 downto 0) := "1110";

begin
    rom1: rom
    port map (
        clk => clk,
        address => instruction_address,
        data => rom_output
    );
    
    uc1: UC
    port map (
        clk => clk,
        rst => rst,
        instruction_in => rom_output,
        address => jump_address,
        jump_en => jump_en,
        instruction_out => instruction_reg,
        state => state_internal,
        fetch => fetch,
        decode => decode,
        execute => execute,
        PC => PC_internal
    );
    
    alu1 : alu
    port map
    (
        x => alu_x,
        y => alu_y,
        select_op => select_op,
        output => alu_out,
        carry => carry_internal,
        zero => zero_internal
    );
    
    regs: reg_bank
    port map(
        clk => clk,
        rst => rst,
        wr_en => reg_bank_wr_en,
        select_write_reg => sel_write_reg, -- operacoes sempre escritas no reg a
        select_reg_a => sel_write_reg, -- operacoes sempre no reg a
        select_reg_b => sel_reg_b,
        write_data => alu_out,
        reg_a => proc_regA,
        reg_b => proc_regB
    );
    
    reg_carry: reg1bits
    port map
    (
        clk      => clk,
        rst      => rst,
        wr_en    => wr_en_flags,
        data_in  => carry_internal,
        data_out => C
    );
    
    reg_zero: reg1bits
    port map
    (
        clk      => clk,
        rst      => rst,
        wr_en    => wr_en_flags,
        data_in  => zero_internal,
        data_out => Z
    );

    
    opcode <= instruction_reg(13 downto 10); -- opcode sao os 4 bits mais significativos da instrucao (MSB)

    select_add_sub_source <= instruction_reg(9); -- select do add e sub, para saber se ira pegar de um registrador ou constante (add ou addi)
    select_compare <= instruction_reg(9 downto 8); -- select de comparacao, maior, etc
    
    top_level <= "00000000" & instruction_reg(5 downto 0) when opcode = opcode_add or opcode = opcode_sub else -- Resto do add é a constante da operação executada
                "000000" & instruction_reg(7 downto 0) when opcode = opcode_jump_rel else -- Delta do branch
                "00000000000000";
    
    -- procurando qual o registrador b sera usado para a operacao
    sel_reg_b <= instruction_reg(6 downto 4) when opcode = opcode_move else
    instruction_reg(5 downto 3) when ((opcode = opcode_add or opcode = opcode_sub) and select_add_sub_source = '0') else
                 "000";

    reg_bank_wr_en <= '1' when execute = '1' and (opcode = opcode_add or opcode = opcode_sub or opcode = opcode_move) else '0';

    sel_in_alu <= '0' when (((opcode = opcode_add or opcode = opcode_sub) and select_add_sub_source = '0') or opcode = opcode_move) else '1';

    sel_write_reg <= instruction_reg(8 downto 6) when (opcode = opcode_add or opcode = opcode_sub) else
    instruction_reg(9 downto 7) when (opcode = opcode_move) else
                     "000"; -- Sempre escreve no regA - no caso ira cair nessa condicao para jmps, jmpr e nop, ou seja, write enable estara em 0
    
    select_op <= "000" when opcode = opcode_add or opcode = opcode_move else
                 "001" when opcode = opcode_sub else
                 "111"; -- operacao de jump, nop e jmpr faz nada na ula

    -- atualizar flags em operacao de ula
    wr_en_flags <= '1' when execute = '1' and (opcode = opcode_add or opcode = opcode_sub) else '0';
    
    instruction_address <= PC_internal(9 downto 0) + (NOT(top_level(9 downto 0)) + 1) when opcode = opcode_jump_rel and Z = select_compare(1) and C = select_compare(0) and decode='1'
else PC_internal(9 downto 0); -- Usar complemento de 2
    
    jump_en <= '1' when opcode = opcode_jump OR (opcode = opcode_jump_rel and Z = select_compare(1) and C = select_compare(0)) else '0';
    jump_address <= instruction_address when opcode = opcode_jump_rel else instruction_reg(9 downto 0);

    -- se for move pegar o registrador 0 para fazer 0 + registrador
    alu_x <= "00000000000000" when opcode = opcode_move else proc_regA;
    alu_y <= proc_regB  when sel_in_alu = '0' else
    top_level  when sel_in_alu = '1' else
             "00000000000000";

    state <= state_internal;
    PC <= PC_internal;
    output <= alu_out;
    instruction <= instruction_reg;
    reg_a_output <= proc_regA;
    reg_b_output <= proc_regB;
end architecture a_processor;

-- Operação de ula escreve nas flags de carry e zero
-- Agt faz uma operação de jump condicional depois de um sub e olha as flags
-- só atualiza flag se for conta de ula, ignorar jump etc