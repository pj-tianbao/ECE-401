library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mem_wb_regs_tb is
end mem_wb_regs_tb;

architecture testbench of mem_wb_regs_tb is

    -- Component Declaration
    component mem_wb_regs
        port (
            clk              : in  std_logic;
            ALU_in           : in  std_logic_vector(31 downto 0);
            datamem_in       : in  std_logic_vector(31 downto 0);
            wb_mux_in        : in  std_logic;
            reg_write_in     : in  std_logic;
            regs_address_in  : in  std_logic_vector(4 downto 0);
            wb_mux_sel_in    : in  std_logic_vector(1 downto 0);
            address_in       : in  std_logic_vector(31 downto 0);
            ALU_out          : out std_logic_vector(31 downto 0);
            datamem_out      : out std_logic_vector(31 downto 0);
            wb_mux_out       : out std_logic;
            reg_write_out    : out std_logic;
            regs_address_out : out std_logic_vector(4 downto 0);
            wb_mux_sel_out   : out std_logic_vector(1 downto 0);
            address_out      : out std_logic_vector(31 downto 0)
        );
    end component;

    -- Signals
    signal clk              : std_logic := '0';
    signal ALU_in           : std_logic_vector(31 downto 0) := (others => '0');
    signal datamem_in       : std_logic_vector(31 downto 0) := (others => '0');
    signal wb_mux_in        : std_logic := '0';
    signal reg_write_in     : std_logic := '0';
    signal regs_address_in  : std_logic_vector(4 downto 0) := (others => '0');
    signal wb_mux_sel_in    : std_logic_vector(1 downto 0) := (others => '0');
    signal address_in       : std_logic_vector(31 downto 0) := (others => '0');

    signal ALU_out          : std_logic_vector(31 downto 0);
    signal datamem_out      : std_logic_vector(31 downto 0);
    signal wb_mux_out       : std_logic;
    signal reg_write_out    : std_logic;
    signal regs_address_out : std_logic_vector(4 downto 0);
    signal wb_mux_sel_out   : std_logic_vector(1 downto 0);
    signal address_out      : std_logic_vector(31 downto 0);

    -- Clock Period
    constant clk_period : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: mem_wb_regs
        port map (
            clk              => clk,
            ALU_in           => ALU_in,
            datamem_in       => datamem_in,
            wb_mux_in        => wb_mux_in,
            reg_write_in     => reg_write_in,
            regs_address_in  => regs_address_in,
            wb_mux_sel_in    => wb_mux_sel_in,
            address_in       => address_in,
            ALU_out          => ALU_out,
            datamem_out      => datamem_out,
            wb_mux_out       => wb_mux_out,
            reg_write_out    => reg_write_out,
            regs_address_out => regs_address_out,
            wb_mux_sel_out   => wb_mux_sel_out,
            address_out      => address_out
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
        -- Test 1: Initialize inputs
        ALU_in           <= x"AAAAAAAA";
        datamem_in       <= x"12345678";
        wb_mux_in        <= '1';
        reg_write_in     <= '1';
        regs_address_in  <= "10101";
        wb_mux_sel_in    <= "10";
        address_in       <= x"0000FFFF";
        wait for clk_period;

        -- Test 2: Update inputs
        ALU_in           <= x"55555555";
        datamem_in       <= x"87654321";
        wb_mux_in        <= '0';
        reg_write_in     <= '0';
        regs_address_in  <= "01010";
        wb_mux_sel_in    <= "01";
        address_in       <= x"FFFF0000";
        wait for clk_period;

        -- Test 3: Further Update inputs
        ALU_in           <= x"DEADBEEF";
        datamem_in       <= x"FEEDC0DE";
        wb_mux_in        <= '1';
        reg_write_in     <= '1';
        regs_address_in  <= "11111";
        wb_mux_sel_in    <= "11";
        address_in       <= x"00000001";
        wait for clk_period;

        -- End Simulation
        report "MEM/WB Registers Testbench completed successfully!" severity note;
        wait;
    end process;

end testbench;
