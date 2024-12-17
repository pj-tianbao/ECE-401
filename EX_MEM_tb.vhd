library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity if_id_tb is
end if_id_tb;

architecture testbench of if_id_tb is

    -- Component Declaration
    component if_id_regs
        port (
            clk             : in  std_logic;
            clr             : in  std_logic;
            regs_en_IFID    : in  std_logic;
            flush_sig       : in  std_logic;
            instruction_in  : in  std_logic_vector (31 downto 0);
            address_in      : in  std_logic_vector (31 downto 0);
            instruction_out : out std_logic_vector (31 downto 0);
            address_out     : out std_logic_vector (31 downto 0);
            pc_out          : out std_logic_vector (31 downto 0)
        );
    end component;

    -- Signals
    signal clk             : std_logic := '0';
    signal clr             : std_logic := '0';
    signal regs_en_IFID    : std_logic := '0';
    signal flush_sig       : std_logic := '0';
    signal instruction_in  : std_logic_vector (31 downto 0) := (others => '0');
    signal address_in      : std_logic_vector (31 downto 0) := (others => '0');
    signal instruction_out : std_logic_vector (31 downto 0);
    signal address_out     : std_logic_vector (31 downto 0);
    signal pc_out          : std_logic_vector (31 downto 0);

    -- Clock Period
    constant clk_period : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: if_id_regs
        port map (
            clk             => clk,
            clr             => clr,
            regs_en_IFID    => regs_en_IFID,
            flush_sig       => flush_sig,
            instruction_in  => instruction_in,
            address_in      => address_in,
            instruction_out => instruction_out,
            address_out     => address_out,
            pc_out          => pc_out
        );

    -- Clock Process
    clk_process: process
    begin
        while true loop
            clk <= '0';
            wait for clk_period / 2;
            clk <= '1';
            wait for clk_period / 2;
        end loop;
    end process;

    -- Stimulus Process
    stimulus_process: process
    begin
        -- Reset the IF/ID registers
        clr <= '1';
        regs_en_IFID <= '0';
        flush_sig <= '0';
        wait for clk_period;
        clr <= '0';

        -- Test 1: Load Instruction and Address
        regs_en_IFID <= '1';
        instruction_in <= x"00000001";
        address_in <= x"00000004";
        wait for clk_period;

        -- Test 2: Update Instruction and Address
        instruction_in <= x"12345678";
        address_in <= x"00000008";
        wait for clk_period;

        -- Test 3: Flush Signal Active
        flush_sig <= '1';
        wait for clk_period;

        -- Disable Flush
        flush_sig <= '0';
        instruction_in <= x"87654321";
        address_in <= x"0000000C";
        wait for clk_period;

        -- Test 4: Disable Register Enable
        regs_en_IFID <= '0';
        instruction_in <= x"DEADBEEF";
        address_in <= x"00000010";
        wait for clk_period;

        -- Re-enable Register Enable
        regs_en_IFID <= '1';
        wait for clk_period;

        -- End Simulation
        report "IF/ID Stage Testbench completed successfully!" severity note;
        wait;
    end process;

end testbench;
