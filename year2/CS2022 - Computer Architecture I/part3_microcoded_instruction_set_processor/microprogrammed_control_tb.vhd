library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity microprogrammed_control_tb is
--  Port ( );
end microprogrammed_control_tb;

architecture Behavioral of microprogrammed_control_tb is
component microprogrammed_control
Port(
     Clk : in STD_LOGIC;
     reset : in STD_LOGIC;
     instr : in STD_LOGIC_VECTOR(15 downto 0);
     N : in STD_LOGIC; -- status 0
     Z : in STD_LOGIC; -- status 1
     C : in STD_LOGIC; -- status 2
     V : in STD_LOGIC; -- status 3
     next_programcounter : out STD_LOGIC_VECTOR(15 downto 0);
     DR : out STD_LOGIC_VECTOR(2 downto 0);
     SA : out STD_LOGIC_VECTOR(2 downto 0);
     SB : out STD_LOGIC_VECTOR(2 downto 0);
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

signal instr : std_logic_vector(15 downto 0) := (others => '0');
signal N, Z, C, V : std_logic := '0';
signal reset, Clk : std_logic := '0';


signal next_programcounter : std_logic_vector(15 downto 0);
signal TD, TA, TB, MB, MD, RW, MM, MW : std_logic; 
signal DR, SA, SB : std_logic_vector(2 downto 0);
signal FS : std_logic_vector(4 downto 0);

begin
   Clk <=  '1' after 10 ns when Clk = '0' else
           '0' after 10 ns when clk = '1';
  
uut: microprogrammed_control PORT MAP(
    Clk => Clk,
    reset => reset,
    instr => instr,
    N => N,
    Z => Z,
    C => C,
    V => V,
    next_programcounter => next_programcounter,
    DR => DR,
    SA => SA, 
    SB => SB,
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
    n <= '0';
    z <= '0';
    v <= '0';
    c <= '0';
    reset <= '1';
    wait for 20ns;
    reset <= '0';
    instr <= "0000000000000000";
    wait for 20ns;
    v <= '1';
    reset <= '0';
    instr <= "1101001000110111";
end process;
end Behavioral;