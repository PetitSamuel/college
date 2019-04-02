----------------------------------------------------------------------------------
-- Company: TCD
-- Engineer: Samuel Petit
-- 
-- Create Date: 15.03.2019 20:44:39
-- Design Name: 
-- Module Name: in_logic_ab - Behavioral
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


entity in_logic_ab is
    Port(
        in_a, in_b : in std_logic_vector(15 downto 0);
        in_s : in std_logic_vector(1 downto 0);
        out_ab : out std_logic_vector(15 downto 0)
    );  
end in_logic_ab;

architecture Behavioral of in_logic_ab is

begin
    
    process(in_s,in_a,in_b)
        begin
        -- following the table set in the assignment
        case in_s is
            when "00" => out_ab <= in_a AND in_b after 1 ns;
            when "01" => out_ab <= in_a OR in_b after 1 ns;
            when "10" => out_ab <= in_a XOR in_b after 1 ns;
            when "11" => out_ab <= not in_a after 1 ns;
            when others => out_ab <= not in_a after 1 ns;
        end case;
    end process;
end Behavioral;