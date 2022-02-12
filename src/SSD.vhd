----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.02.2021 23:41:22
-- Design Name: 
-- Module Name: lab2_1 - Behavioral
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
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SSD is
 Port ( clk : in STD_LOGIC;
        sw : in STD_LOGIC_VECTOR (15 downto 0);
        an : out STD_LOGIC_VECTOR (3 downto 0);
        cat : out STD_LOGIC_VECTOR (6 downto 0));
end SSD;

architecture Behavioral of SSD is
signal sel: std_logic_vector(1 downto 0):="00";  --iesirea numaratorului
signal m1: std_logic_vector(3 downto 0):="0000";  --iesire MUX1
signal ct: std_logic_vector(15 downto 0):="0000000000000000";  --iesire MUX1

begin

process(clk)  --proces pentru numarator
begin 
    if clk = '1' and clk'event then 
        ct <= ct + 1;
        sel<=ct(15 downto 14);
    end if;
end process;

process(sel,sw)  --multiplexoarele
begin
    case sel is
        when "00"=>m1<=sw(3 downto 0); an<="1110";
        when "01"=>m1<=sw(7 downto 4); an<="1101";
        when "10"=>m1<=sw(11 downto 8); an<="1011";
        when others=>m1<=sw(15 downto 12);an<="0111";
    end case;
end process;

with m1 select
   cat<= "1111001" when "0001",   --1
         "0100100" when "0010",   --2
         "0110000" when "0011",   --3
         "0011001" when "0100",   --4
         "0010010" when "0101",   --5
         "0000010" when "0110",   --6
         "1111000" when "0111",   --7
         "0000000" when "1000",   --8
         "0010000" when "1001",   --9
         "0001000" when "1010",   --A
         "0000011" when "1011",   --b
         "1000110" when "1100",   --C
         "0100001" when "1101",   --d
         "0000110" when "1110",   --E
         "0001110" when "1111",   --F
         "1000000" when others;   --0
end Behavioral;
