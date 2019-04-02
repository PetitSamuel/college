----------------------------------------------------------------------------------
-- Company: Trinity College Dublin
-- Engineer: Samuel Petit
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shifter is
  Port ( 
    b : in std_logic_vector(15 downto 0);
    s : in std_logic_vector(1 downto 0);
    il, ir : in std_logic;
    h : out std_logic_vector(15 downto 0)
  );
end shifter;

architecture Behavioral of shifter is 
    component mux3_1 is
      Port ( 
        in0, in1, in2 : in std_logic;
        s : in std_logic_vector(1 downto 0);
        z : out std_logic
      );
    end component;
begin

    multiplexer3_1_1: mux3_1 Port map (
		in0 => b(0),
		in1 => b(1),
		in2 => il,
		s => s,
		z => h(0)
    );
    
    multiplexer3_1_2: mux3_1 Port map (
		in0 => b(1),
		in1 => b(2),
		in2 => b(0),
        s => s,
		z => h(1)
    );
    
    multiplexer3_1_3: mux3_1 Port map (
		in0 => b(2),
		in1 => b(3),
		in2 => b(1),
		s => s,
		z => h(2)
    );
    
    multiplexer3_1_4: mux3_1 Port map (
		in0 => b(3),
		in1 => b(4),
		in2 => b(2),
		s => s,
		z => h(3)
    );
    
    multiplexer3_1_5: mux3_1 Port map (
		in0 => b(4),
		in1 => b(5),
		in2 => b(3),
		s => s,
		z => h(4)
    );
    
    multiplexer3_1_6: mux3_1 Port map (
		in0 => b(5),
		in1 => b(6),
		in2 => b(4),
		s => s,
		z => h(5)
    );
    
    multiplexer3_1_7: mux3_1 Port map (
		in0 => b(6),
		in1 => b(7),
		in2 => b(5),
		s => s,
		z => h(6)
    );
    
    multiplexer3_1_8: mux3_1 Port map (
		in0 => b(7),
		in1 => b(8),
		in2 => b(6),
		s => s,
		z => h(7)
    );
    
    multiplexer3_1_9: mux3_1 Port map (
		in0 => b(8),
		in1 => b(9),
		in2 => b(7),
		s => s,
		z => h(8)
    );
    
    multiplexer3_1_10: mux3_1 Port map (
		in0 => b(9),
		in1 => b(10),
		in2 => b(8),
		s => s,
		z => h(9)
    );
    
    multiplexer3_1_11: mux3_1 Port map (
		in0 => b(10),
		in1 => b(11),
		in2 => b(9),
		s => s,
		z => h(10)
    );
    
    multiplexer3_1_12: mux3_1 Port map (
		in0 => b(11),
		in1 => b(12),
		in2 => b(10),
		s => s,
		z => h(11)
    );
    
    multiplexer3_1_13: mux3_1 Port map (
		in0 => b(12),
		in1 => b(13),
		in2 => b(11),
		s => s,
		z => h(12)
    );
    
    multiplexer3_1_14: mux3_1 Port map (
		in0 => b(13),
		in1 => b(14),
		in2 => b(12),
		s => s,
		z => h(13)
    );
    
    multiplexer3_1_15: mux3_1 Port map (
		in0 => b(14),
		in1 => b(15),
		in2 => b(13),
		s => s,
		z => h(14)
    );
    
    multiplexer3_1_16: mux3_1 Port map (
		in0 => b(15),
		in1 => ir,
		in2 => b(14),
		s => s,
		z => h(15)
    );
end Behavioral;
