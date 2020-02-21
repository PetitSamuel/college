----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.04.2019 16:44:42
-- Design Name: 
-- Module Name: mux8_1 - Behavioral
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

entity mux8_1 is
    Port(
         MS : in STD_LOGIC_VECTOR(2 downto 0);
         ZERO : in STD_LOGIC;
         ONE : in STD_LOGIC;
         C : in STD_LOGIC; 
         V : in STD_LOGIC;
         Z : in STD_LOGIC;
         N : in STD_LOGIC;
         not_C : in STD_LOGIC;
         not_Z : in STD_LOGIC;
         CAR_S : out STD_LOGIC
    );
end mux8_1;

architecture Behavioral of mux8_1 is

begin
CAR_S <= ZERO after 1ns when MS = "000" else 
         ONE after 1ns when MS = "001" else
         C after 1 ns when MS = "010" else 
         V after 1 ns when MS = "011" else 
         Z after 1 ns when MS = "100" else 
         N after 1 ns when MS = "101" else 
         not_C after 1 ns when MS = "110" else 
         not_Z after 1 ns when MS = "111";

end Behavioral;
