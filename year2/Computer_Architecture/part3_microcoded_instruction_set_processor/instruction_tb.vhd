----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/29/2018 02:01:34 PM
-- Design Name: 
-- Module Name: instruction_tb - Behavioral
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

entity instruction_tb is
--  Port ( );
end instruction_tb;

architecture Behavioral of instruction_tb is
component instruction 
Port(
     IR : in STD_LOGIC_VECTOR(15 downto 0);
     IL : in STD_LOGIC;
     Clk : in STD_LOGIC;
     OPCODE : out STD_LOGIC_VECTOR(7 downto 0);
     DR : out STD_LOGIC_VECTOR(2 downto 0);
     SA : out STD_LOGIC_VECTOR(2 downto 0);
     SB : out STD_LOGIC_VECTOR(2 downto 0)
);
end component; 

signal IR : std_logic_vector(15 downto 0) := (others => '0');
signal IL : std_logic := '0';
signal Clk : std_logic := '0';

signal OPCODE : std_logic_vector(7 downto 0);
signal DR, SA, SB : std_logic_vector(2 downto 0);

constant Clk_period : time := 10ns;

begin
uut: instruction PORT MAP(
    IR => IR,
    IL => IL,
    Clk => Clk,
    OPCODE => OPCODE,
    DR => DR,
    SA => SA,
    SB => SB
);

   Clk <=  '1' after 10 ns when Clk = '0' else
           '0' after 10 ns when clk = '1';

stim_proc: process 
begin

IR <= "1000000111111001";
IL <= '1';
wait for Clk_period;

IR <= "1100110011001100";
IL <= '0';
wait for Clk_period;
IR <= "1000000111111001";
IL <= '1';

end process;

end Behavioral;
