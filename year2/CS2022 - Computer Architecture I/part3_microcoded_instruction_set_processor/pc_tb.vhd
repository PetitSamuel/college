library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pc_tb is
--  Port ( );
end pc_tb;

architecture Behavioral of pc_tb is
component pc
Port( 
     input : in STD_LOGIC_VECTOR(15 downto 0);
     PI : in STD_LOGIC;
     PL : in STD_LOGIC;
     reset : in STD_LOGIC;
     Clk : in STD_LOGIC;
     output : out STD_LOGIC_VECTOR(15 downto 0)
);
end component;

signal input : std_logic_vector(15 downto 0);
signal PI, PL, reset, Clk : std_logic := '0';

signal output : std_logic_vector(15 downto 0);

constant Clk_period :time := 10ns;

begin
    Clk <=  '1' after Clk_period when Clk = '0' else
           '0' after Clk_period when clk = '1';
           
uut: pc PORT MAP(
    input => input,
    PI => PI,
    PL => PL,
    reset => reset,
    Clk => Clk,
    output => output
);

Clk_process: process
begin

reset <= '0';
PI <= '0';
PL <= '0';
input <= "0000000000000100";
wait for 40ns;

reset <= '0';
input <= "0000000000000101";
PI <= '1';
PL <= '0';
wait for 40ns;


input <= "0000000000000101";
PI <= '0';
PL <= '1';
wait for 40ns;


input <= "0000000000000101";
PI <= '0';
Pl <= '0';
reset <= '1';
wait for 40ns;

end process;
end Behavioral;
