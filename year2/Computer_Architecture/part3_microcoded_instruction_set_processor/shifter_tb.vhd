----------------------------------------------------------------------------------
-- Company: TCD
-- Engineer: Samuel Petit
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

entity shifter_tb is

end shifter_tb;

architecture Behavioral of shifter_tb is

    component shifter 
      Port ( 
        b : in std_logic_vector(15 downto 0);
        s : in std_logic_vector(1 downto 0);
        il, ir : in std_logic;
        h : out std_logic_vector(15 downto 0)
      );
    end component;

    signal b, h : std_logic_vector(15 downto 0);
    signal s : std_logic_vector(1 downto 0);
    signal il, ir : std_logic := '0';
    
begin
     uut: shifter port map (
          b => b,
          s => s,
          IL => IL,
          IR => IR,
          h => h);

   stim_proc: process
   begin
   il <= '0';
   ir <= '0'; 
   b <= "1111000000001111";
   s <= "00";
   wait for 20 ns;
   s <= "01";
   wait for 20 ns;
   s <= "10";
   wait for 20 ns;
   s <= "00";
   end process;
end Behavioral;
