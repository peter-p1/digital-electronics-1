library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity tx is
    Port ( clk      : in STD_LOGIC;
           rst      : in STD_LOGIC;
           vystup   : out STD_LOGIC;
           data0    : in STD_LOGIC;
           data1    : in STD_LOGIC;
           data2    : in STD_LOGIC;
           data3    : in STD_LOGIC;
           data4    : in STD_LOGIC;
           data5    : in STD_LOGIC;
           data6    : in STD_LOGIC;
           data7    : in STD_LOGIC;
           SW       : in STD_LOGIC_VECTOR(2 downto 0)
           
           );
end tx;

architecture behavioral of tx is
    
    -- Vnitrni signal pro vysilane slovo
    signal slovo    : STD_LOGIC_VECTOR(7 downto 0);
    -- Vnitrni clock enable
    signal sig_en_tx : std_logic;
    -- vnitrni 4-bit citac pro multiplexing 8 digits
    signal sig_cnt_4bit_tx : std_logic_vector(3 downto 0);     -- pro vysilac
    -- vnitrni propojeni nastaveni rychlosti
    signal clock_set : natural;      -- zakladni rychlost
    signal clock_setx16 : natural;   -- 16x rychlejsi
    -- Interní reset
    signal sig_rst_cnt : std_logic := '0';
   -- signal vysledek : std_logic_vector(7 downto 0);
    -- pocitadla pro jednotlive funkce
    signal pocitadlo : natural;  -- pocitadlo pro prijimac - vyber, kam zapsat prijaty bit
    signal pocitadlo2 : natural; -- pocitadlo pro prijimac - detekce start bitu
begin

clock_setx16 <= clock_set /16;

    
clk_en2 : entity work.clock_enable_tx
    port map (
      clk => clk,
      rst => rst,
      ce  => sig_en_tx,
      max => clock_set -- rychlost citace je rovna nastavenemu BD rate
    );

bd_rate_set : entity work.bd_rate_set
    port map(
        clk_out => clock_set, -- nacteni BD rate
        SW => SW
        );

bin_cnt_tx : entity work.tx_cnt_up
    generic map (
      g_CNT_WIDTH => 4
    )
    port map (
      clk => clk,
      rst => rst,
      en => sig_en_tx,
      cnt_up => '0',
      cnt => sig_cnt_4bit_tx
    );
    
    
  
tx : process (clk) is  -- vysilac
  begin
   if(rising_edge(clk)) then  
        
            
            report "sig_cerx_en nastaven na 1"; 
            slovo(0) <= data0; -- nacteni vstupu do pameti
            slovo(1) <= data1;
            slovo(2) <= data2;
            slovo(3) <= data3;
            slovo(4) <= data4;
            slovo(5) <= data5;
            slovo(6) <= data6;
            slovo(7) <= data7;
            
            case sig_cnt_4bit_tx is -- multiplexovani vystupu
                when "1111" =>  --f  -- pred stardbitem vzdy 1
                    vystup <= '1';
                
                when "1110" => -- e
                    vystup <= '0';   -- start bit

                when "1101" => -- d
                    vystup <= slovo(0);  -- vyslani LSB
          
                when "1100" => -- c
                    vystup <= slovo(1);
          
                when "1011" => -- b
                    vystup <= slovo(2);
          
                when "1010" => -- a
                    vystup <= slovo(3);

                when "1001" => -- 9
                    vystup <= slovo(4);
                
                when "1000" => -- 8
                    vystup <= slovo(5);
                
                when "0111" =>  -- 7
                    vystup <= slovo(6);
                
                when "0110" => -- 6
                    vystup <= slovo(7);  -- vyslani MSB
                    
                when "0101" => -- 5
                    vystup <= '1';       -- vyplnove bity zajistujici odstup jednotlivych vysilani
                
                when "0000" => -- 0
                    vystup <= '1';
                
                when others =>
                    vystup <= '1';

            end case;
        end if;
 end process tx;
 
 end architecture behavioral;