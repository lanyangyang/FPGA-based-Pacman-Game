----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Liu Ziyang
-- 
-- Create Date: 2022/02/09 20:04:51
-- Design Name: bcd to 7-segment decoder on four digits display
-- Module Name: four_digits - Behavioral
-- Project Name: CE339-Assignment 2
-- Target Devices: Basys3
-- Tool Versions: Vivado 2020
-- Description: This module decode 4 bcd inputs and then display corresponding decimal value
--              on 7-segment four digits display in turn by switching anode output.
--              The principle of display is flashing very fast and human cannot see the gap

----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity four_digits is
  Port ( d0: in std_logic_vector (3 downto 0);
         d1: in std_logic_vector (3 downto 0);
         d2: in std_logic_vector (3 downto 0);
         d3: in std_logic_vector (3 downto 0);
         ck: in std_logic;
         seg_out: out std_logic_vector (6 downto 0);
         an_out: out std_logic_vector (3 downto 0)
  );
end four_digits;

architecture Behavioral of four_digits is
    signal cnt4 : std_logic_vector(1 downto 0):="00";
    signal dout: std_logic_vector (3 downto 0);
    component one_digit                                                   -- Reuse one digit which can decode bcd input and get corresponding decimal value
    port(    digit : in std_logic_vector (3 downto 0);
             sego  : out std_logic_vector (6 downto 0)
    );
    end component;
begin
        U0: one_digit port map(
            digit => dout,
            sego => seg_out
        );
    count_position : process(ck)      -- Count position when rising edge of clk
        begin                                                                               
            if(ck'event and ck= '1')then
                cnt4 <= cnt4 + 1;      -- Reset when count at 3 because only 4 digits 
            end if;
        end process;
        
    with cnt4 select
    dout <= d0 when "00",          -- date mux                               
            d1 when "01",                                                  
            d2 when "10",
            d3 when "11",
            "0000" when others;
        
    with cnt4 select                 -- Display decimal value corresponding to position
    an_out <= "1110" when "00",
              "1101" when "01",
              "1011" when "10",
              "0111" when "11",
              "0000" when others;
end Behavioral;
