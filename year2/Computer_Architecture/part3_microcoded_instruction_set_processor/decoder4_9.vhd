

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity decoder4_9 is
    port(     
        A0 : in std_logic;
        A1 : in std_logic;
        A2 : in std_logic;
        A3 : in std_logic;
        Q0 : out std_logic;
        Q1 : out std_logic;
        Q2 : out std_logic;
        Q3 : out std_logic;
        Q4 : out std_logic;
        Q5 : out std_logic;
        Q6 : out std_logic;
        Q7 : out std_logic;
        Q8 : out std_logic
        );
end decoder4_9;

architecture Behavioral of decoder4_9 is

begin
    Q0 <= (not A3) and (not A2) and (not A1) and (not A0);
    Q1 <= (not A3) and (not A2) and (not A1) and A0;
    Q2 <= (not A3) and (not A2) and A1 and (not A0);
    Q3 <= (not A3) and (not A2) and A1 and A0;
    Q4 <= (not A3) and A2 and (not A1) and (not A0);
    Q5 <= (not A3) and A2 and (not A1) and A0;
    Q6 <= (not A3) and A2 and A1 and (not A0);
    Q7 <= (not A3) and A2 and A1 and A0;
    Q7 <= (not A3) and A2 and A1 and A0;
    Q8 <= A3 and (not A2) and (not A1) and (not A0);
    
end Behavioral;
