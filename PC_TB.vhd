library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_program_counter is
-- No ports in a testbench
end tb_program_counter;

architecture tb of tb_program_counter is
    -- Component Declaration
    component program_counter
        port (
            clk, clr, pc_en : in std_logic;
            address_in      : in std_logic_vector(31 downto 0);
            address_out     : out std_logic_vector(31 downto 0)
        );
    end component;

    -- Signal Declaration
    signal clk_tb        : std_logic := '0';
    signal clr_tb        : std_logic := '0';
    signal pc_en_tb      : std_logic := '0';
    signal address_in_tb : std_logic_vector(31 downto 0) := (others => '0');
    signal address_out_tb: std_logic_vector(31 downto 0);

    -- Clock Period
    constant CLK_PERIOD : time := 10 ns;

begin
    -- Instantiate the Program Counter
    uut: program_counter 
        port map (
            clk          => clk_tb,
            clr          => clr_tb,
            pc_en        => pc_en_tb,
            address_in   => address_in_tb,
            address_out  => address_out_tb
        );

    -- Clock Process
    clk_process: process
    begin
        while true loop
            clk_tb <= '0';
            wait for CLK_PERIOD / 2;
            clk_tb <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
    end process clk_process;

    -- Stimulus Process
    stimulus_process: process
    begin
        -- Reset the PC
        clr_tb <= '1';
        pc_en_tb <= '0';
        address_in_tb <= (others => '0');
        wait for CLK_PERIOD;
        
        clr_tb <= '0'; -- Release reset
        wait for CLK_PERIOD;

        -- Test Case 1: PC Enabled and Incremented
        pc_en_tb <= '1';
        address_in_tb <= std_logic_vector(to_unsigned(4, 32)); -- Address = 4
        wait for CLK_PERIOD;

        address_in_tb <= std_logic_vector(to_unsigned(8, 32)); -- Address = 8
        wait for CLK_PERIOD;

        address_in_tb <= std_logic_vector(to_unsigned(12, 32)); -- Address = 12
        wait for CLK_PERIOD;

        -- Test Case 2: PC Disabled
        pc_en_tb <= '0';
        address_in_tb <= std_logic_vector(to_unsigned(16, 32)); -- Address should not change
        wait for CLK_PERIOD;

        -- Test Case 3: Reset during operation
        clr_tb <= '1'; -- Apply reset
        wait for CLK_PERIOD;

        clr_tb <= '0'; -- Release reset
        wait for CLK_PERIOD;

        -- Finish Simulation
        report "Simulation Complete";
        wait;
    end process stimulus_process;
end tb;
