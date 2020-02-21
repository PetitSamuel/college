
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity memory_tb is
--  Port ( );
end memory_tb;

architecture Behavioral of memory_tb is
component memory
Port(
     address : in STD_LOGIC_VECTOR(15 downto 0);
     data_write : in STD_LOGIC_VECTOR(15 downto 0);
     mw : in STD_LOGIC;
     data_read : out STD_LOGIC_VECTOR(15 downto 0)
);
end component; 

signal address : std_logic_vector(15 downto 0);
signal data_read : std_logic_vector(15 downto 0);
signal data_write : std_logic_vector(15 downto 0);
signal mw : std_logic := '0';

begin
uut: memory PORT MAP(
    address => address,
    data_write => data_write,
    mw => mw,
    data_read => data_read
);

stim_proc: process 
    begin 
        mw <= '0';
        address <= "0000000000000001";
        wait for 10ns;
        address <= "0000000000001000";
        wait for 10ns;
        mw <= '1';
        address <= "0000000000000000";
        data_write <= "1000000000000000";
        wait for 10ns;
    
    end process;
end Behavioral;
