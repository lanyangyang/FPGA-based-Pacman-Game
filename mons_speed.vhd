----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Liu Ziyang
-- 
-- Create Date: 2022/03/29 00:19:24
-- Design Name: mons_speed control
-- Module Name: mons_speed - Behavioral
-- Project Name: CE339-Assignment 2
-- Target Devices: Basys3
-- Tool Versions: Vivado 2020
-- Description: this module's function is to change monster speed by open switch.
-- 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mons_speed is
  Port (    clk: in std_logic;
            sw: in std_logic;
            rst: in std_logic;
            clk_out: out std_logic 
  );
end mons_speed;

architecture Behavioral of mons_speed is
    signal cnt: std_logic_vector(3 downto 0):=(others=>'0');
begin
    switch:process(clk,sw)
    begin
        if(sw='0')then
            if(rising_edge(clk))then            -- cnt-10 counter
                cnt<=cnt+1;
                clk_out<='0';
                    if(cnt=10)then
                        clk_out<='1';               -- output 1Hz clk
                        cnt<="0000";
                    end if;
                end if;
        else
            clk_out <= clk;             -- output 10Hz clk
        end if;
    end process;
                
        
end Behavioral;
