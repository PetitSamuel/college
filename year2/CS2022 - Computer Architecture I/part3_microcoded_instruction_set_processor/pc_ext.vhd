library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pc_ext is
Port(
    srsb : in STD_LOGIC_VECTOR(5 downto 0);
    output : out STD_LOGIC_VECTOR(15 downto 0)
);
end pc_ext;

architecture Behavioral of pc_ext is

begin
output(15 downto 6) <= "0000000000" when SRSB(5) = '0' else "1111111111";
output(5 downto 0) <= srsb;
end Behavioral;