----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Liu Ziyang
-- 
-- Create Date: 2022/03/17 18:16:51
-- Design Name: block counter
-- Module Name: block_cnt - Behavioral
-- Project Name: CE339-Assignment 2
-- Target Devices: Basys3
-- Tool Versions: Vivado 2020
-- Description: This modules is used to generate 300 blocks. It divideds 640*480 to 20*15 blocks. 
--              Each blocks is 32*32. Each block will output to load_plot module for state apply.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity block_cnt is
  Port (    x,y : in unsigned(10 downto 0);
            clk : in std_logic;
            rst : in std_logic;         -- reset
            hout : out integer;         -- hcount
            vout : out integer;         -- vcount
            locate : out integer        -- block location   
  );
end block_cnt;

architecture Behavioral of block_cnt is
    signal h : integer:=0;
    signal v : integer:=0;
    signal xx : integer:=0;
    signal yy : integer:=0;
begin
    xx <= to_integer(x);
    yy <= to_integer(y);
    hout <= xx+16-(h+1)*32;     -- calculate circle radius
    vout <= yy+16-(v+1)*32;     
    count:process(clk)
    begin        
        if(rising_edge(clk))then
            if(rst='0')then
                h <= to_integer(x(10 downto 5));
                v <= to_integer(y(10 downto 5));
                locate <= h + v*20;    -- block location
            else
                h <=0;        -- if reset, initiallize
                v <=0;
                locate <= 0;
            end if;
        end if;
    end process;
    
end Behavioral;
