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
 
ENTITY mux3_1_tb IS
END mux3_1_tb;
 
ARCHITECTURE behavior OF mux3_1_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT mux3_1
    PORT(
         s : IN  std_logic_vector(1 downto 0);
         in0 : IN  std_logic;     
         in1 : IN  std_logic;
         in2 : IN  std_logic;
         z : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal s : std_logic_vector(1 downto 0) := (others => '0');
   signal in0, in1, in2 : std_logic := '0';   
 	--Outputs
   signal z : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
--   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: mux3_1 PORT MAP (
          s => s,
          in0 => in0,          
          in1 => in1,
          in2 => in2,
          z => z
        );

   stim_proc: process
   begin		
        in0 <= '1';
		in1 <= '0';
		in2 <= '1';
      wait for 10 ns;	
        s <= "00";
      wait for 10 ns;	
		s <= "01";
      wait for 10 ns;
        in1 <= '1';	
		s <= "10";
      wait for 10 ns;
        s <= "10";	
        wait;
 --     wait;
   end process;

END;
