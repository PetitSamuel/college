library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity register_file is
    Port ( src_s0 : in std_logic;
    src_s1 : in std_logic;
    src_s2 : in std_logic;
    des_A0 : in std_logic;
    des_A1 : in std_logic;
    des_A2 : in std_logic;
    Clk : in std_logic;
    data_src : in std_logic;
    data : in std_logic_vector(15 downto 0);
    reg0 : out std_logic_vector(15 downto 0);
    reg1 : out std_logic_vector(15 downto 0);
    reg2 : out std_logic_vector(15 downto 0);
    reg3 : out std_logic_vector(15 downto 0);
    reg4 : out std_logic_vector(15 downto 0);
    reg5 : out std_logic_vector(15 downto 0);
    reg6 : out std_logic_vector(15 downto 0);
    reg7 : out std_logic_vector(15 downto 0));
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
    COMPONENT decoder3_8
        port(
            A0 : in std_logic;
            A1 : in std_logic;
            A2 : in std_logic;
            Q0 : out std_logic;
            Q1 : out std_logic;
            Q2 : out std_logic;
            Q3 : out std_logic;
            Q4 : out std_logic;
            Q5 : out std_logic;
            Q6 : out std_logic;
            Q7 : out std_logic
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
    COMPONENT multiplexer8
    PORT(
         s : IN  std_logic_vector(2 downto 0);
         in0 : IN  std_logic_vector(15 downto 0);
         in1 : IN  std_logic_vector(15 downto 0);
         in2 : IN  std_logic_vector(15 downto 0);
         in3 : IN  std_logic_vector(15 downto 0);
         in4 : IN  std_logic_vector(15 downto 0);
         in5 : IN  std_logic_vector(15 downto 0);
         in6 : IN  std_logic_vector(15 downto 0);
         in7 : IN  std_logic_vector(15 downto 0);
         Z : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    
    -- signals
    signal load_reg0, load_reg1, load_reg2, load_reg3, load_reg4, load_reg5, load_reg6, load_reg7 : std_logic;
    signal reg0_q, reg1_q, reg2_q, reg3_q, reg4_q, reg5_q, reg6_q, reg7_q,data_src_mux_out, src_reg : std_logic_vector(15 downto 0);
begin

-- register 0
    reg00: register16 PORT MAP(
    D => data_src_mux_out,
    load => load_reg0,
    Clk => Clk,
    Q => reg0_q
    );
-- register 1
    reg01: register16 PORT MAP(
    D => data_src_mux_out,
    load => load_reg1,
    Clk => Clk,
    Q => reg1_q
    );
-- register 2
    reg02: register16 PORT MAP(
    D => data_src_mux_out,
    load => load_reg2,
    Clk => Clk,
    Q => reg2_q
    );
-- register 3
    reg03: register16 PORT MAP(
    D => data_src_mux_out,
    load => load_reg3,
    Clk => Clk,
    Q => reg3_q
    );
-- register 4
    reg04: register16 PORT MAP(
    D => data_src_mux_out,
    load => load_reg4,
    Clk => Clk,
    Q => reg4_q
    );
-- register 5
    reg05: register16 PORT MAP(
    D => data_src_mux_out,
    load => load_reg5,
    Clk => Clk,
    Q => reg5_q
    );
-- register 6
    reg06: register16 PORT MAP(
    D => data_src_mux_out,
    load => load_reg6,
    Clk => Clk,
    Q => reg6_q
    );
-- register 7
    reg07: register16 PORT MAP(
    D => data_src_mux_out,
    load => load_reg7,
    Clk => Clk,
    Q => reg7_q
    );

-- Destination register decoder
    des_decoder_3to8: decoder3_8 PORT MAP(
        A0 => des_A0,
        A1 => des_A1,
        A2 => des_A2,
        Q0 => load_reg0,
        Q1 => load_reg1,
        Q2 => load_reg2,
        Q3 => load_reg3,
        Q4 => load_reg4,
        Q5 => load_reg5,
        Q6 => load_reg6,
        Q7 => load_reg7
     );
     
     
     -- 2 to 1 Data source multiplexer
    data_src_mux2_4bit: multiplexer2_4 PORT MAP(
        in0 => data,
        in1 => src_reg,
        s => data_src,
        Z => data_src_mux_out
    );
    
    -- 4 to 1 source register multiplexer
    Inst_mux4_4bit: multiplexer8 PORT MAP(
        in0 => reg0_q,
        in1 => reg1_q,
        in2 => reg2_q,
        in3 => reg3_q,
        in4 => reg4_q,
        in5 => reg5_q,
        in6 => reg6_q,
        in7 => reg7_q,
        s(0) => src_s0,
        s(1) => src_s1,
        s(2) => src_s2,
        Z => src_reg
    );

    reg0 <= reg0_q;
    reg1 <= reg1_q;
    reg2 <= reg2_q;
    reg3 <= reg3_q;
    reg4 <= reg4_q;
    reg5 <= reg5_q;
    reg6 <= reg6_q;
    reg7 <= reg7_q;
end Behavioral;