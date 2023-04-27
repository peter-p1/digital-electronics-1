
library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all; -- Package for arithmetic operations

----------------------------------------------------------
-- entita clock_enable vysilac
----------------------------------------------------------

entity clock_enable_tx is
  port (
    clk : in    std_logic; --! Main clock
    rst : in    std_logic; --! High-active synchronous reset
    ce  : out   std_logic;  --! Clock enable pulse signal
    max : in natural        -- nastaveni rychlosti
  );
end entity clock_enable_tx;

------------------------------------------------------------
-- Architecture body for clock enable
------------------------------------------------------------

architecture behavioral of clock_enable_tx is

  -- Local counter
  signal sig_cnt : natural;

begin

  --------------------------------------------------------
  -- p_clk_enable:
  -- Generate clock enable signal. By default, enable signal
  -- is low and generated pulse is always one clock long.
  --------------------------------------------------------
  p_clk_enable : process (clk) is
  begin
    if rising_edge(clk) then              -- Synchronous process
      if (rst = '1') then                 -- High-active reset
        sig_cnt <= 0;                     -- Clear local counter
        ce      <= '0';                   -- Set output to low

      -- Test number of clock periods
      elsif (sig_cnt >= (max - 1)) then
        sig_cnt <= 0;                     -- Clear local counter
        ce      <= '1';                   -- Generate clock enable pulse
      else
        sig_cnt <= sig_cnt + 1;
        ce      <= '0';
      end if;
    end if;

  end process p_clk_enable;

end architecture behavioral;
