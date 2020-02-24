library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity control_memory is
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
end control_memory;

architecture Behavioral of control_memory is

type memory is array (0 to 255) of std_logic_vector(27 downto 0);
  
begin
MEM : process(CAR)
variable ctrl_memory : memory := (
--0
"1100000000100000001000100100", -- 0 ADI
"1100000000100000000000001100", -- 1 LDR
"1100000000100000000000000001", -- 2 STR
"1100000000100000000000010100", -- 3 INC
"1100000000100000000011100100", -- 4 NOT
"1100000000100000000000100100", -- 5 ADD
"1000011000100000000000001100", -- 6 LRI
"1000011111100001000000000100", -- 7 SR
"1100000000100000000000000000", -- 8 catch
"0011000010000000000000000000", -- 9 bEQ
"1100000000100000000000000000", -- A catch
"0011000011100000000000000000", -- B bnz
"1100000000100000000000000000", -- C catch
"1100000000100001000001010100", -- D CMP
"0000000000000000000000000000", -- E
"0000000000000000000000000000", -- F

--1
"0000000000000000000000000000", -- 0
"0000000000000000000000000000", -- 1
"0000000000000000000000000000", -- 2
"0000000000000000000000000000", -- 3
"0000000000000000000000000000", -- 4
"0000000000000000000000000000", -- 5
"0000000000000000000000000000", -- 6
"0000000000000000000000000000", -- 7
"0000000000000000000000000000", -- 8
"0000000000000000000000000000", -- 9
"0000000000000000000000000000", -- A
"0000000000000000000000000000", -- B
"0000000000000000000000000000", -- C
"0000000000000000000000000000", -- D
"0000000000000000000000000000", -- E
"0000000000000000000000000000", -- F

--2
"0000000000000000000000000000", -- 0
"0000000000000000000000000000", -- 1
"0000000000000000000000000000", -- 2
"0000000000000000000000000000", -- 3
"0000000000000000000000000000", -- 4
"0000000000000000000000000000", -- 5
"0000000000000000000000000000", -- 6
"0000000000000000000000000000", -- 7
"0000000000000000000000000000", -- 8
"1100000000100000000000001100", -- 9 LDR
"0000000000000000000000000000", -- A
"0000000000000000000000000000", -- B
"0000000000000000000000000000", -- C
"0000000000000000000000000000", -- D
"0000000000000000000000000000", -- E
"0000000000000000000000000000", -- F

--3
"1100000000100010000000000000", -- 0 unconditional branch
"0000000000000000000000000000", -- 1
"0000000000000000000000000000", -- 2
"0000000000000000000000000000", -- 3
"0000000000000000000000000000", -- 4
"0000000000000000000000000000", -- 5
"0000000000000000000000000000", -- 6
"0000000000000000000000000000", -- 7
"0000000000000000000000000000", -- 8
"0000000000000000000000000000", -- 9
"0000000000000000000000000000", -- A
"0000000000000000000000000000", -- B
"0000000000000000000000000000", -- C
"0000000000000000000000000000", -- D
"0000000000000000000000000000", -- E
"0000000000000000000000000000", -- F

--4
"0000000000000000000000000000", -- 0
"0000000000000000000000000000", -- 1
"0000000000000000000000000000", -- 2
"0000000000000000000000000000", -- 3
"0000000000000000000000000000", -- 4
"0000000000000000000000000000", -- 5
"0000000000000000000000000000", -- 6
"0000000000000000000000000000", -- 7
"0000000000000000000000000000", -- 8
"0000000000000000000000000000", -- 9
"0000000000000000000000000000", -- A
"0000000000000000000000000000", -- B
"0000000000000000000000000000", -- C
"0000000000000000000000000000", -- D
"0000000000000000000000000000", -- E
"0000000000000000000000000000", -- F

--5
"0000000000000000000000000000", -- 0
"0000000000000000000000000000", -- 1
"0000000000000000000000000000", -- 2
"0000000000000000000000000000", -- 3
"0000000000000000000000000000", -- 4
"0000000000000000000000000000", -- 5
"0000000000000000000000000000", -- 6
"0000000000000000000000000000", -- 7
"0000000000000000000000000000", -- 8
"0000000000000000000000000000", -- 9
"0000000000000000000000000000", -- A
"0000000000000000000000000000", -- B
"0000000000000000000000000000", -- C
"0000000000000000000000000000", -- D
"0000000000000000000000000000", -- E
"0000000000000000000000000000", -- F

--6
"0000000000000000000000000000", -- 0
"0000000000000000000000000000", -- 1
"0000000000000000000000000000", -- 2
"0000000000000000000000000000", -- 3
"0000000000000000000000000000", -- 4
"0000000000000000000000000000", -- 5
"0000000000000000000000000000", -- 6
"0000000000000000000000000000", -- 7
"0000000000000000000000000000", -- 8
"0000000000000000000000000000", -- 9
"0000000000000000000000000000", -- A
"0000000000000000000000000000", -- B
"0000000000000000000000000000", -- C
"0000000000000000000000000000", -- D
"0000000000000000000000000000", -- E
"0000000000000000000000000000", -- F

--7
"0000000000000000000000000000", -- 0
"0000000000000000000000000000", -- 1
"0000000000000000000000000000", -- 2
"0000000000000000000000000000", -- 3
"0000000000000000000000000000", -- 4
"0000000000000000000000000000", -- 5
"0000000000000000000000000000", -- 6
"0000000000000000000000000000", -- 7
"0000000000000000000000000000", -- 8
"0000000000000000000000000000", -- 9
"0000000000000000000000000000", -- A
"0000000000000000000000000000", -- B
"0000000000000000000000000000", -- C
"0000000000000000000000000000", -- D
"0000000000000000000000000000", -- E
"0000000000000000000000000000", -- F

--8
"0000000000000000000000000000", -- 0
"0000000000000000000000000000", -- 1
"0000000000000000000000000000", -- 2
"0000000000000000000000000000", -- 3
"0000000000000000000000000000", -- 4
"0000000000000000000000000000", -- 5
"1100000000100000100000001100", -- 6 LRI 2
"1000100000100000000101000100", -- 7 SR M2
"1000011110000001100001100100", -- 8 SR M3
"1100000000100000000000000000", -- 9 catch
"0000000000000000000000000000", -- A
"0000000000000000000000000000", -- B
"0000000000000000000000000000", -- C
"0000000000000000000000000000", -- D
"0000000000000000000000000000", -- E
"0000000000000000000000000000", -- F

--9
"0000000000000000000000000000", -- 0
"0000000000000000000000000000", -- 1
"0000000000000000000000000000", -- 2
"0000000000000000000000000000", -- 3
"0000000000000000000000000000", -- 4
"0000000000000000000000000000", -- 5
"0000000000000000000000000000", -- 6
"0000000000000000000000000000", -- 7
"0000000000000000000000000000", -- 8
"0000000000000000000000000000", -- 9
"0000000000000000000000000000", -- A
"0000000000000000000000000000", -- B
"0000000000000000000000000000", -- C
"0000000000000000000000000000", -- D
"0000000000000000000000000000", -- E
"0000000000000000000000000000", -- F

--A
"0000000000000000000000000000", -- 0
"0000000000000000000000000000", -- 1
"0000000000000000000000000000", -- 2
"0000000000000000000000000000", -- 3
"0000000000000000000000000000", -- 4
"0000000000000000000000000000", -- 5
"0000000000000000000000000000", -- 6
"0000000000000000000000000000", -- 7
"0000000000000000000000000000", -- 8
"0000000000000000000000000000", -- 9
"0000000000000000000000000000", -- A
"0000000000000000000000000000", -- B
"0000000000000000000000000000", -- C
"0000000000000000000000000000", -- D
"0000000000000000000000000000", -- E
"0000000000000000000000000000", -- F

--B
"0000000000000000000000000000", -- 0
"0000000000000000000000000000", -- 1
"0000000000000000000000000000", -- 2
"0000000000000000000000000000", -- 3
"0000000000000000000000000000", -- 4
"0000000000000000000000000000", -- 5
"0000000000000000000000000000", -- 6
"0000000000000000000000000000", -- 7
"0000000000000000000000000000", -- 8
"0000000000000000000000000000", -- 9
"0000000000000000000000000000", -- A
"0000000000000000000000000000", -- B
"0000000000000000000000000000", -- C
"0000000000000000000000000000", -- D
"0000000000000000000000000000", -- E
"0000000000000000000000000000", -- F

--C
"1100000100001100000000000010", -- 0 fetch instruction
"0000000000110000000000000000", -- 1 EXO
"0000000000000000000000000000", -- 2
"0000000000000000000000000000", -- 3
"0000000000000000000000000000", -- 4
"0000000000000000000000000000", -- 5
"0000000000000000000000000000", -- 6
"0000000000000000000000000000", -- 7
"0000000000000000000000000000", -- 8
"0000000000000000000000000000", -- 9
"0000000000000000000000000000", -- A
"0000000000000000000000000000", -- B
"0000000000000000000000000000", -- C
"0000000000000000000000000000", -- D
"0000000000000000000000000000", -- E
"0000000000000000000000000000", -- F

--D
"0000000000000000000000000000", -- 0
"0000000000000000000000000000", -- 1
"0000000000000000000000000000", -- 2
"0000000000000000000000000000", -- 3
"0000000000000000000000000000", -- 4
"0000000000000000000000000000", -- 5
"0000000000000000000000000000", -- 6
"0000000000000000000000000000", -- 7
"0000000000000000000000000000", -- 8
"0000000000000000000000000000", -- 9
"0000000000000000000000000000", -- A
"0000000000000000000000000000", -- B
"0000000000000000000000000000", -- C
"0000000000000000000000000000", -- D
"0000000000000000000000000000", -- E
"0000000000000000000000000000", -- F

--E
"0000000000000000000000000000", -- 0
"0000000000000000000000000000", -- 1
"0000000000000000000000000000", -- 2
"0000000000000000000000000000", -- 3
"0000000000000000000000000000", -- 4
"0000000000000000000000000000", -- 5
"0000000000000000000000000000", -- 6
"0000000000000000000000000000", -- 7
"0000000000000000000000000000", -- 8
"0000000000000000000000000000", -- 9
"0000000000000000000000000000", -- A
"0000000000000000000000000000", -- B
"0000000000000000000000000000", -- C
"0000000000000000000000000000", -- D
"0000000000000000000000000000", -- E
"0000000000000000000000000000", -- F

--F
"0000000000000000000000000000", -- 0
"0000000000000000000000000000", -- 1
"0000000000000000000000000000", -- 2
"0000000000000000000000000000", -- 3
"0000000000000000000000000000", -- 4
"0000000000000000000000000000", -- 5
"0000000000000000000000000000", -- 6
"0000000000000000000000000000", -- 7
"0000000000000000000000000000", -- 8
"0000000000000000000000000000", -- 9
"0000000000000000000000000000", -- A
"0000000000000000000000000000", -- B
"0000000000000000000000000000", -- C
"0000000000000000000000000000", -- D
"0000000000000000000000000000", -- E
"0000000000000000000000000000" -- F
);

variable tmp : integer;
variable output : std_logic_vector(27 downto 0);

begin

tmp := conv_integer(CAR);
output := ctrl_memory(tmp);
MW <= output(0);
MM <= output(1);
RW <= output(2);
MD <= output(3);
FS <= output(8 downto 4);
MB <= output(9);
TB <= output(10);
TA <= output(11);
TD <= output(12);
PL <= output(13);
PI <= output(14);
IL <= output(15);
MC <= output(16);
MS <= output(19 downto 17);
NA <= output(27 downto 20);

end process;
end Behavioral;