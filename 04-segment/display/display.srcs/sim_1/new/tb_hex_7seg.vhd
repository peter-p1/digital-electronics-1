
library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all; -- Definition of "to_unsigned"

entity tb_hex_7seg is
-- Entity of testbench is always empty
end entity tb_hex_7seg;


architecture testbench of tb_hex_7seg is

  -- Testbench local signals
  signal sig_blank : std_logic;
  signal sig_hex   : std_logic_vector(3 downto 0);
  signal sig_seg   : std_logic_vector(6 downto 0);

begin


  uut_hex_7seg : entity work.hex_7seg
    port map (
      blank => sig_blank,
      hex   => sig_hex,
      seg   => sig_seg
    );


  p_stimulus : process is
  begin

    report "Stimulus process started";

    sig_blank <= '0';    -- Normal operation
    sig_hex   <= "0011"; -- Some default value
    wait for 50 ns;

    sig_blank <= '1';    -- Blank display
    wait for 150 ns;
    sig_blank <= '0';    -- Normal operation
    wait for 15 ns;

    -- Loop for all hex values
    for ii in 0 to 15 loop

      -- Convert ii decimal value to 4-bit wide binary
      -- s_hex <= std_logic_vector(to_unsigned(ii, s_hex'length));
      sig_hex <= std_logic_vector(to_unsigned(ii, 4));
      wait for 50 ns;

    end loop;

    report "Stimulus process finished";
    wait;

  end process p_stimulus;

end architecture testbench;
