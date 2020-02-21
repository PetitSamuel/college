library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity car is
    Port(
         s : in STD_LOGIC;
         c : in STD_LOGIC_VECTOR(7 downto 0);
         Clk : in STD_LOGIC;
         reset : in STD_LOGIC;
         output : out STD_LOGIC_VECTOR(7 downto 0)
    );    
end car;

architecture Behavioral of car is
component register16 
    Port ( 
       D : in STD_LOGIC_VECTOR(15 downto 0);
       Clk : in STD_LOGIC;
       load : in STD_LOGIC;
       Q : out STD_LOGIC_VECTOR(15 downto 0)
       );

end component;

component ripple_adder
    Port(
     in0 : in STD_LOGIC_VECTOR(15 downto 0);
     in1 : in STD_LOGIC_VECTOR(15 downto 0);
     c_in : in STD_LOGIC;
     c_out : out STD_LOGIC;
     val : out STD_LOGIC;
     s : out STD_LOGIC_VECTOR(15 downto 0)
);
end component;

signal inc : std_logic_vector(15 downto 0);
signal in_val, register_data : std_logic_vector(15 downto 0);

begin

reg00: register16 PORT MAP(
    D => register_data,
    load => '1',
    Clk => Clk,
    Q => in_val
);

add: ripple_adder PORT MAP(
    in0(7 downto 0) => in_val(7 downto 0),
    in0(15 downto 8) => "00000000",
    in1 => "0000000000000001",
    c_in => '0',
    s => inc
);

register_data(7 downto 0) <= c when s = '1' else inc(7 downto 0);
register_data(15 downto 8) <= "00000000";
output <= in_val(7 downto 0);

end Behavioral;
