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
 
ENTITY decoder3_8_tb IS
END decoder3_8_tb;
 
ARCHITECTURE behavior OF decoder3_8_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT decoder3_8
port(    input :        in std_logic_vector(2 downto 0);  --3 bit input
            output : out std_logic_vector(7 downto 0)  -- 8 bit ouput
   );
    END COMPONENT;
    
    signal input : std_logic_vector(2 downto 0) := (others => '0');
    signal output : std_logic_vector(7 downto 0) := (others => '0');
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: decoder3_8 PORT MAP (
          input => input,
          output => output
        );

   stim_proc: process
   begin		
        input<="000";  --input = 0.
        wait for 2 ns;
        input<="001";   --input = 1.
        wait for 2 ns;
        input<="010";   --input = 2.
        wait for 2 ns;
        input<="011";   --input = 3.
        wait for 2 ns;
        input<="100";   --input = 4.
        wait for 2 ns;
        input<="101";   --input = 5.
        wait for 2 ns;
        input<="110";   --input = 6.
        wait for 2 ns;
        input<="111";   --input = 7.
       wait;
   end process;

END;
