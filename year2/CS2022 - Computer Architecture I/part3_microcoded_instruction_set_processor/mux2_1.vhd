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

entity mux2_1 is
    Port ( s : in std_logic;
           in0 : in  STD_LOGIC;
           in1 : in  STD_LOGIC;
           z : out  STD_LOGIC);
end mux2_1;

architecture Behavioral of mux2_1 is

begin

   process ( s,in0,in1)
		begin
		case  s is
			when '0' => z <= in0;
			when '1' => z <= in1;
			when others => z <= in1;
		end case;
	end process;
	
end Behavioral;
