
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bd_rate_set is
    Port ( SW : in STD_LOGIC_VECTOR (2 downto 0);
           clk_out : out natural
           
           );
end bd_rate_set;

architecture Behavioral of bd_rate_set is

begin

p_bd_r_set : process (SW) is
  begin

    case SW is
                when "000" =>  --9600 BDs
                   -- clk_out <= 16; -- simulace
                   clk_out <= 10417;
                
                when "100" => -- 4800 BDs
                    --clk_out <= 5; -- simulace
                    clk_out <= 20834;
                
                when others => -- 2400 BDs
                    --clk_out <= 6; --simulace
                    clk_out <= 41668;
            end case;

  end process p_bd_r_set;

end Behavioral;
