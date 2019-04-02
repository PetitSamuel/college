----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.03.2019 21:30:35
-- Design Name: 
-- Module Name: arithmetic_logic_unit_tb - Behavioral
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

entity arithmetic_logic_unit_tb is
--  Port ( );
end arithmetic_logic_unit_tb;

architecture behaviour OF arithmetic_logic_unit_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    component arithmetic_logic_unit
Port ( 
        in_a, in_b : in std_logic_vector(15 downto 0);
        in_g : in std_logic_vector(3 downto 0);
        v, c : out std_logic;
        out_g : out std_logic_vector(15 downto 0)
    );
    end component;
    
    --inputs
    signal in_a, in_b, out_g : std_logic_vector(15 downto 0);
    
    --outputs
    signal in_g : std_logic_vector(3 downto 0);
    signal v, c : std_logic;
 
begin
    uut: arithmetic_logic_unit port map (
          in_a => in_a,
          in_b => in_b, 
          in_g => in_g,
          v => v,
          c => c, 
          out_g => out_g
    );
   stim_proc: process
    begin

    in_a <= "1111000011110000";
    in_b <= "1000000000000001";
    in_g <= "0000";
    wait for 20ns;
    in_g <= "0001";
    wait for 20ns;
    in_g <= "0010";
    wait for 20ns;
    in_g <= "0011";
    wait for 20ns;
    in_g <= "0100";
    wait for 20ns;
    in_g <= "0101";
    wait for 20ns;
    in_g <= "0110";
    wait for 20ns;
    in_g <= "0111";
    wait for 20ns;
    in_g <= "1000";
    wait for 20ns;
    in_g <= "1001";
    wait for 20ns;
    in_g <= "1010";
    wait for 20ns;
    in_g <= "1011";
    wait for 20ns;
    in_g <= "1100";
    wait for 20ns;
    in_g <= "1101";
    wait for 20ns;
    in_g <= "1110";
    wait for 20ns;
    in_g <= "1111";
    wait;
   end process;   

end;
