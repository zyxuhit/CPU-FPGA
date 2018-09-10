----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    03:03:25 11/10/2012 
-- Design Name: 
-- Module Name:    cunchu - Behavioral 
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

entity cunchu is
    Port ( rst : in  STD_LOGIC;
           ir : in  STD_LOGIC_VECTOR (15 downto 0);
           nmrd : out  STD_LOGIC;
           nmwr : out  STD_LOGIC;
           t2 : in  STD_LOGIC;
           data : in  STD_LOGIC_VECTOR (15 downto 0);
           rtmp : out  STD_LOGIC_VECTOR (15 downto 0));
end cunchu;

architecture Behavioral of cunchu is

begin

	process(t2,rst,data,ir)
		begin
			if t2='1' then
				case ir(15 downto 11) is
					when "00010"|"00110"|"01000" =>nmrd<='0'; --各种需要访存取数的
										nmwr<='1';
										rtmp<=data;
					when "01010"  =>nmrd<='1';
										nmwr<='0';
					when others =>nmrd <='1';
									  nmwr <='1';
				end case;
			else
				nmrd <='1';
				nmwr <='1';
			end if;
		end process;
end Behavioral;

