----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:53:37 11/09/2012 
-- Design Name: 
-- Module Name:    yunsuan - Behavioral 
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

entity yunsuan is
    Port ( clk : in  STD_LOGIC;
           t1: in  STD_LOGIC;
			  rst:in std_logic;
           rupdate : in  STD_LOGIC;
			  cupdate : in  STD_LOGIC;
           cyin : in  STD_LOGIC;
			  pc : in STD_LOGIC_VECTOR (15 downto 0);
           ir : in  STD_LOGIC_VECTOR (15 downto 0);
           raddr : in  STD_LOGIC_VECTOR (2 downto 0);
           rdata : in  STD_LOGIC_VECTOR (15 downto 0);
           addr : out  STD_LOGIC_VECTOR (15 downto 0);
           aluout : out  STD_LOGIC_VECTOR (7 downto 0);
			  z :out std_logic;
			  rupdis : out std_logic;
			  r5 : out STD_LOGIC_VECTOR (7 downto 0);
			  cy : out STD_LOGIC;
           cyout : out  STD_LOGIC);
end yunsuan;

architecture Behavioral of yunsuan is

type reg is array(0 to 7)of std_logic_vector(7 downto 0);--�����˼Ĵ�������
signal r:reg;--����Ĵ���
signal tmp1,tmp2,tmp3:std_logic_vector(7 downto 0);--���ڴ洢IR��Ӧ��λ������Ĵ�����ַ����Ϣ
signal a,b,c,d:std_logic_vector(8 downto 0);--���������߼�����
signal zt,ct:std_logic;

begin
	process(rupdate,clk)
		begin
			if clk='1' and clk'event then
				if rupdate='1' then
					r(conv_integer(raddr))<=rdata(7 downto 0);--�ԼĴ������л�д
				end if;
				
			end if;
	end process;
	process(t1,rst,a,b,c,d,zt,r,ir,pc)
		begin
		if cupdate='1' then
					ct<=cyin;
				end if;
			if rst='1' then
				zt<='0';
				ct<='0';
			elsif t1='1' then
				tmp1<=r(conv_integer(ir(10 downto 8)));
				tmp2<=ir(7 downto 0);
				tmp3<=r(conv_integer(ir(2 downto 0)));
				a<='0'&tmp1;
				b<='0'&tmp2;
				c<='0'&tmp3;--���϶��Ƕ������߼�������׼��
				case ir(15 downto 11)is
					when "00000"=>aluout<=tmp2; --1mov ������Ѱַ
									  addr<="0000000000000000";
					when "00010"=>addr(15 downto 8)<="00000000"; --2mov ����Ѱַ �����ͼĴ���
									  addr(7 downto 0)<=ir(7 downto 0);
									  
					when "00100"=>aluout<=tmp3; --3mov �Ĵ���Ѱַ
					              addr<="0000000000000000";
					
					when "00110"=>addr(15 downto 8)<="00000000";--4mov ��ַ
										addr(7 downto 0)<=ir(7 downto 0)+r(7);
									  
					when "01000"=>addr(15 downto 8)<="00000000";--5mov ���Ѱַ
									  addr(7 downto 0)<=tmp3;
									  
					when "01010"=>addr(15 downto 8)<="00000000";--6mov �Ĵ���������
									  addr(7 downto 0)<=ir(7 downto 0);
									  aluout<=tmp1;
------------------------------------���Ͼ��Ǵ�����ָ��-----------------------------------
					when "01100"=>d<=a+b+ct;--adc ������
										aluout<=d(7 downto 0);
										cyout<=d(8);
										
										if d(8 downto 0)="00000000" then  --�ж��Ƿ�Ϊ0?zt<='1';
										else
											zt<='0';
										end if;
					
					when "01110"=>d<=a+c+ct;--adc �Ĵ���
										aluout<=d(7 downto 0);
										cyout<=d(8);
										
										if d(8 downto 0)="00000000" then  --�ж��Ƿ�Ϊ0����ͬ
											zt<='1';
										else
											zt<='0';
										end if;
										
					when "10000"=>d<=a-b-ct;--sbb ������
										aluout<=d(7 downto 0);
										cyout<=d(8);
										
										if d(8 downto 0)="00000000" then  --�ж��Ƿ�Ϊ0����ͬ
											zt<='1';
										else
											zt<='0';
										end if;
										
					when "10010"=>d<=a-c-ct;--sbb �Ĵ���
										aluout<=d(7 downto 0);
										cyout<=d(8);
										
										if d(8 downto 0)="00000000" then  --�ж��Ƿ�Ϊ0����ͬ
											zt<='1';
										else
											zt<='0';
										end if;
------------------------------------����Ϊ��������---------------------------------------
					when "10100"=>aluout<=tmp1 AND tmp2;  --and ������
										d<='0'&(tmp1 AND tmp2);
									  if d(7 downto 0) ="00000000" then
										zt<='1';
									  else
										zt<='0';
									  end if;
									  
					when "10110"=>aluout<=tmp1 AND tmp3;  --and �Ĵ���
										d<='0'&(tmp1 AND tmp3);
									  if d(7 downto 0) ="00000000" then
										zt<='1';
									  else
										zt<='0';
									  end if;
									  
					when "11000"=>aluout<=tmp1 or tmp2;  --or ������
										d<='0'&(tmp1 or tmp2);
									  if d(7 downto 0) ="00000000" then
										zt<='1';
									  else
										zt<='0';
									  end if;
									  
					when "11010"=>aluout<=tmp1 or tmp3;  --or �Ĵ���
										d<='0'&(tmp1 or tmp3);
									  if d(7 downto 0) ="00000000" then
										zt<='1';
									  else
										zt<='0';
									  end if;
									  
					when "00001"=>addr(15 downto 8)<="00000000"; --JMP
									  addr(7 downto 0)<=ir(7 downto 0);
									  
					when "00011"=> if zt='0' then --JZ
											addr<=pc;
										elsif zt='1' then
											if ir(7)='1' then
												addr<=pc+("11111111"&ir(7 downto 0));
											end if;
											if ir(7)='0' then
												addr<=pc+("00000000"&ir(7 downto 0));
											end if;
										end if;
					when "00101"=> if ct='0' then --JC
											addr<=pc;
										elsif ct='1' then
											if ir(7)='1' then
												addr<=pc+("11111111"&ir(7 downto 0));
											end if;
											if ir(7)='0' then
												addr<=pc+("00000000"&ir(7 downto 0));
											end if;
										end if;
					when others => NULL;
				end case;
			end if;
		end process;
	z<=zt;
	cy<=ct;
	rupdis<=rupdate;
	r5<=r(5)(7 downto 0);
end Behavioral;

