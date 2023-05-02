----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Liu Ziyang
-- 
-- Create Date: 2022/02/12 17:47:11
-- Design Name: button smooth
-- Module Name: button_smooth - Behavioral
-- Project Name: CE339-Assignment 2
-- Target Devices: Basys3
-- Tool Versions: Vivado 2020
-- Description: This module is to process button signal to a clean rectangular signal
--              Because there will be a noise signal when the button is pressed and bounced, 
--              which may cause the circuit to operate incorrectly. 

----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity button_smooth is
  Port (    key : in std_logic;
	        clk_1khz : in std_logic;
	        key_out : out std_logic
  );
end button_smooth;

architecture Behavioral of button_smooth is
    signal d1,d2,s : std_logic;
    begin
        smooth : process(clk_1khz)                   -- The basic function of removing noise is using two d-type flip-flop
            begin                                   -- Each rising edge of the clock is to sample the signal once, d1 saves the latest sample, d2 saves the last sample.
		        if (rising_edge(clk_1khz))then    -- The noise signal can only be sampled once, and therefore the value of d1*d2 must be 0.
			         d1 <= key;
			         d2 <= d1;
		        end if;
        end process;
    s <= d1 and d2;
    key_out <= s;
end Behavioral;
