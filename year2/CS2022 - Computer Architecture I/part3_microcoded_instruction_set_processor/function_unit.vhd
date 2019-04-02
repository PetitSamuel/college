---------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity function_unit is
  Port ( 
    in_a, in_b : in std_logic_vector(15 downto 0);
    f_select : in std_logic_vector(4 downto 0);
    v, c, n, z : out std_logic;
    f : out std_logic_vector(15 downto 0)
  );
end function_unit;

architecture Behavioral of function_unit is
    
    component arithmetic_logic_unit
    Port ( 
        in_a, in_b : in std_logic_vector(15 downto 0);
        in_g : in std_logic_vector(3 downto 0);
        v, c : out std_logic;
        out_g : out std_logic_vector(15 downto 0)
    );
    end component;
    
     component shifter 
  Port ( 
    b : in std_logic_vector(15 downto 0);
    s : in std_logic_vector(1 downto 0);
    il, ir : in std_logic;
    h : out std_logic_vector(15 downto 0)
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
    
    signal alu_out, shifter_out, final_signal : std_logic_vector(15 downto 0);
    
begin

    alu_0 : arithmetic_logic_unit Port map (
        in_a => in_a,
        in_b => in_b,
        in_g => f_select(3 downto 0),
        v => v,
        c => c,
        out_g => alu_out
    );
    
    shifter_0 : shifter Port map (
        b => in_b,
        s => f_select(3 downto 2),
        il => '0',
        ir => '0',
        h => shifter_out
    );

    multiplexer2_16_0 : multiplexer2_4 Port map (
        s => f_select(4),
        in0 => alu_out,
        in1 => shifter_out,
        z => final_signal
    );
    
    f <= final_signal;
    
    n <= final_signal(15);
    z <= (final_signal(15) or final_signal(14) or final_signal(13) or final_signal(12) or final_signal(11) 
            or final_signal(10) or final_signal(9) or final_signal(8) or final_signal(7) or final_signal(6) 
            or final_signal(5) or final_signal(4) or final_signal(3) or final_signal(2) or final_signal(1) or final_signal(0));

end Behavioral;
