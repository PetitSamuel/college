----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.03.2019 20:49:05
-- Design Name: 
-- Module Name: in_logic_bi_tb - Behavioral
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

entity in_logic_bi_tb is
--  Port ( );
end in_logic_bi_tb;

ARCHITECTURE Behavior OF in_logic_bi_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT in_logic_bi
	Port(
		val : in STD_LOGIC_VECTOR(15 downto 0);
		in_s : in STD_LOGIC_VECTOR(1 downto 0);
		y : out STD_LOGIC_VECTOR(15 downto 0)
	);
    END COMPONENT;
    

   --Inputs
   signal val : std_logic_vector(15 downto 0);
   signal in_s : std_logic_vector(1 downto 0);

 	--Outputs
   signal y : std_logic_vector(15 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: in_logic_bi PORT MAP (
          val => val,
          in_s => in_s,
          y => y
        );

   -- Stimulus process
   stim_proc: process
   begin		
		val <= "0000000011111111";
		in_s <= "00";
		wait for 15ns;
		in_s <= "01";		
		wait for 15ns;
		in_s <= "10";		
		wait for 15ns;
		in_s <= "11";
		wait for 10 ns;
		val <= "1111111100000000";
      wait;
   end process;

END;