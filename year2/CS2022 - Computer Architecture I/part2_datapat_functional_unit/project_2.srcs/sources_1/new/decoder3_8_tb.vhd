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
       port(     
            A0 : in std_logic;
            A1 : in std_logic;
            A2 : in std_logic;
            Q0 : out std_logic;
            Q1 : out std_logic;
            Q2 : out std_logic;
            Q3 : out std_logic;
            Q4 : out std_logic;
            Q5 : out std_logic;
            Q6 : out std_logic;
            Q7 : out std_logic
            );
    END COMPONENT;
    
    signal input : std_logic_vector(2 downto 0) := (others => '0');
    signal output : std_logic_vector(7 downto 0) := (others => '0');
    signal A0,A1,A2,Q0,Q1,Q2,Q3,Q4,Q5,Q6,Q7 : std_logic := '0';
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: decoder3_8 PORT MAP (
          A0 => A0,
          A1 => A1,
          A2 => A2,
          Q0 => Q0,
          Q1 => Q1,
          Q2 => Q2,
          Q3 => Q3,
          Q4 => Q4,
          Q5 => Q5,
          Q6 => Q6,
          Q7 => Q7
        );

   stim_proc: process
   begin
        A0 <= '0';		
        A1 <= '0';		
        A2 <= '0';		
        wait for 2 ns;
        A0 <= '0';		
        A1 <= '0';		
        A2 <= '1';
        wait for 2 ns;
        A0 <= '0';		
        A1 <= '1';		
        A2 <= '0';
        wait for 2 ns;
        A0 <= '0';		
        A1 <= '1';		
        A2 <= '1';
        wait for 2 ns;
        A0 <= '1';		
        A1 <= '0';		
        A2 <= '0';
        wait for 2 ns;
        A0 <= '1';		
        A1 <= '0';		
        A2 <= '1';
        wait for 2 ns;
        A0 <= '1';		
        A1 <= '1';		
        A2 <= '0';
        wait for 2 ns;
        A0 <= '1';		
        A1 <= '1';		
        A2 <= '1';
       wait;
   end process;

END;
