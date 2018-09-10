----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:29:48 11/09/2012 
-- Design Name: 
-- Module Name:    shizhong - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity shizhong is
port(
		clk:in std_logic;
		rst:in std_logic;
		t:out std_logic_vector(3 downto 0));
end shizhong;

architecture Behavioral of shizhong is
signal tt :std_logic_vector(3 downto 0);
begin

process(clk,rst)
begin
if rst='1' then
t<="0000";
tt<="0001";
elsif clk='1' and clk'event then
t<=tt;
if tt="0001" then tt<="0010";
elsif tt="0010" then tt<="0100";
elsif tt="0100" then tt<="1000";
elsif tt="1000" then tt<="0001";
end if;
end if;
end process;
end Behavioral;

