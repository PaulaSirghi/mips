library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;
use IEEE.numeric_std.all; 

entity EX is
    Port ( RD1 : in  STD_LOGIC_VECTOR (15 downto 0);
           ALUSrc   : in  STD_LOGIC;
           RD2   : in  STD_LOGIC_VECTOR (15 downto 0);
           Ext_Imm : in STD_LOGIC_VECTOR (15 downto 0);
           sa : in STD_LOGIC;
           func : in STD_LOGIC_VECTOR (2 downto 0);
           ALUOp : in STD_LOGIC_VECTOR(1 downto 0);
           PC: in STD_LOGIC_VECTOR(15 downto 0);
           zero : out STD_LOGIC;
           BA: out STD_LOGIC_VECTOR(15 downto 0);
           ALURes : out STD_LOGIC_VECTOR (15 downto 0);
           sign: out STD_LOGIC);
end EX;

architecture Behavioral of EX is
signal Bi:std_logic_vector(15 downto 0):="0000000000000000";
signal ALUCtrl:std_logic_vector(2 downto 0):="000";
signal ALURes1:std_logic_vector(15 downto 0):="0000000000000000";
begin
   process(ALUSrc)
   begin
   if ALUSrc='1' then
        Bi<=Ext_Imm;
   else
         Bi<=RD2;
   end if;
   end process;
   
   BA<=PC+Ext_Imm;
   
   process(RD1,Bi)
   begin
   if RD1<Bi
    then sign<='1';
   else
     sign<='0';
    end if;
    end process;
   
   process(ALUOp,func)
   begin
   case ALUOp is
   when "00"=>ALUCtrl<="000";
   when "01"=>ALUCtrl<="001";
   when "10" =>ALUCtrl<=func;
   when others=>ALUCtrl<="XXX";
   end case;
   end process;
   
   
    process(ALUCtrl,RD1,Bi,sa)
    begin
    case ALUCtrl is
    when "000" =>ALURes1<=RD1+Bi;
    when "001" =>ALURes1<=RD1-Bi;
    when "010" =>if sa='1' then ALURes1<=RD1(14 downto 0)&'1'; end if;
    when "011" =>if sa='1' then ALURes1<='0' & RD1(15 downto 1); end if;
    when "100" =>ALURes1<=RD1 and Bi;
    when "101" =>ALURes1<=RD1 or Bi;
    when "110" =>ALURes1<=RD1 xor Bi;
    when "111" =>if signed(RD1)<signed(Bi) 
                    then ALURes1<=x"0001";
                 else ALURes1<=x"0000";
                 end if;
    when others => ALURes1<="XXXX";
    end case;
    end process;
    
    zero<='1' when ALURes1=x"0000" else '0';
    ALURes<=ALURes1;
end Behavioral;