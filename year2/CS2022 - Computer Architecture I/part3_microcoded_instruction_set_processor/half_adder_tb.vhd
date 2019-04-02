----------------------------------------------------------------------------------
-- Company: TCD
-- Engineer: Samuel Petit
-- 
-- Create Date: 15.03.2019 19:25:41
-- Design Name: 
-- Module Name: half_adder_tb - Behavioral
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

entity half_adder_tb is
end half_adder_tb;

architecture Behavioral of half_adder_tb is 
    COMPONENT half_adder
    Port(
        a,b : in std_logic;
        val, c : out std_logic);
    END COMPONENT;
 --Inputs
   signal a, b : std_logic := '0';
 	--Outputs
   signal val, c : std_logic := '0';
   
BEGIN
-- Instantiate the Unit Under Test (UUT)
   uut: half_adder PORT MAP (
          a => a,
          b => b,          
          val => val,
          c => c
   );

   stim_proc: process
   begin		
        a <= '0';
        b <= '0';
      wait for 10 ns;	
        a <= '1';
        b <= '0';
      wait for 10 ns;
        a <= '1';
        b <= '1';
      wait for 10 ns;
        a <= '0';
        b <= '1';
      wait for 10 ns;     
        wait;
   end process;

END;