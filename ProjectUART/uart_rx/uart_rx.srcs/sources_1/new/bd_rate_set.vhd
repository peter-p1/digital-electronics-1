library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bd_rate_set is
    Port ( SW : in STD_LOGIC;
           clk_out : out natural
           );
end bd_rate_set;

architecture Behavioral of bd_rate_set is

begin

p_bd_r_set : process (SW) is
begin
    if (SW = '0') then    -- Switch is off, baud rate is 9600
        clk_out <= 10417; -- 100 000 000 / 9600 = 10417
    else                  -- Switch is on, baud rate is 19200
        clk_out <= 5208;  -- 100 000 000 / 19200 = 5208
    end if;
end process p_bd_r_set;

end Behavioral;
