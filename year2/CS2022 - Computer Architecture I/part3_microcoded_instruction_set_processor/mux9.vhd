
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

entity mux9 is
    Port ( s : in  STD_LOGIC_VECTOR (3 downto 0);
           in0 : in  STD_LOGIC_VECTOR (15 downto 0);
           in1 : in  STD_LOGIC_VECTOR (15 downto 0);
           in2 : in  STD_LOGIC_VECTOR (15 downto 0);
           in3 : in  STD_LOGIC_VECTOR (15 downto 0);
           in4 : in  STD_LOGIC_VECTOR (15 downto 0);
           in5 : in  STD_LOGIC_VECTOR (15 downto 0);
           in6 : in  STD_LOGIC_VECTOR (15 downto 0);
           in7 : in  STD_LOGIC_VECTOR (15 downto 0);
           in8 : in  STD_LOGIC_VECTOR (15 downto 0);
           z : out  STD_LOGIC_VECTOR (15 downto 0));
end mux9;

architecture Behavioral of mux9 is

begin

   process ( s,in0,in1,in2,in3,in4,in5,in6,in7, in8)
		begin
		case  s is
			when "0000" => z <= in0;
			when "0001" => z <= in1;
			when "0010" => z <= in2;
			when "0011" => z <= in3;
			when "0100" => z <= in4;
			when "0101" => z <= in5;
			when "0110" => z <= in6;
			when "0111" => z <= in7;
			when "1000" => z <= in8;
			when others => z <= in0;
		end case;
	end process;
	
end Behavioral;