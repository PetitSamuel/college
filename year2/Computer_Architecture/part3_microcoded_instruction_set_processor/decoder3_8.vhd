----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.02.2019 12:20:36
-- Design Name: 
-- Module Name: decoder3_8 - Behavioral
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

entity decoder3_8 is
    port(     
        A0 : in std_logic;
        A1 : in std_logic;
        A2 : in std_logic;
        Q0 : out std_logic;
        Q1 : out std_logic;
        Q2 : out std_logic;
        Q3 : out std_logic;
        Q4 : out std_logic;
        Q5 : out std_logic;
        Q6 : out std_logic;
        Q7 : out std_logic
        );
end decoder3_8;

architecture Behavioral of decoder3_8 is

begin
    Q0 <= (not A2) and (not A1) and (not A0);
    Q1 <= (not A2) and (not A1) and A0;
    Q2 <= (not A2) and A1 and (not A0);
    Q3 <= (not A2) and A1 and A0;
    Q4 <= A2 and (not A1) and (not A0);
    Q5 <= A2 and (not A1) and A0;
    Q6 <= A2 and A1 and (not A0);
    Q7 <= A2 and A1 and A0;
end Behavioral;
