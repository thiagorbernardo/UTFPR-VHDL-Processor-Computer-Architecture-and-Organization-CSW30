library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uc is
    port(
        clk : IN  std_logic;
        rst : IN  std_logic;
        instruction_in : IN unsigned (13 downto 0);
        instruction_out : OUT unsigned (13 downto 0);
        PC: OUT unsigned(13 downto 0);
        fetch: OUT std_logic; -- booleano para dizer se esta em fetch
        decode: OUT std_logic; -- booleano para dizer se esta em decode
        execute: OUT std_logic; -- booleano para dizer se esta em execute
        state: OUT unsigned(1 downto 0) -- booleano para dizer em que etapa esta a maquina de estados
    );
end entity uc;

architecture a_uc of uc is
    component reg14bits is
        port
        (
            clk      : IN std_logic ;
            rst      : IN std_logic ;
            wr_en    : IN std_logic ;
            data_in  : IN unsigned (13 downto 0);
            data_out : OUT unsigned (13 downto 0)
        );
    end component;

    component state_machine is
        port
        (
            clk : in std_logic;
            rst : in std_logic;
            state : out unsigned(1 downto 0)
        );
    end component state_machine;
    
    signal PC_reg_in, PC_reg_out : unsigned(13 downto 0); -- input e output do program counter
    signal opcode : unsigned(3 downto 0); -- opcode -> add, jump, nop, etc
    signal PC_reg_wr_en, instruction_reg_wr_en, jump_en : std_logic; -- enables = permite escrever nos registradores ou fazer jump
    -- middlware signal para saidas
    signal instruction_out_internal : unsigned(13 downto 0); -- estado da maquina de estados
    signal state_internal : unsigned(1 downto 0); -- estado da maquina de estados
    signal fetch_internal, decode_internal, execute_internal : std_logic; -- booleano para dizer em que etapa esta a maquina de estados
    
begin
    PC_reg: reg14bits
    port map
    (
        clk      => clk,
        rst      => rst,
        wr_en    => PC_reg_wr_en,
        data_in  => PC_reg_in,
        data_out => PC_reg_out
    );

    instruction_reg: reg14bits
    port map
    (
        clk      => clk,
        rst      => rst,
        wr_en    => instruction_reg_wr_en,
        data_in  => instruction_in,
        data_out => instruction_out_internal
    );
    
    state_machine1: state_machine
    port map
    (
        clk   => clk,
        rst   => rst,
        state => state_internal
    );

    -- estados da maquina de estados
    fetch_internal <= '1' when state_internal = "00" else '0'; -- se está em fetch precisa escrever no instruction register
    instruction_reg_wr_en <= fetch_internal;
    decode_internal <= '1' when state_internal = "01" else '0'; -- se está em decode precisa escrever no program counter
    PC_reg_wr_en <= decode_internal;
    execute_internal <= '1' when state_internal = "10" else '0'; -- se está em execute ou nao

    -- dados da instrucao
    opcode <= instruction_out_internal(13 downto 10); -- opcode sao os 4 bits mais significativos da instrucao

    -- TODO: fiquei na duvida se pegava o jump pela ROM fazendo (13 downto 10), existe variavel global entre arquivos? arquivo de constantes talvez para graver opcodes
    jump_en <= '1' when opcode = "1111" else '0';

    -- se for jump, concatenar MSB do PC com o LSB da instrucao
    -- se nao somar 1
    PC_reg_in <= PC_reg_out(13 downto 10) & instruction_out_internal (9 downto 0) when jump_en = '1' else
    PC_reg_out + 1;--"0000000000001";

    -- repassando para output
    PC <= PC_reg_out;
    instruction_out <= instruction_out_internal;
    state <= state_internal;
    fetch <= fetch_internal;
    decode <= decode_internal;
    execute <= execute_internal;
end architecture a_uc;