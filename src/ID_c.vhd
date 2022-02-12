library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity ID_c is
    Port ( RegWrite : in  STD_LOGIC;
           Instr   : in  STD_LOGIC_VECTOR (15 downto 0);
           RegDst : in  STD_LOGIC;
           ExtOp   : in  STD_LOGIC;
           clk : in STD_LOGIC;
           WD   : in STD_LOGIC_VECTOR (15 downto 0);
           Enable: in STD_LOGIC;
           RD1   : out  STD_LOGIC_VECTOR (15 downto 0);
           RD2   : out STD_LOGIC_VECTOR (15 downto 0);
           Ext_Imm   : out STD_LOGIC_VECTOR (15 downto 0);
           func   : out  STD_LOGIC_VECTOR (2 downto 0);
           sa   : out STD_LOGIC);           
end ID_c;

architecture Behavioral of ID_c is

component blocReg is
  Port ( clk : in STD_LOGIC;
           RA1 : in STD_LOGIC_VECTOR (2 downto 0);
           RA2 : in STD_LOGIC_VECTOR (2 downto 0);
           WA : in STD_LOGIC_VECTOR (2 downto 0);
           WD : in STD_LOGIC_VECTOR (15 downto 0);
           Enable: in STD_LOGIC;
           RegWn: in STD_LOGIC;
           RD1 : out STD_LOGIC_VECTOR (15 downto 0);
           RD2 : out STD_LOGIC_VECTOR (15 downto 0));
end component blocReg;

signal WA: std_logic_vector(2 downto 0):="000";
begin
    process(RegDst,Instr)  --mux-ul
    begin
    sa<=Instr(0);
    if RegDst ='1' then 
        WA<=Instr(6 downto 4);
    else
       WA<=Instr(9 downto 7);
    
    end if;
    end process;
    
    RF: blocReg port map(clk,Instr(12 downto 10),Instr(9 downto 7),WA,WD,Enable,RegWrite,RD1,RD2);
    
    process(ExtOp,Instr(6 downto 0)) --extensia cu semn pentru ExtOp=1 si cu zero alftel
    begin
    if ExtOp='0' then  --extindem cu 0
       Ext_Imm<="000000000" & Instr(6 downto 0);
    else  --extindem cu semn
        if Instr(6)='1' then
             Ext_Imm<="111111111" & Instr(6 downto 0);
        else
            Ext_Imm<="000000000" & Instr(6 downto 0);
        end if;
    end if;
    end process;
       
end Behavioral;