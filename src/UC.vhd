----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.03.2021 13:06:32
-- Design Name: 
-- Module Name: UC - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity UC is
    Port ( Instr : in  STD_LOGIC_VECTOR(2 downto 0);
           RegDst : out  STD_LOGIC;
           ExtOp : out  STD_LOGIC;
           RegWrite  : out  STD_LOGIC;
           ALUSrc   : out  STD_LOGIC;
           ALUOp : out STD_LOGIC_VECTOR(1 DOWNTO 0);
           MemWrite: out std_logic;
           MemtoReg: out std_logic;
           Branch1  : out  STD_LOGIC;
           Branch2  : out  STD_LOGIC;
           Branch3  : out  STD_LOGIC;
           Jump   : out STD_LOGIC);
end UC;

architecture Behavioral of UC is

begin
    process(Instr)
    begin
    RegDst<='0';RegWrite<='0'; ALUSrc<='0';ExtOp<='0';ALUOp<="00";MemWrite<='0';MemtoReg<='0';Branch1<='0';Jump<='0';Branch2<='0';Branch3<='0';
    case Instr is
    when "000" => RegDst<='1';RegWrite<='1'; ALUOp<="10";  --R type
    when "001" => RegWrite<='1'; ALUSrc<='1';ExtOp<='1';ALUOp<="00";  --addi
    when "010" => RegWrite<='1'; ALUSrc<='1';ExtOp<='1';ALUOp<="00";MemtoReg<='1'; --lw 
    when "011" => ALUSrc<='1';ExtOp<='1';ALUOp<="00";MemWrite<='1';  --sw
    when "100" => ExtOp<='1';ALUOp<="01";Branch1<='1';  --beq
    when "101" => ExtOp<='1';ALUOp<="01";Branch2<='1';  --bne
    when "110" => ExtOp<='1';ALUOp<="01";Branch3<='1';   --bgez
    when "111" => Jump<='1';  --j
    when others =>RegDst<='X';RegWrite<='X'; ALUSrc<='X';ExtOp<='X';ALUOp<="XX";MemWrite<='X';MemtoReg<='X';Branch1<='X';Jump<='X';Branch2<='X';Branch3<='X';
    end case;
    end process;

end Behavioral;
