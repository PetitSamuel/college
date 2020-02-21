--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY mux9_tb IS
END mux9_tb;
 
ARCHITECTURE behavior OF mux9_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT mux9
    PORT(
         s : IN  std_logic_vector(3 downto 0);
         in0 : IN  std_logic_vector(15 downto 0);     
         in1 : IN  std_logic_vector(15 downto 0);
         in2 : IN  std_logic_vector(15 downto 0);
         in3 : IN  std_logic_vector(15 downto 0);
         in4 : IN  std_logic_vector(15 downto 0);
         in5 : IN  std_logic_vector(15 downto 0);
         in6 : IN  std_logic_vector(15 downto 0);
         in7 : IN  std_logic_vector(15 downto 0);
         in8 : IN  std_logic_vector(15 downto 0);
         z : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal s : std_logic_vector(3 downto 0) := (others => '0');
   signal in0 : std_logic_vector(15 downto 0) := (others => '0');   
   signal in1 : std_logic_vector(15 downto 0) := (others => '0');
   signal in2 : std_logic_vector(15 downto 0) := (others => '0');
   signal in3 : std_logic_vector(15 downto 0) := (others => '0');
   signal in4 : std_logic_vector(15 downto 0) := (others => '0');
   signal in5 : std_logic_vector(15 downto 0) := (others => '0');
   signal in6 : std_logic_vector(15 downto 0) := (others => '0');
   signal in7 : std_logic_vector(15 downto 0) := (others => '0');
   signal in8 : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal z : std_logic_vector(15 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
--   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: mux9 PORT MAP (
          s => s,
          in0 => in0,          
          in1 => in1,
          in2 => in2,
          in3 => in3,
          in4 => in4,
          in5 => in5,
          in6 => in6,
          in7 => in7,
          in8 => in8,
          z => z
        );

   stim_proc: process
   begin		
        in0 <= "0000000000000000";
		in1 <= "0000000000000001";
		in2 <= "0000000000000010";
		in3 <= "0000000000000011";
		in4 <= "0000000000000100";
		in5 <= "0000000000000101";
		in6 <= "0000000000000110";
		in7 <= "0000000000000111";
		in8 <= "0000000000001000";
      wait for 10 ns;	
      s <= "0000";

      wait for 10 ns;	
		s <= "0001";

      wait for 10 ns;	
		s <= "0010";

      wait for 10 ns;	
		s <= "0011";
      wait for 10 ns;	
		s <= "0100";
      wait for 10 ns;	
		s <= "0101";
      wait for 10 ns;	
      s <= "0110";      
      wait for 10 ns;	
      s <= "0111";
      wait for 10 ns;	
      s <= "1000";
        wait;
 --     wait;
   end process;

END;