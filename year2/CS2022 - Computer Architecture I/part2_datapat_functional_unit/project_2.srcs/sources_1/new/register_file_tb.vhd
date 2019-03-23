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
 
ENTITY register_file_tb IS
END register_file_tb;
 
ARCHITECTURE behavior OF register_file_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT register_file
    Port ( src_s0 : in std_logic;
    src_s1 : in std_logic;
    src_s2 : in std_logic;
    des_A0 : in std_logic;
    des_A1 : in std_logic;
    des_A2 : in std_logic;
    Clk : in std_logic;
    data_src : in std_logic;
    data : in std_logic_vector(15 downto 0);
    reg0 : out std_logic_vector(15 downto 0);
    reg1 : out std_logic_vector(15 downto 0);
    reg2 : out std_logic_vector(15 downto 0);
    reg3 : out std_logic_vector(15 downto 0);
    reg4 : out std_logic_vector(15 downto 0);
    reg5 : out std_logic_vector(15 downto 0);
    reg6 : out std_logic_vector(15 downto 0);
    reg7 : out std_logic_vector(15 downto 0));
    END COMPONENT;
    

   --Inputs
   signal src_s0, src_s1, src_s2, des_A0, des_A1, des_A2, Clk, data_src : std_logic := '0';
   signal data : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal reg0,reg1,reg2,reg3,reg4,reg5,reg6,reg7 : std_logic_vector(15 downto 0) := (others => '0');
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: register_file PORT MAP (
          src_s0 => src_s0,
          src_s1 => src_s1,
          src_s2 => src_s1,
          des_A0 => des_A0,
          des_A1 => des_A1,
          des_A2 => des_A2,
          Clk => Clk,
          data_src => data_src,
          data => data,
          reg0 => reg0,
          reg1 => reg1,
          reg2 => reg2,
          reg3 => reg3,
          reg4 => reg4,
          reg5 => reg5,
          reg6 => reg6,
          reg7 => reg7
        );
   Clk <=  '1' after 10 ns when Clk = '0' else
           '0' after 10 ns when clk = '1';
   stim_proc: process
   begin
      data_src <= '0';		
      data <= "1010101010101010";
      src_s0 <= '0';
      src_s1 <= '0';
      src_s2 <= '0';
      des_A0 <= '0';
      des_A1 <= '0';
      des_A2 <= '0';
      wait for 20 ns;	
      des_A0 <= '1';
      wait for 20 ns;
      des_A0 <= '0';
      des_A1 <= '1';	
      wait for 20 ns;
      des_A0 <= '1';
      des_A1 <= '1';  
      wait for 20 ns;
      des_A0 <= '0';
      des_A1 <= '0';	
      des_A2 <= '1';	
      wait for 20 ns;  
      des_A0 <= '1';
      des_A1 <= '0';	
      des_A2 <= '1';
      wait for 20 ns;
      des_A0 <= '0';
      des_A1 <= '1';	
      des_A2 <= '1';	
      wait for 20 ns; 
      data <= "1111111100000000";
      des_A0 <= '1';
      des_A1 <= '1';	
      des_A2 <= '1';
      wait for 50ns;
      data_src <= '1';
      src_s0 <= '1';		
      src_s1 <= '1';		
      src_s2 <= '1';
      des_A0 <= '0';
      des_A1 <= '0';	
      des_A2 <= '0';		
      wait;    	
   end process;

END;