

--------------------------------------------------------------------------------
-- Company: Trinity College
-- Engineer: Samuel Petit
--
-- Create Date:   11:50:59 02/23/2012
-- Design Name:   
-- Module Name:   register_file_tb
-- Project Name:  Register file
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: register_file
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
entity register_file_tb IS
end register_file_tb;
 
architecture behaviour OF register_file_tb IS 
    -- Component Declaration for the Unit Under Test (UUT)
 
    component register_file
    Port ( Clk, load_en : in std_logic;
        address_a, address_b, dest : in std_logic_vector(3 downto 0);
        data : in std_logic_vector(15 downto 0);
        out_a, out_b : out std_logic_vector(15 downto 0) 
    );
    end component;
    
   --Inputs
   signal Clk, load_en : std_logic := '0';
   signal address_a, address_b, dest : std_logic_vector(3 downto 0);
        
   signal data : std_logic_vector(15 downto 0);
 	--Outputs
   signal out_a, out_b : std_logic_vector(15 downto 0);
   
   constant Clk_period : time := 10 ns;

BEGIN
    Clk <=  '1' after Clk_period when Clk = '0' else
           '0' after Clk_period when clk = '1';
           
	-- Instantiate the Unit Under Test (UUT)
   uut: register_file PORT MAP (
          Clk => Clk,
          load_en => load_en,
          address_a => address_a,
          address_b => address_b,
          dest => dest,
          data => data,
          out_a => out_a,
          out_b => out_b
        );
           
   stim_proc: process
   begin
     dest <= "0000";
     data <= "1111111111111111";
     load_en <= '1';
     wait for 30 ns;
     dest <= "0001";
     data <= "1111111100001111"; 
     wait for 30 ns;
     dest <= "0010";
     data <= "0000000000000000";   
     wait for 30 ns;
     dest <= "0011";
     data <= "0101010101010101";
     wait for 30 ns;
     dest <= "0100";
     data <= "1100110011001100";  
     wait for 30 ns;
     dest <= "0101";
     data <= "1111100000111110";    
     wait for 30 ns;
     dest <= "0110";
     data <= "1100110011001100";     
     wait for 30 ns;
     dest <= "0111";
     data <= "0000000000000001";    
     wait for 30 ns;
    dest <= "1000";
     data <= "1000000000000001";    
     wait for 30 ns;
     address_a <= "0000";
     address_b <= "0001";  
     wait for 20 ns;
     address_a <= "0010";
     address_b <= "0011";   
     wait for 10 ns;
     address_a <= "0100";
     address_b <= "0101";
     wait for 10 ns;
     address_a <= "0110";
     address_b <= "0111";
     wait for 10 ns;
     address_a <= "1000";
     address_b <= "0111";
     wait;
     
    --     wait;
   end process;   
END;