library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_tb is
end top_tb;

architecture behavior of top_tb is
    -- Component Declaration for the Top Module
    component top
        port (
            clr_in   : in  std_logic;
            clk_in   : in  std_logic;
            read_en  : in  std_logic;
            seg      : out std_logic_vector (7 downto 0);
            dig      : out std_logic_vector (3 downto 0);
            tx_out   : out std_logic
        );
    end component;

    -- Signals for Stimulus and Monitoring
    signal clr_in_tb   : std_logic := '0';
    signal clk_in_tb   : std_logic := '0';
    signal read_en_tb  : std_logic := '0';
    signal seg_tb      : std_logic_vector (7 downto 0);
    signal dig_tb      : std_logic_vector (3 downto 0);
    signal tx_out_tb   : std_logic;

    -- Clock Period Definition
    constant CLK_PERIOD : time := 10 ns;

begin
    -- Instantiate the Top Module
    UUT: top
        port map (
            clr_in   => clr_in_tb,
            clk_in   => clk_in_tb,
            read_en  => read_en_tb,
            seg      => seg_tb,
            dig      => dig_tb,
            tx_out   => tx_out_tb
        );

    -- Clock Process: Generates a Clock Signal
    clk_process: process
    begin
        while true loop
            clk_in_tb <= '0';
            wait for CLK_PERIOD / 2;
            clk_in_tb <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
    end process;

    -- Stimulus Process: Generate Input Stimuli
    stim_process: process
    begin
        -- Apply Reset
        clr_in_tb <= '1';
        wait for 20 ns;
        clr_in_tb <= '0';

        -- Enable Read
        read_en_tb <= '1';
        wait for 50 ns;

        -- Disable Read
        read_en_tb <= '0';
        wait for 50 ns;

        -- Re-enable Read
        read_en_tb <= '1';
        wait for 100 ns;

        -- Finish Simulation
        wait;
    end process;

    -- Monitoring Output Signals in Waveform
end behavior;
