----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Liu Ziyang
-- 
-- Create Date: 2022/02/13 10:41:41
-- Design Name: Counter (any number)
-- Module Name: Counter - Behavioral
-- Project Name: CE339-Assignment 2
-- Target Devices: Basys3
-- Tool Versions: Vivado 2020
-- Description: This counter can count any number by change b in the generic map.
--              it has en, clear port which used to drive or reset the counter.
--              Also, it has carry bit output.

----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Counter is
  Generic (b : integer );
  Port (    CountClk : in std_logic; 
	        clear : in std_logic;
	        count : out integer;
	        carry : out std_logic
	);
end Counter;

architecture Behavioral of Counter is
    signal countpass : integer:= 0; 
    signal carrypass : std_logic:='0';
begin   
    process(CountClk,clear) 
        begin          
            if (clear = '1')then                            -- when clear receives high voltage, counter will reset immediately
                countpass <= 0;
                carrypass <= '0';
            else                               -- counter will function only when en receives low voltage
                if (CountClk'EVENT and CountClk='1')then    -- trigger by rising edge of clk
                    countpass <= countpass+1;
                    carrypass <= '0';
                    if (countpass >= (b-1))then
                        countpass <= 0;	
                        carrypass <= '1';                    -- carry bit outputs '1' when count to max value
                    end if;
                end if;
            end if;
	end process;
	carry <= carrypass;
	count <= countpass;

end Behavioral;
