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
 
ENTITY full_adder_tb IS
END full_adder_tb;
 
ARCHITECTURE behavior OF full_adder_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT full_adder
    Port(
        x, y, c_in : in std_logic;
        s, c : out std_logic
    );
    END COMPONENT;
    

   --Inputs
   signal x,y, c_in : std_logic := '0';
   
 	--Outputs
   signal s, c : std_logic := '0';
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: full_adder PORT MAP (
          x => x,
          y => y,          
          c_in => c_in,
          s => s,
          c => c);

   stim_proc: process
   begin	
   	
      x <= '0';
      y <= '0';
      c_in <= '0';
      wait for 10 ns;	
      x <= '1';
      y <= '0';
      c_in <= '0';
      wait for 10 ns;
      x <= '0';
      y <= '1';
      c_in <= '1';
      wait for 10 ns;
      x <= '1';
      y <= '1';
      c_in <= '1';
      wait for 10 ns;
      x <= '1';
      y <= '1';
      c_in <= '0';
      wait for 10 ns;                 
        wait;
   end process;

END;
