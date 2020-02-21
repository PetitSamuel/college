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

entity mux3_1 is
    Port ( s : in  STD_LOGIC_VECTOR (1 downto 0);
           in0 : in  std_logic;
           in1 : in  std_logic;
           in2 : in  std_logic;
           z : out  std_logic);
end mux3_1;

architecture Behavioral of mux3_1 is

begin

   process ( s,in0,in1,in2)
		begin
		case  s is
			when "00" => z <= in0;
			when "01" => z <= in1;
			when "10" => z <= in2;
			when others => z <= in0;
		end case;
	end process;
	
end Behavioral;

