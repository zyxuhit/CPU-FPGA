----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    03:43:36 11/10/2012 
-- Design Name: 
-- Module Name:    huixie - Behavioral 
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

entity huixie is
    Port ( rst : in  STD_LOGIC;
           t3 : in  STD_LOGIC;
           cyin : in  STD_LOGIC;
           rtmp : in  STD_LOGIC_VECTOR (15 downto 0);
           aluout : in  STD_LOGIC_VECTOR (7 downto 0);
           addr : in  STD_LOGIC_VECTOR (15 downto 0);
           ir : in  STD_LOGIC_VECTOR (15 downto 0);
           cyout : out  STD_LOGIC;
           rupdate : out  STD_LOGIC;
           pcupdate : out  STD_LOGIC;
			  raddr:out STD_LOGIC_VECTOR (2 downto 0);
           rdata : out  STD_LOGIC_VECTOR (15 downto 0);
           pcnew : out  STD_LOGIC_VECTOR (15 downto 0);
           cupdate : out  STD_LOGIC);
end huixie;

architecture Behavioral of huixie is

begin

	process(rst,t3,cyin,rtmp,aluout,addr,ir)
		begin
			if t3='1' then
				case ir(15 downto 11) is
					when "00000"|"00100" =>rdata(15 downto 8)<="00000000";
										rdata(7 downto 0)<=aluout;				--不需要取数的
										rupdate<='1';
										raddr<=ir(10 downto 8);
										
					when "00010"|"00110"|"01000" =>rdata<=rtmp;  --需要取数的那几个
										rupdate<='1';
										raddr<=ir(10 downto 8);
										
					when "01100"|"01110"|"10000"|"10010" =>rdata(15 downto 8)<="00000000";
										rdata(7 downto 0)<=aluout;--这些是加减运算
										rupdate<='1';
										raddr<=ir(10 downto 8);
										cyout<=cyin;
										cupdate<='1';
										
					when "10100"|"10110"|"11000"|"11010" =>rdata(15 downto 8)<="00000000";
										rdata(7 downto 0)<=aluout;--这些是逻辑运算
										rupdate<='1';
										raddr<=ir(10 downto 8);
										
					when "11100"=>cyout<='0';--清进位标志为0
									  cupdate<='1';
										
					when "11110"=>cyout<='1';--清进位标志为1
									  cupdate<='1';
									  
					when "00001"|"00011"|"00101"=>pcnew<=addr;--跳转
															pcupdate<='1';
					
					when others =>rupdate<='0';
										pcupdate<='0';
										cupdate<='0';
				end case;
			else
				rupdate<='0';
				pcupdate<='0';
				cupdate<='0';
			end if;
		end process;
end Behavioral;

