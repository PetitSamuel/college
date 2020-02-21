library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Datapath is
    Port(
         data : in STD_LOGIC_VECTOR(15 downto 0);
         PC: in STD_LOGIC_VECTOR(15 downto 0);
         control_word : in STD_LOGIC_VECTOR(17 downto 0);
         Clk : in STD_LOGIC;
         DR : in STD_LOGIC_VECTOR(2 downto 0);
         SA : in STD_LOGIC_VECTOR(2 downto 0);
         SB : in STD_LOGIC_VECTOR(2 downto 0);
         TD : in STD_LOGIC;
         TA : in STD_LOGIC;
         TB : in STD_LOGIC;
         output_data : out STD_LOGIC_VECTOR(15 downto 0);
         output_address : out STD_LOGIC_VECTOR(15 downto 0);
         status: out STD_LOGIC_VECTOR(3 downto 0);
         N : out STD_LOGIC;
         C : out STD_LOGIC;
         V : out STD_LOGIC;
         Z : out STD_LOGIC
    );
end Datapath;

architecture Behavioral of Datapath is
    
component function_unit is
  Port ( 
    in_a, in_b : in std_logic_vector(15 downto 0);
    f_select : in std_logic_vector(4 downto 0);
    v, c, n, z : out std_logic;
    f : out std_logic_vector(15 downto 0)
  );
    end component;
    
    component register_file  
        Port ( Clk, load_en : in std_logic;
        address_a, address_b, dest : in std_logic_vector(3 downto 0);
        data : in std_logic_vector(15 downto 0);
        out_a, out_b : out std_logic_vector(15 downto 0)
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
    component zero_fill
    Port(
        sb : in STD_LOGIC_VECTOR(2 downto 0);
        output : out STD_LOGIC_VECTOR(15 downto 0)
    );
    end component;
    
signal MUXB, MUXD, MUXM, register_1, register_2, f_unit, zero_fill1, pc_tmp : STD_LOGIC_VECTOR(15 downto 0);
signal SIGD, addr_a, addr_b, sig_status : std_logic_vector(3 downto 0);

begin

SIGD <= TD & control_word(17 downto 15);
addr_a <= TA & control_word(14 downto 12);
addr_b <= TB & control_word(11 downto 9); 

zero_filler: zero_fill PORT MAP(
    sb => control_word(11 downto 9),
    output => zero_fill1
);

reg_file: register_file PORT MAP(
    dest(3) => TD,
    dest(2 downto 0) => control_word(17 downto 15),
    address_a(3) => TA,
    address_a(2 downto 0) => control_word(14 downto 12),
    address_b(3) => TB,
    address_b(2 downto 0) => control_word(11 downto 9),
    Clk => Clk, 
    load_en => control_word(1),
    data => MUXD,
    out_a => register_1,
    out_b => register_2
);

multiplexer_a: multiplexer2_4 PORT MAP(
    s => control_word(8),
    In0 => register_2,
    In1 => zero_fill1,
    z => MUXB
);
multiplexer_b: multiplexer2_4 PORT MAP(
    s => control_word(2),
    In0 => f_unit,
    In1 => data,
    z => MUXD
);


multiplexer_c: multiplexer2_4 PORT MAP(
    s => control_word(0),
    In0 => register_1,
    In1 => pc_tmp,
    z => MUXM
);

function_unit1: function_unit PORT MAP(
    f_select => control_word(7 downto 3),
    in_a => register_1,
    in_b => MUXB,
    n => status(1),
    z => status(0),
    c => status(2), 
    v => status(3), 
    f => f_unit
);

pc_tmp <= PC;
output_data <= MUXB;
output_address <= MUXM;
status <= sig_status; 

end Behavioral;