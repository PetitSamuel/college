library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity final is
Port(
     Clk : in STD_LOGIC;
     reset : in STD_LOGIC
);
end final;

architecture Behavioral of final is

component Datapath
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
end component;

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

component memory
	Port(	address : in STD_LOGIC_VECTOR(15 downto 0);
			data_write : in STD_LOGIC_VECTOR(15 downto 0);
			mw : in STD_LOGIC;
			data_read : out STD_LOGIC_VECTOR(15 downto 0)
			);
end component;

--mcp signals
signal next_programcounter : std_logic_vector(15 downto 0);
signal dr, sa, sb : std_logic_vector(2 downto 0);
signal fs : std_logic_vector(4 downto 0);
signal td, ta, tb, mb, md, rw, mm, mw : std_logic;

--datapath signals
signal output_data, output_address : std_logic_vector(15 downto 0);
signal status : std_logic_vector(3 downto 0);
signal ctrl_w : std_logic_vector(17 downto 0);

--memory signals
signal data_read : std_logic_vector(15 downto 0);


begin
dp: Datapath PORT MAP(
  data => data_read,
  pc => next_programcounter,
  control_word => ctrl_w,
  Clk => Clk,
  DR => DR,
  SA => SA,
  SB => SB,
  TD => TD,
  TA => TA,
  TB => TB,
  output_data => output_data,
  output_address => output_address,
  status => status,
  N => status(0),
  Z => status(1),
  C => status(2),   
  V => status(3)
);

mpc: microprogrammed_control PORT MAP(
Clk => Clk,
reset => reset,
instr => data_read,
n => status(0),
z => status(1),
c => status(2),
v => status(3),
next_programcounter => next_programcounter,
dr => dr,
sa => sa, 
sb => sb,
td => td,
ta => ta, 
tb => tb, 
mb => mb, 
md => md, 
rw => rw,
mm => mm,
mw => mw
);


mem: memory PORT MAP(
    address => output_address,
    data_write => output_data,
    mw => mw,
    data_read => data_read
);

end Behavioral;
