----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.04.2019 16:37:41
-- Design Name: 
-- Module Name: pc_ext_tb - Behavioral
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

entity pc_ext_tb is
--  Port ( );
end pc_ext_tb;

architecture Behavioral of pc_ext_tb is
component pc_ext
Port(
    srsb : in STD_LOGIC_VECTOR(5 downto 0);
    output : out STD_LOGIC_VECTOR(15 downto 0)
);
end component;

signal srsb : std_logic_vector(5 downto 0);
signal output : std_logic_vector(15 downto 0);

begin
uut: pc_ext PORT MAP(
    srsb => srsb,
    output => output
);


stim_proc: process
begin

srsb <= "100000";
wait for 10ns;
srsb <= "000001";
wait for 10ns;
srsb <= "100000";
wait;
end process;
end Behavioral;
