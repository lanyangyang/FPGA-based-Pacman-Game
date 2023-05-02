----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Liu Ziyang
-- 
-- Create Date: 2022/02/09 17:51:01
-- Design Name: bcd to 7-segment display decoder (one digit)
-- Module Name: one_digit - Behavioral
-- Project Name: CE339-Assignment 1
-- Target Devices: Basys3
-- Tool Versions: Vivado 2020
-- Description: This module decode bcd input and then display corresponding decimal value
--               on 7-segment one digit display    

----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity one_digit is
  Port (    digit : in STD_LOGIC_VECTOR (3 downto 0);
            sego  : out STD_LOGIC_VECTOR (6 downto 0)
  );
end one_digit;

architecture Behavioral of one_digit is

begin                         -- decode bcd input and get corresponding decimal value then display on 7-segment
            with digit select 
            sego <= "1000000" when "0000",
                    "1111001" when "0001",
                    "0100100" when "0010",
                    "0110000" when "0011",
                    "0011001" when "0100",
                    "0010010" when "0101",
                    "0000010" when "0110",
                    "1111000" when "0111",
                    "0000000" when "1000",
                    "0010000" when "1001",
--                WHEN "1010" => sego <= "0001000";  
--                WHEN "1011" => sego <= "0000011";
--                WHEN "1100" => sego <= "1000110"; 
--                WHEN "1101" => sego <= "0100001"; 
--                WHEN "1110" => sego <= "0000110";  
--                WHEN "1111" => sego <= "0001110";
                    "1000000" when others;

end Behavioral;
