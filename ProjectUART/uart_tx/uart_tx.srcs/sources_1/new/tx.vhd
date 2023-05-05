library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity tx is
    Port ( clk      : in STD_LOGIC;
           rst      : in STD_LOGIC;
           output   : out STD_LOGIC;
           data0    : in STD_LOGIC;
           data1    : in STD_LOGIC;
           data2    : in STD_LOGIC;
           data3    : in STD_LOGIC;
           data4    : in STD_LOGIC;
           data5    : in STD_LOGIC;
           data6    : in STD_LOGIC;
           data7    : in STD_LOGIC;
           SW       : in STD_LOGIC
           
           );
end tx;

architecture behavioral of tx is
    
    signal message    : STD_LOGIC_VECTOR(7 downto 0);       -- Internal signal for sending a message
    signal sig_en_tx : std_logic;                           -- Internal clock enable
    signal sig_cnt_4bit_tx : std_logic_vector(3 downto 0);  -- pro vysilac
    signal clock_set : natural;                             -- Default speed
  --signal sig_rst_cnt : std_logic := '0';                  -- Detect the start bit of the received data.
begin


    
clk_en2 : entity work.clock_enable_tx
    port map (
      clk => clk,
      rst => rst,
      ce  => sig_en_tx,
      max => clock_set
    );

bd_rate_set : entity work.bd_rate_set
    port map(
        clk_out => clock_set, -- Load the BD rate
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
    
    
  
tx : process (clk) is  -- Transmitter process
  begin
   if(rising_edge(clk)) then  
        
            
            report "sig_cerx_en is set to 1"; -- Load the input into the memory
            message(0) <= data0; 
            message(1) <= data1;
            message(2) <= data2;
            message(3) <= data3;
            message(4) <= data4;
            message(5) <= data5;
            message(6) <= data6;
            message(7) <= data7;
            
            case sig_cnt_4bit_tx is
                when "1111" =>  --f
                    output <= '1';
                
                when "1110" => -- e
                    output <= '0';         -- Start bit

                when "1101" => -- d
                    output <= message(0);  -- Send LSB
          
                when "1100" => -- c
                    output <= message(1);
          
                when "1011" => -- b
                    output <= message(2);
          
                when "1010" => -- a
                    output <= message(3);

                when "1001" => -- 9
                    output <= message(4);
                
                when "1000" => -- 8
                    output <= message(5);
                
                when "0111" =>  -- 7
                    output <= message(6);
                
                when "0110" => -- 6
                    output <= message(7);  -- Send MSB
                    
                when "0101" => -- 5
                    output <= '1';         -- Buffer bits are used for easier debugging on a osciloscope
                
                when "0000" => -- 0
                    output <= '1';
                
                when others =>
                    output <= '1';

            end case;
        end if;
 end process tx;
 
 end architecture behavioral;
