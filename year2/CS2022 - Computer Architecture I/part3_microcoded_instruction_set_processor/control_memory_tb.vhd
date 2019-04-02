----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.04.2019 15:37:32
-- Design Name: 
-- Module Name: control_memory_tb - Behavioral
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

entity control_memory_tb is
--  Port ( );
end control_memory_tb;

architecture Behavioral of control_memory_tb is
component control_memory 
Port(
     CAR : in STD_LOGIC_VECTOR(7 downto 0);
     NA : out STD_LOGIC_VECTOR(7 downto 0);
     MS : out STD_LOGIC_VECTOR(2 downto 0);    
     MC : out STD_LOGIC;
     IL : out STD_LOGIC;
     PI : out STD_LOGIC;
     PL : out STD_LOGIC;
     TD : out STD_LOGIC;
     TA : out STD_LOGIC;
     TB : out STD_LOGIC;
     MB : out STD_LOGIC;
     FS : out STD_LOGIC_VECTOR(4 downto 0);
     MD : out STD_LOGIC;
     RW : out STD_LOGIC;
     MM : out STD_LOGIC;
     MW : out STD_LOGIC
);
end component; 

signal CAR : std_logic_vector(7 downto 0) := (others => '0');
signal NA : std_logic_vector(7 downto 0);
signal MS : std_logic_vector(2 downto 0);
signal MC : std_logic;
signal IL : std_logic;
signal PI : std_logic;
signal PL : std_logic;
signal TD : std_logic;
signal TA : std_logic;
signal TB : std_logic;
signal MB : std_logic;
signal FS : std_logic_vector(4 downto 0);
signal MD : std_logic;
signal RW : std_logic;
signal MM : std_logic;
signal MW : std_logic;

begin
uut: control_memory PORT MAP(
    CAR => CAR,
    NA => NA,
    MS => MS,
    MC => MC,
    IL => IL,
    PI => PI,
    PL => PL,
    TD => TD,
    TA => TA,
    TB => TB,
    MB => MB,
    FS => FS,
    MD => MD,
    RW => RW,
    MM => MM,
    MW => MW
);

stim_proc: process 
begin 

CAR <= "00000000";
wait for 100ns;
CAR <= "00110000";

end process;
end Behavioral;

