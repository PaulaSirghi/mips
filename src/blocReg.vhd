----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.03.2021 12:43:16
-- Design Name: 
-- Module Name: blocReg - Behavioral
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

entity blocReg is
  Port ( clk : in STD_LOGIC;
           RA1 : in STD_LOGIC_VECTOR (2 downto 0);
           RA2 : in STD_LOGIC_VECTOR (2 downto 0);
           WA : in STD_LOGIC_VECTOR (2 downto 0);
           WD : in STD_LOGIC_VECTOR (15 downto 0);
           Enable: in STD_LOGIC;
           RegWn: in STD_LOGIC;
           RD1 : out STD_LOGIC_VECTOR (15 downto 0);
           RD2 : out STD_LOGIC_VECTOR (15 downto 0));
end blocReg;

architecture Behavioral of blocReg is
    type reg_array is array(0 to 15) of STD_LOGIC_VECTOR(15 downto 0);
    signal reg_file: reg_array:=(
        B"0000000000000000", 
        B"0000000000000000",
        B"0000000000000000",
        B"0000000000000000",
        B"0000000000000000",
        B"0000000000000000",
        B"0000000000000000",
        B"0000000000000000",
others=>x"0000");
begin
process(clk, RegWn, Enable)
   begin
      if rising_edge(clk) then
         if RegWn='1' and Enable='1' then 
            reg_file(conv_integer(WA))<=WD;
         end if;
      end if;
end process;
RD1<=reg_file(conv_integer(RA1));
RD2<=reg_file(conv_integer(RA2));
end Behavioral;
