----------------------------------------------------------------------------------
-- Company: Trinity College Dublin
-- Engineer: Samuel Petit
-- 
-- Create Date: 15.03.2019 19:24:10
-- Design Name: 
-- Module Name: half_adder - Behavioral
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

entity half_adder is
    Port(
        a,b : in std_logic;
        val, c : out std_logic);
end half_adder;

architecture Behavioral of half_adder is    
begin
    val <= a xor b;
    c <= a and b;
end Behavioral;