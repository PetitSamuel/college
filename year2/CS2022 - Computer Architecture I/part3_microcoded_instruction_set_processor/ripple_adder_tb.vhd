----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.03.2019 19:16:30
-- Design Name: 
-- Module Name: ripple_adder_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ripple_adder_tb is
--  Port ( );
end ripple_adder_tb;

architecture Behavioral of ripple_adder_tb is
    -- Component Declaration for the Unit Under Test (UUT)
 
    component ripple_adder
    Port(
        in0: in std_logic_vector(15 downto 0);
        in1: in std_logic_vector(15 downto 0);
        c_in: in std_logic;
        s : out std_logic_vector(15 downto 0);
        c_out, val : out std_logic);
    end component;

 
    signal in0, in1, s: std_logic_vector(15 downto 0);
    signal c_in, c_out, val: std_logic;
 
begin

    uut: ripple_adder port map (
          in0 => in0,
          in1 => in1,
          c_in => c_in,
          s => s,
          c_out => c_out,
          val => val
        );

   stim_proc: process

   begin
       
     in0 <= "0000000000000000";
     in1 <= "0000000000000000";
     c_in <= '0';
     wait for 10 ns;
     in0 <= "1111111111111111";
     wait for 10 ns;    
     in1 <= "1000000000000000";
     wait for 10 ns;
     in0 <= "1000000000000000";           
     wait for 10 ns;
     c_in <= '1';  
     wait for 10 ns;
    
    --     wait;
   end process;   

end;