----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.02.2019 12:20:36
-- Design Name: 
-- Module Name: decoder3_8 - Behavioral
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

entity decoder3_8 is
    port(    input :        in std_logic_vector(2 downto 0);  --3 bit input
            output : out std_logic_vector(7 downto 0)  -- 8 bit ouput
   );
end decoder3_8;

architecture Behavioral of decoder3_8 is

begin
output(0) <= (not input(2)) and (not input(1)) and (not input(0));
output(1) <= (not input(2)) and (not input(1)) and input(0);
output(2) <= (not input(2)) and input(1) and (not input(0));
output(3) <= (not input(2)) and input(1) and input(0);
output(4) <= input(2) and (not input(1)) and (not input(0));
output(5) <= input(2) and (not input(1)) and input(0);
output(6) <= input(2) and input(1) and (not input(0));
output(7) <= input(2) and input(1) and input(0);
end Behavioral;
