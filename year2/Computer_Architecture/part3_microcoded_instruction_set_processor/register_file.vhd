library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity register_file is
    Port ( Clk, load_en : in std_logic;
        address_a, address_b, dest : in std_logic_vector(3 downto 0);
        data : in std_logic_vector(15 downto 0);
        out_a, out_b : out std_logic_vector(15 downto 0)
    );
end register_file;

architecture Behavioral of register_file is
--components
    -- 16 bit Register for register file
    COMPONENT register16
    PORT(
        D : in std_logic_vector(15 downto 0);
        load, Clk : in std_logic;
        Q : out std_logic_vector(15 downto 0)
        );
    END COMPONENT;
        -- 3 to 8 Decoder
    COMPONENT decoder4_9
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
    END COMPONENT;
    -- 2 to 1 line multiplexer
    COMPONENT multiplexer2_4
    PORT(
         s : IN  std_logic;
         in0 : IN  std_logic_vector(15 downto 0);
         in1 : IN  std_logic_vector(15 downto 0);
         Z : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    
        -- 8 to 1 line multiplexer
    COMPONENT mux9
    PORT(
         s : IN  std_logic_vector(3 downto 0);
         in0 : IN  std_logic_vector(15 downto 0);
         in1 : IN  std_logic_vector(15 downto 0);
         in2 : IN  std_logic_vector(15 downto 0);
         in3 : IN  std_logic_vector(15 downto 0);
         in4 : IN  std_logic_vector(15 downto 0);
         in5 : IN  std_logic_vector(15 downto 0);
         in6 : IN  std_logic_vector(15 downto 0);
         in7 : IN  std_logic_vector(15 downto 0);
         in8 : IN  std_logic_vector(15 downto 0);
         Z : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    
    -- signals
    signal load_reg0, load_reg1, load_reg2, load_reg3, load_reg4, load_reg5, load_reg6, load_reg7, load_reg8 : std_logic;
    signal load_reg0b, load_reg1b, load_reg2b, load_reg3b, load_reg4b, load_reg5b, load_reg6b, load_reg7b, load_reg8b : std_logic;
    signal reg0_q, reg1_q, reg2_q, reg3_q, reg4_q, reg5_q, reg6_q, reg7_q, reg8_q: std_logic_vector(15 downto 0);
begin

-- register 0
    reg00: register16 PORT MAP(
    D => data,
    load => load_reg0b,
    Clk => Clk,
    Q => reg0_q
    );
-- register 1
    reg01: register16 PORT MAP(
    D => data,
    load => load_reg1b,
    Clk => Clk,
    Q => reg1_q
    );
-- register 2
    reg02: register16 PORT MAP(
    D => data,
    load => load_reg2b,
    Clk => Clk,
    Q => reg2_q
    );
-- register 3
    reg03: register16 PORT MAP(
    D => data,
    load => load_reg3b,
    Clk => Clk,
    Q => reg3_q
    );
-- register 4
    reg04: register16 PORT MAP(
    D => data,
    load => load_reg4b,
    Clk => Clk,
    Q => reg4_q
    );
-- register 5
    reg05: register16 PORT MAP(
    D => data,
    load => load_reg5b,
    Clk => Clk,
    Q => reg5_q
    );
-- register 6
    reg06: register16 PORT MAP(
    D => data,
    load => load_reg6b,
    Clk => Clk,
    Q => reg6_q
    );
-- register 7
    reg07: register16 PORT MAP(
    D => data,
    load => load_reg7b,
    Clk => Clk,
    Q => reg7_q
    );
    
-- register 8
    reg08: register16 PORT MAP(
    D => data,
    load => load_reg8b,
    Clk => Clk,
    Q => reg8_q
    );

-- Destination register decoder
    des_decoder_4to9: decoder4_9 PORT MAP(
        A0 => dest(0),
        A1 => dest(1),
        A2 => dest(2),
        A3 => dest(3),
        Q0 => load_reg0,
        Q1 => load_reg1,
        Q2 => load_reg2,
        Q3 => load_reg3,
        Q4 => load_reg4,
        Q5 => load_reg5,
        Q6 => load_reg6,
        Q7 => load_reg7,
        Q8 => load_reg8
     );
 
   Inst_mux9 : mux9 port map(
    s(0) => address_a(0),
    s(1) => address_a(1),
    s(2) => address_a(2),
    s(3) => address_a(3),
    in0 => reg0_q,
    in1 => reg1_q,
    in2 => reg2_q,
    in3 => reg3_q,
    in4 => reg4_q,
    in5 => reg5_q,
    in6 => reg6_q,
    in7 => reg7_q,
    in8 => reg8_q,
    z => out_a
  );
  inst_mux9_2 : mux9 port map(
    s(0) => address_b(0),
    s(1) => address_b(1),
    s(2) => address_b(2),
    s(3) => address_b(3),
    in0 => reg0_q,
    in1 => reg1_q,
    in2 => reg2_q,
    in3 => reg3_q,
    in4 => reg4_q,
    in5 => reg5_q,
    in6 => reg6_q,
    in7 => reg7_q,
    in8 => reg8_q,
    z => out_b
  );
 
    load_reg0b <= (load_reg0 and load_en);
    load_reg1b <= (load_reg1 and load_en);
    load_reg2b <= (load_reg2 and load_en);
    load_reg3b <= (load_reg3 and load_en);
    load_reg4b <= (load_reg4 and load_en);
    load_reg5b <= (load_reg5 and load_en);
    load_reg6b <= (load_reg6 and load_en);
    load_reg7b <= (load_reg7 and load_en);
    load_reg8b <= (load_reg8 and load_en);
end Behavioral;