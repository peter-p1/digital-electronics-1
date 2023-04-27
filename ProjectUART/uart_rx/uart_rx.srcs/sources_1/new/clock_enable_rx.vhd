
library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all; -- Package for arithmetic operations

----------------------------------------------------------
-- entita pro clock_enable prijimace
----------------------------------------------------------

entity clock_enable_rx is
  port (
    clk : in    std_logic; --! Main clock
    rst : in    std_logic; --! High-active synchronous reset
    ce  : out   std_logic;  --! Clock enable pulse signal
    max : in natural;
    cerx_en : in std_logic -- aktivacni signal
  );
end entity clock_enable_rx;

------------------------------------------------------------
-- Architecture body for clock enable
------------------------------------------------------------

architecture behavioral of clock_enable_rx is

  -- Local counter
  signal sig_cnt : natural;

begin

  --------------------------------------------------------
  -- p_clk_enable:
  -- Generate clock enable signal.
  --------------------------------------------------------
  p_clk_enable : process (clk) is
  begin
   if (cerx_en = '1') then                -- kontrola aktivace citace
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
   end if;

  end process p_clk_enable;

end architecture behavioral;
