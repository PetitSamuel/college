----------------------------------------------------------------------------------
-- Company: TCD
-- Engineer: Samuel Petit
-- 
-- Create Date: 15.03.2019 19:20:16
-- Design Name: 
-- Module Name: full_adder - Behavioral
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

entity full_adder is
    Port(
        x, y, c_in : in std_logic;
        s, c : out std_logic
    );
end full_adder;

architecture Behavioral of full_adder is    
    component half_adder 
    port(
        a, b : in std_logic;
        val, c : out std_logic
    );
    end component;
    
    signal val_1, carry_1, carry_2: std_logic;

begin
    halfadder1: half_adder PORT MAP (
    a => x,
    b => y,
    val => val_1,
    c => carry_1
    );
    
    ha1: half_adder PORT MAP (
    a => c_in,
    b => val_1,
    val => s,
    c => carry_2
    );
        
    c <= carry_1 or carry_1;
end Behavioral;
