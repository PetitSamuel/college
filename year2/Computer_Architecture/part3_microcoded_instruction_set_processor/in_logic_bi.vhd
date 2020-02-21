----------------------------------------------------------------------------------
-- Company: TCD
-- Engineer: Samuel Petit
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

entity in_logic_bi is
	Port(
		val : in STD_LOGIC_VECTOR(15 downto 0);
		in_s : in STD_LOGIC_VECTOR(1 downto 0);
		y : out STD_LOGIC_VECTOR(15 downto 0)
	);
end in_logic_bi;

architecture Behavioral of in_logic_bi is
	
	--mux 2-1 component
	Component mux2_1
    Port ( s : in std_logic;
           in0 : in  STD_LOGIC;
           in1 : in  STD_LOGIC;
           z : out  STD_LOGIC);
	End Component;

begin
	mux00: mux2_1 PORT MAP(
		s => val(0),
		in0 => in_s(0),
		in1 => in_s(1),
		z => y(0)
	);
	
	mux01: mux2_1 PORT MAP(
		s => val(1),
		in0 => in_s(0),
		in1 => in_s(1),
		z => y(1)
	);
	
	mux02: mux2_1 PORT MAP(
		s => val(2),
		in0 => in_s(0),
		in1 => in_s(1),
		z => y(2)
	);
	
	mux03: mux2_1 PORT MAP(
		s => val(3),
		in0 => in_s(0),
		in1 => in_s(1),
		z => y(3)
	);
	
	mux04: mux2_1 PORT MAP(
		s => val(4),
		in0 => in_s(0),
		in1 => in_s(1),
		z => y(4)
	);
	
	mux05: mux2_1 PORT MAP(
		s => val(5),
		in0 => in_s(0),
		in1 => in_s(1),
		z => y(5)
	);
	
	mux06: mux2_1 PORT MAP(
		s => val(6),
		in0 => in_s(0),
		in1 => in_s(1),
		z => y(6)
	);
	
	mux07: mux2_1 PORT MAP(
		s => val(7),
		in0 => in_s(0),
		in1 => in_s(1),
		z => y(7)
	);
	
	mux08: mux2_1 PORT MAP(
		s => val(8),
		in0 => in_s(0),
		in1 => in_s(1),
		z => y(8)
	);
	
	mux09: mux2_1 PORT MAP(
		s => val(9),
		in0 => in_s(0),
		in1 => in_s(1),
		z => y(9)
	);
	
	mux10: mux2_1 PORT MAP(
		s => val(10),
		in0 => in_s(0),
		in1 => in_s(1),
		z => y(10)
	);
	
	mux11: mux2_1 PORT MAP(
		s => val(11),
		in0 => in_s(0),
		in1 => in_s(1),
		z => y(11)
	);
	
	mux12: mux2_1 PORT MAP(
		s => val(12),
		in0 => in_s(0),
		in1 => in_s(1),
		z => y(12)
	);
	
	mux13: mux2_1 PORT MAP(
		s => val(13),
		in0 => in_s(0),
		in1 => in_s(1),
		z => y(13)
	);
	
	mux14: mux2_1 PORT MAP(
		s => val(14),
		in0 => in_s(0),
		in1 => in_s(1),
		z => y(14)
	);
	
	mux15: mux2_1 PORT MAP(
		s => val(15),
		in0 => in_s(0),
		in1 => in_s(1),
		z => y(15)
	);

end Behavioral;