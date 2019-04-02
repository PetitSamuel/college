library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
 
ENTITY register16_tb IS
END register16_tb;
 
ARCHITECTURE behavior OF register16_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT register16
    PORT(
        D : in std_logic_vector(15 downto 0);
        load, Clk : in std_logic;
        Q : out std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal D : std_logic_vector(15 downto 0)  := (others => '0');
   signal Clk : std_logic := '0';
   signal load : std_logic := '0'; 

 	--Outputs
   signal Q : std_logic_vector(15 downto 0) := (others => '0');
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
--   constant Clk_period : time := 10 ns;
 
BEGIN 
	-- Instantiate the Unit Under Test (UUT)
   uut: register16 PORT MAP (
          D => D,
          load => load,
          Clk => Clk,
          Q => Q
        );
   Clk <=  '1' after 10 ns when Clk = '0' else
           '0' after 10 ns when clk = '1';
  
   stim_proc: process
   begin
       D <= "1010101010101010";
       load <= '1';
       wait for 20 ns;	
       D <= "0000000011111111";
       load <= '0';       
       wait for 50ns;
       load <= '1';
       wait for 30 ns;
   end process;

END;