library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control_unit_tb is
end control_unit_tb;

architecture testbench of control_unit_tb is

    -- Component Declaration
    component control_unit
        port (
            opcode        : in  std_logic_vector(6 downto 0);
            mem_write     : out std_logic;
            branch        : out std_logic;
            reg_write     : out std_logic;
            mem_to_reg    : out std_logic;
            load_en       : out std_logic;
            wb_mux_sel    : out std_logic_vector(1 downto 0);
            operand_a_sel : out std_logic_vector(1 downto 0);
            operand_b_sel : out std_logic;
            next_pc_sel   : out std_logic_vector(1 downto 0);
            extend_sel    : out std_logic_vector(1 downto 0);
            ALU_op        : out std_logic_vector(2 downto 0)
        );
    end component;

    -- Signals
    signal opcode        : std_logic_vector(6 downto 0) := (others => '0');
    signal mem_write     : std_logic;
    signal branch        : std_logic;
    signal reg_write     : std_logic;
    signal mem_to_reg    : std_logic;
    signal load_en       : std_logic;
    signal wb_mux_sel    : std_logic_vector(1 downto 0);
    signal operand_a_sel : std_logic_vector(1 downto 0);
    signal operand_b_sel : std_logic;
    signal next_pc_sel   : std_logic_vector(1 downto 0);
    signal extend_sel    : std_logic_vector(1 downto 0);
    signal ALU_op        : std_logic_vector(2 downto 0);

    -- Clock Period (Not needed here as no clock is involved)
begin

    -- Instantiate the Unit Under Test (UUT)
    uut: control_unit
        port map (
            opcode         => opcode,
            mem_write      => mem_write,
            branch         => branch,
            reg_write      => reg_write,
            mem_to_reg     => mem_to_reg,
            load_en        => load_en,
            wb_mux_sel     => wb_mux_sel,
            operand_a_sel  => operand_a_sel,
            operand_b_sel  => operand_b_sel,
            next_pc_sel    => next_pc_sel,
            extend_sel     => extend_sel,
            ALU_op         => ALU_op
        );

    -- Stimulus Process
    stimulus_process: process
    begin
        -- Test 1: R-type Instruction (opcode = "0110011")
        opcode <= "0110011";
        wait for 10 ns;

        -- Test 2: Load-type Instruction (opcode = "0000011")
        opcode <= "0000011";
        wait for 10 ns;

        -- Test 3: Store-type Instruction (opcode = "0100011")
        opcode <= "0100011";
        wait for 10 ns;

        -- Test 4: Branch-type Instruction (opcode = "1100011")
        opcode <= "1100011";
        wait for 10 ns;

        -- Test 5: I-type Instruction (opcode = "0010011")
        opcode <= "0010011";
        wait for 10 ns;

        -- Test 6: JALR-type Instruction (opcode = "1100111")
        opcode <= "1100111";
        wait for 10 ns;

        -- Test 7: JAL-type Instruction (opcode = "1101111")
        opcode <= "1101111";
        wait for 10 ns;

        -- Test 8: LUI-type Instruction (opcode = "0110111")
        opcode <= "0110111";
        wait for 10 ns;

        -- Test 9: AUIPC-type Instruction (opcode = "0010111")
        opcode <= "0010111";
        wait for 10 ns;

        -- End of Simulation
        report "Simulation completed successfully!" severity note;
        wait;
    end process;

end testbench;
