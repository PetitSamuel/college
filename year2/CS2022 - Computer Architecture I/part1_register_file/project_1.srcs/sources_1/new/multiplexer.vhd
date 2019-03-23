----------------------------------------------------------------------------------
-- Company: Trinity College
-- Engineer: Dr. Michael Manzke
-- 
-- Create Date:    11:42:30 02/23/2012 
-- Design Name: 
-- Module Name:    multiplexer - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity multiplexer is
    Port ( s : in  STD_LOGIC_VECTOR (2 downto 0);
           in1 : in  STD_LOGIC_VECTOR (15 downto 0);
           in2 : in  STD_LOGIC_VECTOR (15 downto 0);
           in3 : in  STD_LOGIC_VECTOR (15 downto 0);
           in4 : in  STD_LOGIC_VECTOR (15 downto 0);
           in5 : in  STD_LOGIC_VECTOR (15 downto 0);
           in6 : in  STD_LOGIC_VECTOR (15 downto 0);
           in7 : in  STD_LOGIC_VECTOR (15 downto 0);
           in8 : in  STD_LOGIC_VECTOR (15 downto 0);
           z : out  STD_LOGIC_VECTOR (15 downto 0));
end multiplexer;

architecture Behavioral of multiplexer is

begin

   process ( s,in1,in2,in3,in4)
		begin
		case  s is
			when "000" => z <= in1;
			when "001" => z <= in2;
			when "010" => z <= in3;
			when "011" => z <= in4;
			when "100" => z <= in5;
			when "101" => z <= in6;
			when "110" => z <= in7;
			when "111" => z <= in8;
			when others => z <= in1;
		end case;
	end process;
	
end Behavioral;

