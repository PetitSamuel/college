----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.03.2019 21:20:06
-- Design Name: 
-- Module Name: arithmetic_logic_unit - Behavioral
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

entity arithmetic_logic_unit is
    Port ( 
        in_a, in_b : in std_logic_vector(15 downto 0);
        in_g : in std_logic_vector(3 downto 0);
        v, c : out std_logic;
        out_g : out std_logic_vector(15 downto 0)
    );
end arithmetic_logic_unit;

architecture Behaviour of arithmetic_logic_unit is
  
  component ripple_adder
    Port(
        in0: in std_logic_vector(15 downto 0);
        in1: in std_logic_vector(15 downto 0);
        c_in: in std_logic;
        s : out std_logic_vector(15 downto 0);
        c_out, val : out std_logic);
    end component;
  
  component in_logic_ab
    Port(
        in_a, in_b : in std_logic_vector(15 downto 0);
        in_s : in std_logic_vector(1 downto 0);
        out_ab : out std_logic_vector(15 downto 0)
    );     
  end component;
  
  component in_logic_bi is
	Port(
		val : in STD_LOGIC_VECTOR(15 downto 0);
		in_s : in STD_LOGIC_VECTOR(1 downto 0);
		y : out STD_LOGIC_VECTOR(15 downto 0)
	);
    end component;
    
    component multiplexer2_4
    Port (
           s : in  std_logic;
           in0 : in  std_logic_vector(15 downto 0);
           in1 : in  std_logic_vector (15 downto 0);
           z : out  std_logic_vector (15 downto 0)
    );
    end component;

    signal ab_logic_result,  b_logic_result, ripple_adder_result: std_logic_vector(15 downto 0);

begin

    logic_ab : in_logic_ab Port map (
         in_a => in_a,
         in_b => in_b,
         in_s => in_g(2 downto 1),
         out_ab => ab_logic_result
    );
    
    logic_bi_0 : in_logic_bi Port map (
        val => in_b,
		in_s => in_g(2 downto 1),
		y => b_logic_result
    );
    
     ripple_adder_0 : ripple_adder Port map (
        in0 => in_a,
        in1 => b_logic_result, 
        c_in => in_g(0),
        s => ripple_adder_result,
        c_out => c,
        val => v
    );
    
    mux_2_16 : multiplexer2_4 Port map (
         s => in_g(3),
         in0 => ripple_adder_result, 
         in1 => ab_logic_result,
         z => out_g
    );
  
end Behaviour;
