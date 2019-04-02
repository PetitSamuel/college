----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.04.2019 16:32:37
-- Design Name: 
-- Module Name: mux2_8 - Behavioral
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

entity mux2_8 is
    Port(
         MC : in STD_LOGIC;
         NA : in STD_LOGIC_VECTOR(7 downto 0);
         OPCODE : in STD_LOGIC_VECTOR(7 downto 0);
         CAR : out STD_LOGIC_VECTOR(7 downto 0)
    );
end mux2_8;

architecture Behavioral of mux2_8 is

begin

CAR <= NA when MC = '0' else 
       OPCODE when MC = '1' else 
       "00000000";

end Behavioral;
