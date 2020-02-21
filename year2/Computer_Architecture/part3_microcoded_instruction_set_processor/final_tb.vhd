----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.04.2019 20:15:13
-- Design Name: 
-- Module Name: final_tb - Behavioral
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

entity final_tb is
--  Port ( );
end final_tb;

architecture Behavioral of final_tb is
component full_project
Port(
     Clk : in STD_LOGIC;
     reset : in STD_LOGIC
);
end component;

signal Clk, reset : std_logic := '0';
constant Clk_period : time := 10ns;

begin
uut: full_project PORT MAP(
    Clk => Clk,
    reset => reset
);

Clk <=  '1' after Clk_period when Clk = '0' else
       '0' after Clk_period when clk = '1';

stim_proc: process
begin
reset <= '1';
wait for 50ns;
reset <= '0';
wait for 100ns;
reset <= '1';
wait;
end process;
end Behavioral;

