----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    05:10:48 11/10/2012 
-- Design Name: 
-- Module Name:    ilovecpu - Behavioral 
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

entity ilovecpu is
port(
		z,cy,t0dis,t1dis,t2dis,t3dis:out std_logic;
		rst:in std_logic;
		abus,irdis,abusdis,dbusdis :out std_logic_vector(15 downto 0);
		clk:in std_logic;
		dbus:inout std_logic_vector(15 downto 0);
		nrd,nwr,nble,nbhe,nmreq:out std_logic;
		reg5,rdata:out std_logic_vector(7 downto 0);
		nrddis,nwrdis,nbledis,nbhedis,nmreqdis:out std_logic;
		rupdate,cupdate:out std_logic);
end ilovecpu;

architecture Behavioral of ilovecpu is

component shizhong is
port(
		clk:in std_logic;
		rst:in std_logic;
		t:out std_logic_vector(3 downto 0));
end component;

component quzhi is
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
end component;

component yunsuan is
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
end component;

component cunchu is
	Port ( rst : in  STD_LOGIC;
           ir : in  STD_LOGIC_VECTOR (15 downto 0);
           nmrd : out  STD_LOGIC;
           nmwr : out  STD_LOGIC;
           t2 : in  STD_LOGIC;
           data : in  STD_LOGIC_VECTOR (15 downto 0);
           rtmp : out  STD_LOGIC_VECTOR (15 downto 0));
end component;

component huixie is
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
end component;

component fangkong is			
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
end component;

signal aluouts:STD_LOGIC_VECTOR (7 downto 0);
signal raddrs:STD_LOGIC_VECTOR (2 downto 0);
signal pcnews,irnews,irs,pcs,rdatas,addrs,datas,rtmps,abuss:STD_LOGIC_VECTOR (15 downto 0);
signal pcupdates,t0s,t1s,t2s,t3s,pcloads,rupdates,cupdates,cynews,rds,wrs,cyouts,nwrs,nrds,nbles,nbhes,nmreqs:std_logic;
begin
u1 : shizhong port map(
							clk=>clk,
							t(0)=>t0s,
							t(1)=>t1s,
							t(2)=>t2s,
							t(3)=>t3s,
							rst=>rst);
u2:quzhi port map(		
						clk=>clk,
						rst=>rst,
						t0=>t0s,
						t1=>t1s,
						pcupdate=>pcupdates,
						pcnew=>pcnews,
						irnew=>irnews,
						pcload=>pcloads,
						irout=>irs,
						pcout=>pcs);
u3:yunsuan port map(
							clk=>clk,
							t1=>t1s,
							rst=>rst,
							rupdate=>rupdates,
							cupdate=>cupdates,
							cyin=>cynews,
							pc=>pcs,
							ir=>irs,
							raddr=>raddrs,
							rdata=>rdatas,
							addr=>addrs,
							aluout=>aluouts,
							z=>z,
							rupdis=>rupdate,
							r5=>reg5,
							cy=>cy,
							cyout=>cyouts);
u4:cunchu port map(
							rst=>rst,
							t2=>t2s,
							ir=>irs,
							nmrd=>rds,
							nmwr=>wrs,
							data=>datas,
							rtmp=>rtmps);
u5:huixie port map(
							rst=>rst,
							t3=>t3s,
							ir=>irs,
							cyin=>cyouts,
							rtmp=>rtmps,
							aluout=>aluouts,
							addr=>addrs,
							cyout=>cynews,
							rupdate=>rupdates,
							pcupdate=>pcupdates,
							rdata=>rdatas,
							pcnew=>pcnews,
							raddr=>raddrs,
							cupdate=>cupdates);
u6:fangkong port map(
							pcload=>pcloads,
							pc=>pcs,
							nmrd=>rds,
							nmwr=>wrs,
							addr=>addrs,
							aluout=>aluouts,
							data=>datas,
							abus=>abuss,
							dbus=>dbus,
							nwr=>nwrs,
							nrd=>nrds,
							nble=>nbles,
							nbhe=>nbhes,
							nmreq=>nmreqs,
							irnew=>irnews);
							
rdata<=rdatas(7 downto 0);
irdis<=irnews;
t0dis<=t0s;
t1dis<=t1s;
t2dis<=t2s;
t3dis<=t3s;
abus<=abuss;
abusdis<=abuss;
dbusdis<=dbus;
nwr<=nwrs;
nwrdis<=nwrs;
nrd<=nrds;
nrddis<=nrds;
nble<=nbles;
nbledis<=nbles;
nbhe<=nbhes;
nbhedis<=nbhes;
nmreq<=nmreqs;
nmreqdis<=nmreqs;
cupdate<=cupdates;

end Behavioral;