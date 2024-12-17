library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity data_memory_tb is
end data_memory_tb;

architecture testbench of data_memory_tb is

    -- Component Declaration
    component data_memory
        port (
            clk       : in  std_logic;
            data      : in  std_logic_vector(31 downto 0);
            address   : in  std_logic_vector(12 downto 0);
            write_en  : in  std_logic;
            byte_mode : in  std_logic_vector(2 downto 0);
            q         : out std_logic_vector(31 downto 0)
        );
    end component;

    -- Signals
    signal clk       : std_logic := '0';
    signal data      : std_logic_vector(31 downto 0) := (others => '0');
    signal address   : std_logic_vector(12 downto 0) := (others => '0');
    signal write_en  : std_logic := '0';
    signal byte_mode : std_logic_vector(2 downto 0) := "010";  -- Default to "word" mode
    signal q         : std_logic_vector(31 downto 0);

    -- Clock Period
    constant clk_period : time := 10 ns;

begin
    -- Instantiate Data Memory
    uut: data_memory
        port map (
            clk       => clk,
            data      => data,
            address   => address,
            write_en  => write_en,
            byte_mode => byte_mode,
            q         => q
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
        -- Test 1: Write a full word and read it back
        byte_mode <= "010";  -- Word mode
        address   <= "0000000000000";  -- Address 0
        data      <= x"DEADBEEF";
        write_en  <= '1';
        wait for clk_period;
        
        write_en  <= '0';  -- Disable writing
        wait for clk_period;

        -- Test 2: Write a halfword (signed) and read it back
        byte_mode <= "001";  -- Signed halfword
        address   <= "0000000000001";  -- Address 1
        data      <= x"0000FACE";  -- Lower 16 bits are FACE
        write_en  <= '1';
        wait for clk_period;

        write_en  <= '0';  -- Disable writing
        wait for clk_period;

        -- Test 3: Write an unsigned byte and read it back
        byte_mode <= "100";  -- Unsigned byte
        address   <= "0000000000010";  -- Address 2
        data      <= x"0000007F";  -- Only lower byte 7F
        write_en  <= '1';
        wait for clk_period;

        write_en  <= '0';  -- Disable writing
        wait for clk_period;

        -- Test 4: Write a signed byte and read it back
        byte_mode <= "000";  -- Signed byte
        address   <= "0000000000011";  -- Address 3
        data      <= x"000000FF";  -- Signed byte -1 (0xFF)
        write_en  <= '1';
        wait for clk_period;

        write_en  <= '0';  -- Disable writing
        wait for clk_period;

        -- Wait for Results
        wait for 50 ns;

        -- End Simulation
        report "Simulation Completed";
        wait;
    end process;

end testbench;
