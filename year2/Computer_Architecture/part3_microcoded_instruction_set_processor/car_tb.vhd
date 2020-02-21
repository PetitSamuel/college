library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity car_tb is
--  Port ( );
end car_tb;

architecture Behavioral of car_tb is

component car
Port(
    s : in STD_LOGIC;
    c : in STD_LOGIC_VECTOR(7 downto 0);
    Clk : in STD_LOGIC;
    reset : in STD_LOGIC;
    output : out STD_LOGIC_VECTOR(7 downto 0)
);
end component;

signal s : std_logic;
signal c : std_logic_vector(7 downto 0) := (others => '0');
signal Clk : std_logic := '0';
signal reset : std_logic;

signal output : std_logic_vector(7 downto 0);

begin
uut: CAR PORT MAP(
    s => s,
    c => c,
    Clk => Clk,
    reset => reset,
    output=> output
);

   Clk <=  '1' after 10 ns when Clk = '0' else
           '0' after 10 ns when clk = '1';
           
stim_proc: process 
begin

c <= "00000001";
s <= '1';
reset <= '0';
wait for 30ns;

c <= "01000001";
s <= '0';
wait for 30ns;
s <= '1';
wait for 30ns;
s <= '0';

end process;
END;
