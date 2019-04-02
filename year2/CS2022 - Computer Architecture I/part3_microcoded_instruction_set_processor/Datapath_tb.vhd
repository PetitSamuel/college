library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Datapath_tb is
--  Port ( );
end Datapath_tb;

architecture Behavioral of Datapath_tb is
    component Datapath is
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

    signal data, pc : std_logic_vector(15 downto 0);
    signal control_word : std_logic_vector(17 downto 0);
    signal Clk :  std_logic := '0';
    signal DR, SA, SB : std_logic_vector(2 downto 0);
    signal TD, TA, TB : std_logic := '0';
    signal output_data, output_address : std_logic_vector(15 downto 0);
    signal status : std_logic_vector(3 downto 0);
    signal v, c, n, z : std_logic;

    constant Clk_period : time := 10 ns;

begin

     uut: Datapath port map (
          data => data,
          pc => pc,
          control_word => control_word,
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
          v => v,
          c => c,
          n => n,
          z => z
    );
   
    Clk <=  '1' after Clk_period when Clk = '0' else
           '0' after Clk_period when clk = '1';
           
   stim_proc: process

    begin
        data <= "1111111111111111";
        PC <= "0000000000000001";
        control_word <= "001000001000000011";
        DR <= "000";
        SA <= "000";
        SB <= "000";
        wait for 50ns;
        wait for 50ns;
        data <= "1111000011110000";
        
        TD <= '0';
        control_word <= "000000100000010110";
        wait for 50ns;
        control_word <= "010000000110001001";
        wait for 50ns;
        control_word <= "000000001010000000";	
        --input_data <= "1111111111111111";
		--in_cst <= "0000000000000001";
		--ctrl_w <= "001000001000000011";
		--wait for 25ns;
		--input_data <= "1111000011110000";
		--wait for 25ns;
		--(ctrl_w <= "010000000110001001";
		--wait for 25ns;
        --ctrl_w <= "000000001010000000";		
		wait for 50ns;
		control_word <= "000000001000000011";
       wait;
   end process;   

end Behavioral;