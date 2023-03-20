----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/20/2023 01:59:59 PM
-- Design Name: 
-- Module Name: cnt_up_down_12bit - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity cnt_up_down_12bit is
  generic (
    g_CNT_WIDTH : natural := 12 --! Default number of counter bits
  );
  port (
    clk    : in    std_logic; --! Main clock
    rst    : in    std_logic; --! Synchronous reset
    en     : in    std_logic; --! Enable input
    cnt_up : in    std_logic; --! Direction of the counter
    cnt    : out   std_logic_vector(g_CNT_WIDTH - 1 downto 0)
  );
end cnt_up_down_12bit;

architecture Behavioral of cnt_up_down_12bit is

begin


end Behavioral;
