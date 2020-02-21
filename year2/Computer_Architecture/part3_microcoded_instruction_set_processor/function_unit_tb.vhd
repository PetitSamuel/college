----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.03.2019 16:09:24
-- Design Name: 
-- Module Name: FunctionUnit_tb - Behavioral
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

entity FunctionUnit_tb is
--  Port ( );
end FunctionUnit_tb;

architecture Behavioral of FunctionUnit_tb is
    
    component function_unit is
        Port ( 
        in_a, in_b : in std_logic_vector(15 downto 0);
        f_select : in std_logic_vector(4 downto 0);
        v, c, n, z : out std_logic;
        f : out std_logic_vector(15 downto 0)
      );
    end component;
    
    signal in_a, in_b, f : std_logic_vector(15 downto 0);
    signal f_select : std_logic_vector(4 downto 0);
    signal v,c,n,z : std_logic;

begin

    uut: function_unit Port map (
          in_a => in_a,
          in_b => in_b,
          f_select => f_select,
          v => v,
          c => c,
          n => n,
          z => z,
          f => f
    );

   -- Stimulus process
   stim_proc: process
   begin		
        
        in_a <= "1111000011110000";
        in_b <= "0000000011111111";
        f_select <= "00000";
		wait for 15ns;
		f_select <= "00001";
		wait for 15ns;
		f_select <= "00010";
		wait for 15ns;
		f_select <= "00011";
		wait for 15ns;
		f_select <= "00100";
		wait for 15ns;
		f_select <= "00101";
		wait for 15ns;
		f_select <= "00110";
		wait for 15ns;
		f_select <= "00111";
		wait for 15ns;
		f_select <= "01000";
		wait for 15ns;
		f_select <= "01001";
		wait for 15ns;
		f_select <= "01010";
		wait for 15ns;
		f_select <= "01011";
		wait for 15ns;
		f_select <= "01100";
		wait for 15ns;
		f_select <= "01101";
		wait for 15ns;
		f_select <= "01110";
		wait for 15ns;
		f_select <= "01111";
		wait for 15ns;
		f_select <= "10000";
		wait for 15ns;
		f_select <= "10100";
		wait for 15ns;
		f_select <= "11000";
		wait for 15ns;
      wait;
   end process;


end Behavioral;
