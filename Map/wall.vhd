----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Liu Ziyang
-- 
-- Create Date: 2022/03/30 23:05:11
-- Design Name: wall map switch
-- Module Name: wall - Behavioral
-- Project Name: CE339-Assignment 2
-- Target Devices: Basys3
-- Tool Versions: Vivado 2020
-- Description: this module is a wall martrix. It will output different game map to plot. It contains two levels. 
--  if all pac-dots are eaten then change to next level.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity wall is
  Port (    sel: in std_logic;                              -- select signal
            load: out std_logic_vector(299 downto 0)        -- output wall matrix
        );
end wall;

architecture Behavioral of wall is
begin
    mux:process(sel)
    begin
        if(sel='0')then                 -- level 1
            load(19 downto 0)<=(others =>'1');
            load(39 downto 20)<="10000000000000000001";  -- 1 means this block has wall, 0 means this block is nothing
            load(59 downto 40)<="10000000000111000001";
            load(79 downto 60)<="10000000000111000001";
            load(99 downto 80)<="10000000000000000001";
            load(119 downto 100)<="10000000000000000001";
            load(139 downto 120)<="10000000011000000001";
            load(159 downto 140)<="10000000111100000001";
            load(179 downto 160)<="10000000011000000001";
            load(199 downto 180)<="11110000000000000001";
            load(219 downto 200)<="10010000000000000001";
            load(239 downto 220)<="10010000000000000001";
            load(259 downto 240)<="10010000000000000001";
            load(279 downto 260)<="10000000000000000001";
            load(299 downto 280)<=(others =>'1');
        else                            -- level 2
            load(19 downto 0)<=(others =>'1');
            load(39 downto 20)<="10000000000000000001";
            load(59 downto 40)<="10000000000000001111";
            load(79 downto 60)<="11110000000000000001";
            load(99 downto 80)<="10000000000000001111";
            load(119 downto 100)<="10000000000000000001";
            load(139 downto 120)<="10000000000000000001";
            load(159 downto 140)<="11110000000000000001";
            load(179 downto 160)<="10000000000000001111";
            load(199 downto 180)<="11110000000000000001";
            load(219 downto 200)<="10000000001110000001";
            load(239 downto 220)<="10000000001110000001";
            load(259 downto 240)<="10000000001110000001";
            load(279 downto 260)<="10000000000000000001";
            load(299 downto 280)<=(others =>'1');
        end if;
    end process;
end Behavioral;
