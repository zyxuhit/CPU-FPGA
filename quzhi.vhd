----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:41:38 11/09/2012 
-- Design Name: 
-- Module Name:    quzhi - Behavioral 
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

entity quzhi is
port(
		clk:in std_logic;
		rst:in std_logic;
		t0:in std_logic;
		t1:in std_logic;
		pcupdate:in std_logic;
		pcnew:in std_logic_vector(15 downto 0);
		irnew:in std_logic_vector(15 downto 0);
		pcload:out std_logic;
		irout:out std_logic_vector(15 downto 0);
		pcout:out std_logic_vector(15 downto 0));

end quzhi;

architecture Behavioral of quzhi is

signal pc:std_logic_vector(15 downto 0);

begin

process(clk,rst,t0,t1,irnew,pcnew,pcupdate)
	
	begin
		if rst='1' then
			pc<="0000000000000000";
			pcload<='0';
		elsif t0='1' then
			pcload<='1';
			irout<=irnew;
		elsif t1='1' then
			if clk='0' and clk'event then
				pc<=pc+1;
			end if;
			pcload<='0';
		elsif pcupdate='1' then
			pc<=pcnew;
		else
			pcload<='0';
		end if;
end process;
pcout<=pc;
end Behavioral;

