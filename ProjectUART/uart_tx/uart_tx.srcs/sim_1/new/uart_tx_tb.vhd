library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_tb is
end entity top_tb;

architecture behavioral of top_tb is

  -- Component declaration for DUT
  component top is
    port (
      CLK100MHZ : in    std_logic;  -- Main clock
      SW        : in    std_logic_vector(7 downto 0); -- Data values
      JA        : out   std_logic;  -- Output port
      BTNC      : in    std_logic;  -- Synchronous reset
      LED       : out   std_logic_vector(7 downto 0)
    );
  end component;

  -- Test input signals
  signal clk : std_logic := '0';
  signal reset : std_logic := '0';
  signal sw : std_logic_vector(7 downto 0) := (others => '0');
  
  -- Expected output signals
  signal ja : std_logic;
  signal led : std_logic_vector(7 downto 0);

begin

  -- Instantiate the DUT
  uut : top
    port map (
      CLK100MHZ => clk,
      SW        => sw,
      JA        => ja,
      BTNC      => reset,
      LED       => led
    );

  -- Clock generation
  clk_process : process
  begin
    while now < 10 ms loop  -- Run for 10ms
      clk <= not clk;
      wait for 5 ns; -- 200 MHz
    end loop;
    wait;
  end process;

  -- Testbench process
  tb_process : process
  begin
    -- Reset
    reset <= '1';
    wait for 50 ns;
    reset <= '0';

    -- Test cases
    wait for 100 ns;
    sw <= "00000001";  -- Set switch 0 to 1
    wait for 100 ns;
    sw <= "00000010";  -- Set switch 1 to 1
    wait for 100 ns;
    sw <= "00000100";  -- Set switch 2 to 1
    wait for 100 ns;
    sw <= "00001000";  -- Set switch 3 to 1
    wait for 100 ns;
    sw <= "00010000";  -- Set switch 4 to 1
    wait for 100 ns;
    sw <= "00100000";  -- Set switch 5 to 1
    wait for 100 ns;
    sw <= "01000000";  -- Set switch 6 to 1
    wait for 100 ns;
    sw <= "10000000";  -- Set switch 7 to 1
    wait for 100ns;

    -- End testbench
    wait;
  end process;

end architecture behavioral;
