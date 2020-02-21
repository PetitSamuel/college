--------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY decoder4_9_tb IS
END decoder4_9_tb;
 
ARCHITECTURE behavior OF decoder4_9_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT decoder4_9
       port(     
            A0 : in std_logic;
            A1 : in std_logic;
            A2 : in std_logic;
            A3 : in std_logic;
            Q0 : out std_logic;
            Q1 : out std_logic;
            Q2 : out std_logic;
            Q3 : out std_logic;
            Q4 : out std_logic;
            Q5 : out std_logic;
            Q6 : out std_logic;
            Q7 : out std_logic;
            Q8 : out std_logic
            );
    END COMPONENT;
    
    signal A0,A1,A2,A3,Q0,Q1,Q2,Q3,Q4,Q5,Q6,Q7,Q8 : std_logic := '0';
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: decoder4_9 PORT MAP (
          A0 => A0,
          A1 => A1,
          A2 => A2,
          A3 => A3,
          Q0 => Q0,
          Q1 => Q1,
          Q2 => Q2,
          Q3 => Q3,
          Q4 => Q4,
          Q5 => Q5,
          Q6 => Q6,
          Q7 => Q7,
          Q8 => Q8
        );

   stim_proc: process
   begin
        A0 <= '0';		
        A1 <= '0';		
        A2 <= '0';		
        A3 <= '0';		
        wait for 2 ns;
        A0 <= '1';		
        A1 <= '0';		
        A2 <= '0';
        A3 <= '0';		
        wait for 2 ns;
        A0 <= '0';		
        A1 <= '1';		
        A2 <= '0';
        A3 <= '0';
        wait for 2 ns;
        A0 <= '1';		
        A1 <= '1';		
        A2 <= '0';
        A3 <= '0';
        wait for 2 ns;
        A0 <= '0';		
        A1 <= '0';		
        A2 <= '1';
        A3 <= '0';
        wait for 2 ns;
        A0 <= '1';		
        A1 <= '0';		
        A2 <= '1';
        A3 <= '0';
        wait for 2 ns;
        A0 <= '0';		
        A1 <= '1';		
        A2 <= '1';
        A3 <= '0';
        wait for 2 ns;
        A0 <= '1';		
        A1 <= '1';		
        A2 <= '1';
        A3 <= '0';
        wait for 2 ns;
        A0 <= '0';		
        A1 <= '0';		
        A2 <= '0';
        A3 <= '1';        
       wait;
   end process;

END;
