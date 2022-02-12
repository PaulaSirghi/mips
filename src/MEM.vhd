----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.03.2021 13:16:44
-- Design Name: 
-- Module Name: RAMwf - Behavioral
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
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MEM is
Port ( clk : in STD_LOGIC;
           WA : in STD_LOGIC_VECTOR (15 downto 0);
           WD : in STD_LOGIC_VECTOR (15 downto 0);
           MemWrite: in STD_LOGIC;
           en: in STD_LOGIC;
           RD1 : out STD_LOGIC_VECTOR (15 downto 0);
           ALURes: out STD_LOGIC_VECTOR(15 downto 0));
end MEM;

architecture Behavioral of MEM is
type ram_array is array (0 to 15) of std_logic_vector (15 downto 0);
signal mem: ram_array:= (
        0=> x"0002",
        1=> x"0001",
        2=> x"0002",
        3=> x"0003",
        4=> x"0002",
        5=> x"0004",
        others => x"0000"
        );

begin
process(MemWrite,clk,en) 
begin
    if rising_edge(clk) then
       if MemWrite='1'  then
       if en='1' then
               mem(conv_integer(WA))<=WD;
       end if;
     end if;
    end if;
end process;
RD1<=mem(conv_integer(WA));
ALURes<=WA;
end Behavioral;
