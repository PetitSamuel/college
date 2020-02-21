----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.03.2019 17:55:05
-- Design Name: 
-- Module Name: zero_fill_tb - Behavioral
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

entity zero_fill_tb is
--  Port ( );
end zero_fill_tb;

architecture Behavioral of zero_fill_tb is

component zero_fill
Port(
     sb : in STD_LOGIC_VECTOR(2 downto 0);
     output : out STD_LOGIC_VECTOR(15 downto 0)
);
end component; 

signal sb : std_logic_vector(2 downto 0);
signal output : std_logic_vector(15 downto 0);

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
    uut: zero_fill PORT MAP(
        sb => sb,
        output => output
    );


   stim_proc: process
   begin		
      sb <= "000";
      wait for 10 ns;	
      sb <= "100";
      wait for 10 ns;
      sb <= "010";
      wait for 10 ns;
      sb <= "110";
      wait for 10 ns;
      sb <= "101";
      wait for 10 ns;                 
        wait;
   end process;

END;