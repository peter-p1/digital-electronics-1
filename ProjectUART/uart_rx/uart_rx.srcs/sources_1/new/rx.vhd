library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity rx is
    Port ( clk      : in STD_LOGIC;
           rst      : in STD_LOGIC;
           SW       : in STD_LOGIC;
           input    : in STD_LOGIC;
           result : out STD_LOGIC_VECTOR(7 downto 0)
           
           );
end rx;

architecture behavioral of rx is    
     
    signal sig_en_rx : std_logic;                              -- Internal clock enable
    signal sig_cnt_4bit_rx_x16 : std_logic_vector(3 downto 0); -- receiver
    signal clock_set : natural;                                -- Default speed
    signal clock_setx16 : natural;                             -- 16x default speed 
    signal sig_cerx_en : std_logic;                            -- High = receiver is activated, and the process starts detecting incoming bits ;Low = receiver is deactivated.
    signal sig_rst_cnt : std_logic := '0';                     -- Internal reset
    signal sig_rx_cnt : std_logic := '0';                      -- Detect the start bit of the received data.
    signal counter : natural;                                  -- Counter for the receiver
    signal counterStartBit : natural;                          -- Start bit detection
begin

clock_setx16 <= clock_set /16;

clk_en1 : entity work.clock_enable_rx
    port map (
      clk => clk,
      rst => rst,
      ce  => sig_en_rx,
      max => clock_setx16, -- Receiver speed is 16x faster than the BD rate
      cerx_en => sig_cerx_en
    );
    

bd_rate_set : entity work.bd_rate_set
    port map(
        clk_out => clock_set, 
        SW => SW -- Change the BD rate with a switch
        );

    
bin_cnt_rx_16x : entity work.rx_cnt_up
    generic map (
      g_CNT_WIDTH => 4
    )
    port map (
      clk => clk,
      rst => rst,
      en => sig_en_rx,
      cnt_up => '0',
      cnt => sig_cnt_4bit_rx_x16,
      int_rst => sig_rst_cnt,
      cnt_en => sig_cerx_en
    );    
    
  

 rx : process (clk, input) is  -- Receiver process
  begin
if(rising_edge(clk))then
        if(input = '0' and sig_rx_cnt = '0') then -- If the input is 0, we have not detected a start bit yet
            report "input 0";
            sig_cerx_en <= '1';  -- Activate the reader for the receiver
            sig_rx_cnt <= '1';   -- When we detect a start bit, save it 
        elsif(sig_rx_cnt = '1')then          -- Start bit detected   
             case sig_cnt_4bit_rx_x16 is
                when "1000" => 
                    if(counterStartBit = 0)then
                           counterStartBit <= 1;
                        if(counter = 0)then -- If the counter is at 0, it will start counting the received bits. If it's not at 0, the bits are recorded.
                            counter <= 1;  
                        end if;
                    if(counter > 0) then -- Once the start bit is detected (>0), the 4-bit counter signal (sig_cnt_4bit_rx_x16) starts counting
                        case counter is
                        when 1 =>
                            result(7) <= input;
                            counter <= 2;
                            report "result 0";
                
                        when 2 =>
                            result(6) <= input;
                            counter <= 3;
                            report "result 1";

                        when 3 => -- d
                            result(5) <= input;
                            counter <= 4;
                            report "result 2";
          
                        when 4 => -- c
                            result(4) <= input;
                            counter <= 5;
                            report "result 3";
          
                        when 5 => -- b
                            result(3) <= input;
                            counter <= 6;
                            report "result 4";
          
                        when 6 => -- a
                            result(2) <= input;
                            counter <= 7;
                            report "result 5";

                        when 7 => -- 9
                            result(1) <= input;
                            counter <= 8;
                            report "result 6";
                
                        when 8 => -- 8
                            result(0) <= input;
                            counter <= 9;
                            report "result 7";
                
                        when others =>
                            sig_rx_cnt <= '0';   -- Reset start bit detection
                            sig_cerx_en  <= '0'; -- Deactivate the reader for the receiver
                            counter <= 0;
                        report "reset";
                    end case;
                   end if;
                  end if;
                
                when "1001" => 
                    counterStartBit <= 0;
                
                when others =>
                    -- do nothing;    
                end case;
        end if;
   end if;
end process rx; 

end architecture behavioral;