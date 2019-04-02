library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity instruction is
Port(
     IR : in STD_LOGIC_VECTOR(15 downto 0);
     IL : in STD_LOGIC;
     Clk : in STD_LOGIC;
     OPCODE : out STD_LOGIC_VECTOR(7 downto 0);
     DR : out STD_LOGIC_VECTOR(2 downto 0);
     SA : out STD_LOGIC_VECTOR(2 downto 0);
     SB : out STD_LOGIC_VECTOR(2 downto 0)
);
end instruction;

architecture Behavioral of instruction is

component register16
    Port ( 
       D : in STD_LOGIC_VECTOR(15 downto 0);
       Clk : in STD_LOGIC;
       load : in STD_LOGIC;
       Q : out STD_LOGIC_VECTOR(15 downto 0)
       );
end component;

signal output : std_logic_vector(15 downto 0);

begin

register_0: register16 PORT MAP(
    D => IR,
    Clk => Clk,
    load => IL,
    Q => output
);

OPCODE <= output(15 downto 9) & '0';
DR <= output(8 downto 6); 
SA <= output(5 downto 3);
SB <= output(2 downto 0);


end Behavioral;