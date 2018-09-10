----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    04:46:45 11/10/2012 
-- Design Name: 
-- Module Name:    fangkong - Behavioral 
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

entity fangkong is
    Port ( pcload : in  STD_LOGIC;
           pc : in  STD_LOGIC_VECTOR (15 downto 0);
           nmrd : in  STD_LOGIC;
           nmwr : in  STD_LOGIC;
           addr : in  STD_LOGIC_VECTOR (15 downto 0);
           aluout : in  STD_LOGIC_VECTOR (7 downto 0);
           data : out  STD_LOGIC_VECTOR (15 downto 0);
           abus : out  STD_LOGIC_VECTOR (15 downto 0);
           dbus : inout  STD_LOGIC_VECTOR (15 downto 0);
           nwr : out  STD_LOGIC;
           nrd : out  STD_LOGIC;
           nble : out  STD_LOGIC;
           nbhe : out  STD_LOGIC;
           nmreq : out  STD_LOGIC;
           irnew : out  STD_LOGIC_VECTOR (15 downto 0));
end fangkong;

architecture Behavioral of fangkong is

begin
	process(nmrd,pcload)
		begin
			if pcload='1' then
				nrd<='0';
			else
				nrd<=nmrd;
			end if;
	end process;
	nwr<=nmwr;
	nmreq<='0' when nmrd='0' or nmwr='0' or pcload='1' else '1';
	nble<='0' when nmrd='0' or nmwr='0' or pcload='1' else '1';
	nbhe<='0' when nmrd='0' or nmwr='0' or pcload='1' else '1';
	abus<=pc when pcload='1' else addr;
	dbus<="00000000"&aluout when nmwr='0' else "ZZZZZZZZZZZZZZZZ";
	irnew<=dbus when pcload='1';
	data <=dbus when nmrd='0';
end Behavioral;

