----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.02.2021 21:02:24
-- Design Name: 
-- Module Name: Lab1_3 - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MPG is
    Port ( clk : in STD_LOGIC;
           btn : in STD_LOGIC;
           enable : out STD_LOGIC);   
end MPG;

architecture Behavioral of MPG is

signal nr1 : STD_LOGIC_VECTOR( 15 downto 0) := "0000000000000000";  -- initializam numaratorul sa numere de la 0 (16 biti)
signal Q1 : STD_LOGIC;  --avem 3 iesiri Q de la cele 3 bistabile D
signal Q2 : STD_LOGIC;
signal Q3 : STD_LOGIC;

begin
    process(clk)
    begin
        if clk = '1' and clk'event then  --poarta si de la intrarea En a primului bistabil D
            nr1 <= nr1 + 1;
        end if;
    end process;
    
    process(clk)
    begin
        if clk = '1' and clk'event then
            if nr1 = "1111111111111111" then
                Q1 <= btn;
            end if;
        end if;
    end process;
    
    process(clk)
    begin
        if clk = '1' and clk'event then
            Q2 <= Q1;
            Q3 <= Q2;
        end if;
    end process;
enable <= (not Q3) and Q2;   --poarta si de dinainte de enable
end Behavioral;

