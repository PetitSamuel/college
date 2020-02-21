----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.03.2019 19:16:12
-- Design Name: 
-- Module Name: ripple_adder - Behavioral
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

entity ripple_adder is
    Port(
        in0: in std_logic_vector(15 downto 0);
        in1: in std_logic_vector(15 downto 0);
        c_in: in std_logic;
        s : out std_logic_vector(15 downto 0);
        c_out, val : out std_logic);
end ripple_adder;

architecture Behavioral of ripple_adder is
    component full_adder 
    Port(
        x, y, c_in : in std_logic;
        s, c : out std_logic
    );
    end component;

    signal c: std_logic_vector(15 downto 1);
    signal carry_out : std_logic;
    
begin 

    full_add_1: full_adder port map (
        x => in0(0),
        y => in1(0),
        c_in => c_in,
        s => s(0),
        c => c(1)
    );
    full_add_2: full_adder port map (
        x => in0(1),
        y => in1(1),
        c_in => c(1),
        s => s(1),
        c => c(2)
    );
    full_add_3: full_adder port map (
        x => in0(2),
        y => in1(2),
        c_in => c(2),
        s => s(2),
        c => c(3)
    );
    full_add_4: full_adder port map (
        x => in0(3),
        y => in1(3),
        c_in => c(3),
        s => s(3),
        c => c(4)
    );
    full_add_5: full_adder port map (
        x => in0(4),
        y => in1(4),
        c_in => c(4),
        s => s(4),
        c => c(5)
    );
   full_add_6: full_adder port map (
        x => in0(5),
        y => in1(5),
        c_in => c(5),
        s => s(5),
        c => c(6)
    );
   full_add_7: full_adder port map (
        x => in0(6),
        y => in1(6),
        c_in => c(6),
        s => s(6),
        c => c(7)
    );
    full_add_8: full_adder port map (
        x => in0(7),
        y => in1(7),
        c_in => c(7),
        s => s(7),
        c => c(8)
    );
    full_add_9: full_adder port map (
        x => in0(8),
        y => in1(8),
        c_in => c(8),
        s => s(8),
        c => c(9)
    );
 
     full_add_10: full_adder port map (
        x => in0(9),
        y => in1(9),
        c_in => c(9),
        s => s(9),
        c => c(10)
    );   
     full_add_11: full_adder port map (
        x => in0(10),
        y => in1(10),
        c_in => c(10),
        s => s(10),
        c => c(11)
    ); 
    full_add_12: full_adder port map (
        x => in0(11),
        y => in1(11),
        c_in => c(11),
        s => s(11),
        c => c(12)
    ); 
    full_add_13: full_adder port map (
        x => in0(12),
        y => in1(12),
        c_in => c(12),
        s => s(12),
        c => c(13)
    ); 

    full_add_14: full_adder port map (
        x => in0(13),
        y => in1(13),
        c_in => c(13),
        s => s(13),
        c => c(14)
    );   
    full_add_15: full_adder port map (
        x => in0(14),
        y => in1(14),
        c_in => c(14),
        s => s(14),
        c => c(15)
    );    
    full_add_16: full_adder port map (
        x => in0(15),
        y => in1(15),
        c_in => c(15),
        s => s(15),
        c => carry_out
    );
    val <= (c(15) xor carry_out);    
    c_out <= carry_out;
end Behavioral;