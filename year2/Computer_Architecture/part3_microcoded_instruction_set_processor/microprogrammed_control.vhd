library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity microprogrammed_control is
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
end microprogrammed_control;

architecture Behavioral of microprogrammed_control is
component pc_ext 
Port(
    srsb : in STD_LOGIC_VECTOR(5 downto 0);
    output : out STD_LOGIC_VECTOR(15 downto 0)
);
end component;

component pc 
Port( 
     input : in STD_LOGIC_VECTOR(15 downto 0);
     PI : in STD_LOGIC;
     PL : in STD_LOGIC;
     reset : in STD_LOGIC;
     Clk : in STD_LOGIC;
     output : out STD_LOGIC_VECTOR(15 downto 0)
);
end component;

component control_memory
Port(
     CAR : in STD_LOGIC_VECTOR(7 downto 0);
     NA : out STD_LOGIC_VECTOR(7 downto 0);
     MS : out STD_LOGIC_VECTOR(2 downto 0);    
     MC : out STD_LOGIC;
     IL : out STD_LOGIC;
     PI : out STD_LOGIC;
     PL : out STD_LOGIC;
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

component instruction 
Port(
     IR : in STD_LOGIC_VECTOR(15 downto 0);
     IL : in STD_LOGIC;
     Clk : in STD_LOGIC;
     OPCODE : out STD_LOGIC_VECTOR(7 downto 0);
     DR : out STD_LOGIC_VECTOR(2 downto 0);
     SA : out STD_LOGIC_VECTOR(2 downto 0);
     SB : out STD_LOGIC_VECTOR(2 downto 0)
);
end component;

component car
Port(
    s : in STD_LOGIC;
    c : in STD_LOGIC_VECTOR(7 downto 0);
    Clk : in STD_LOGIC;
    reset : in STD_LOGIC;
    output : out STD_LOGIC_VECTOR(7 downto 0)
);
end component;

component mux2_8
Port(
     MC : in STD_LOGIC;
     NA : in STD_LOGIC_VECTOR(7 downto 0);
     OPCODE : in STD_LOGIC_VECTOR(7 downto 0);
     CAR : out STD_LOGIC_VECTOR(7 downto 0)
);
end component;

component mux8_1
Port(
    MS : in STD_LOGIC_VECTOR(2 downto 0);
    ZERO : in STD_LOGIC;
    ONE : in STD_LOGIC;
    C : in STD_LOGIC; 
    V : in STD_LOGIC;
    Z : in STD_LOGIC;
    N : in STD_LOGIC;
    not_C : in STD_LOGIC;
    not_Z : in STD_LOGIC;
    CAR_S : out STD_LOGIC
);
end component;

signal OPCODE, car_output, MUXC, NA : std_logic_vector(7 downto 0);
signal MC, IL, PI, PL, NOTC, NOTZ, s_mux : std_logic;
signal MS, SDR, SSA, SSB: std_logic_vector(2 downto 0);
signal extendOut : std_logic_vector(15 downto 0); 
signal extendIn : std_logic_vector(5 downto 0);

begin

programCounter: PC PORT MAP(
    input => extendOut,
    PL => pl,
    PI => pi,
    reset => reset,
    Clk => Clk,
    output => next_programcounter
);

extend : pc_ext PORT MAP(
    srsb => extendIn,
    output => extendOut
);

multiplex81bit : mux8_1 PORT MAP(
    MS => MS,
    ZERO => '0',
    ONE => '1',
    C => C,
    V => V, 
    Z => Z,
    N => N,
    not_C => NOTC,
    not_Z => NOTZ,
    CAR_S => s_mux
);

instr_ctrol: instruction PORT MAP(
    IR => instr,
    IL => IL,
    Clk => Clk,
    OPCODE => OPCODE,
    DR => SDR, 
    SA => SSA,
    SB => SSB
);

multiplexer28: mux2_8 PORT MAP(
    MC => MC,
    NA => NA,
    OPCODE => opcode,
    CAR => MUXC
);

addr_control: CAR PORT MAP(
    s => s_mux,
    c => MUXC,
    Clk => Clk,
    reset => reset,
    output => car_output
);

memory_control: control_memory PORT MAP(
    CAR => car_output,
    MW => MW,
    MM => MM,
    RW => RW,
    MD => MD,
    FS => FS,
    MB => MB,
    TB => TB,
    TA => TA,
    TD => TD,
    PL => PL,
    PI => PI,
    IL => IL,
    MC => MC,
    MS => MS,
    NA => NA
);

NOTC <= NOTC;
NOTZ <= NOTZ;
DR <= SDR;
SB <= SSB;
SA <= SSA;
end Behavioral;

