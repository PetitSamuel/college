--------------------------------------------------------------------------------
-- Company: Trinity College
-- Engineer: Dr. Michael Manzke
--
-- Create Date:   11:50:59 02/23/2012
-- Design Name:   
-- Module Name:   C:/Xilinx/12.4/ISE_DS/ISE/ISEexamples/MichaelsMultiplexer/multiplexer_tb.vhd
-- Project Name:  MichaelsMultiplexer
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: multiplexer
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 ENTITY in_logic_ab_tb IS
END in_logic_ab_tb;
 
ARCHITECTURE Behavior OF in_logic_ab_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT in_logic_ab
    Port(
        in_a, in_b : in std_logic_vector(15 downto 0);
        in_s : in std_logic_vector(1 downto 0);
        out_ab : out std_logic_vector(15 downto 0)
    );   
    END COMPONENT;
    

   --Inputs
   signal in_a, in_b : std_logic_vector(15 downto 0);
   signal in_s : std_logic_vector(1 downto 0);
   
   signal out_ab : std_logic_vector(15 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: in_logic_ab PORT MAP (
          in_a => in_a,
          in_b => in_b,
          in_s => in_s,
          out_ab => out_ab
        );

   -- Stimulus process
   stim_proc: process
   begin		
		in_a <= x"AAAA";
		in_b <= x"BBBB";
		in_s <= "00";
		
		wait for 10ns;
		in_s <= "01";
		
		wait for 5ns;
		in_s <= "10";
		
		wait for 5ns;
		in_s <= "11";

      wait;
   end process;

END;