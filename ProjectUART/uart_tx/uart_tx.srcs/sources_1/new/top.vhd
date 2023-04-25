library ieee;
use ieee.std_logic_1164.all;

----------------------------------------------------------
-- Entity declaration for top level
----------------------------------------------------------

entity top is
  port (
    CLK100MHZ : in    std_logic;  -- Main clock
    SW        : in    std_logic_vector(7 downto 0);  -- data values
    JA        : out   std_logic;  -- UART TX output
    BTNC      : in    std_logic;  -- Synchronous reset
    LED       : out   std_logic_vector(7 downto 0)  -- LED output
  );
end entity top;

----------------------------------------------------------
-- Architecture body for top level
----------------------------------------------------------

architecture behavioral of top is

  signal tx_data : std_logic_vector(7 downto 0);

begin

  --------------------------------------------------------
  -- Instance (copy) of uart_tx entity
  --------------------------------------------------------
  uart_tx_inst : entity work.uart_tx
    port map (
      clk      => CLK100MHZ,
      reset    => BTNC,
      data     => tx_data,
      tx       => JA
    );

  -- Transmit SW data over UART
  tx_data <= SW;

  -- Update LED outputs based on SW input
  LED(0) <= SW(0);
  LED(1) <= SW(1);
  LED(2) <= SW(2);
  LED(3) <= SW(3);
  LED(4) <= SW(4);
  LED(5) <= SW(5);
  LED(6) <= SW(6);
  LED(7) <= SW(7);

end architecture behavioral;
