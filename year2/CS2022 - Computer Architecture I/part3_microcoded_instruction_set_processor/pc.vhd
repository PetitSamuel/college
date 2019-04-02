----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/26/2018 06:59:42 PM
-- Design Name: 
-- Module Name: PC - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pc is
Port( 
     input : in STD_LOGIC_VECTOR(15 downto 0);
     PI : in STD_LOGIC;
     PL : in STD_LOGIC;
     reset : in STD_LOGIC;
     Clk : in STD_LOGIC;
     output : out STD_LOGIC_VECTOR(15 downto 0)
);
end pc;


architecture Behavioral of pc is

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

signal resetpipl : std_logic;
signal result_add_current_with_input, incremented_pc, pc_next, previous_pc : std_logic_vector(15 downto 0);


begin 

add_to_current: ripple_adder PORT MAP(
    in0 => previous_pc,
    in1 => input,
    c_in => '0',
    s => result_add_current_with_input
);

incrmeent_by_1: ripple_adder PORT MAP(
    in0 => previous_pc,
    in1 => "0000000000000001",
    c_in => '0',
    s => incremented_pc
);

register00: register16 PORT MAP(
    D => pc_next,
    load => resetpipl,
    Clk => Clk,
    Q => previous_pc 
);

pc_next <= "0000000000000000" when reset = '1' else incremented_pc when PI = '1' else result_add_current_with_input when PL = '1' else "0000000000000000";
output <= previous_pc;
resetpipl <= reset or PI or PL;


end Behavioral;

