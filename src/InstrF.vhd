library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity InstrF is
    Port ( Jump : in  STD_LOGIC;
           PCSrc : in  STD_LOGIC;
           JA   : in  STD_LOGIC_VECTOR (15 downto 0);
           BA   : in  STD_LOGIC_VECTOR (15 downto 0);
           clk : in STD_LOGIC;
           en: in std_logic:='0';
           reset: in std_logic:='0';
           i   : out  STD_LOGIC_VECTOR (15 downto 0);
           PC_o   : out STD_LOGIC_VECTOR (15 downto 0));
          
end InstrF;

architecture Behavioral of InstrF is

signal mux1o: std_logic_vector(15 downto 0):="0000000000000000";
--semnale pentru PC
signal PCi: std_logic_vector(15 downto 0):="0000000000000000";
signal PCo: std_logic_vector(15 downto 0):="0000000000000000";
signal Q: std_logic_vector(15 downto 0):="0000000000000000";


type tRom is array(0 to 255) of STD_LOGIC_VECTOR(15 downto 0);
signal mem: tRom:=(

B"000_000_000_010_0_000",   --X0020 add $2,$0,$0
B"000_000_000_101_0_000",   --X0050 add $5,$0,$0
B"001_000_110_0000010",     --X2302  addi &6,&0,2
B"000_000_000_001_0_000",   --X0010 add $1,$0,$0
B"001_000_100_0000101",     --X2205 addi $4,$0,5
B"100_001_100_0001100",     --X860C  beq $1,$4,12
B"010_010_011_0000000",     --X4980 lw: $3,0($2)
B"011_010_011_0000000",     --X6980 sw $3,0($2) 
B"101_011_110_0000101",     --XAf05 bne $3,$6,o_data
B"000_101_011_101_0_000",   --X15D0 add $5,$5,$3
B"000_101_011_101_0_000",   --X15D0 add $5,$5,$3
B"001_010_010_0000001",     --X2901 addi $2,$2,1
B"001_001_001_0000001",     --X2481 addi $1,$1,1
B"111_0000000000101",       --XE005 j 5
B"000_101_011_101_0_000",   --X15D0 add $5,$5,$3
B"001_010_010_0000001",     --X2901 addi $2,$2,1
B"001_001_001_0000001",     --X2481 addi $1,$1,1
B"111_0000000000101",       --XE005 j 5
B"011_000_101_0000000",     --X6280 sw $5,0($0)
others=>x"0000");

begin
    PC_o<=Q+'1';

    process(PCSrc,Jump,JA,BA,Q)
    begin
    if Jump='1' then
       PCi<=JA;
    elsif Jump='0' then
         if PCSrc='1' then 
            PCi<=BA;
         else
            PCi<=Q+'1';
        end if;
    end if;
    end process;
    
    process(clk,reset,en)  --PC
    begin
    if reset='1' then
      Q<=x"0000";
    elsif rising_edge(clk) then
       if en='1' then
            Q<=PCi;
      end if;
    end if;
    end process;
    
    process(Q)
    begin --ROM
         i<=mem(conv_integer(Q(4 downto 0)));
    end process;
end Behavioral;