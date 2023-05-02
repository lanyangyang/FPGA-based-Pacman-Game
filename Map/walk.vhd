----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Liu Ziyang
-- 
-- Create Date: 2022/03/19 16:19:02
-- Design Name: walk
-- Module Name: walk - Behavioral
-- Project Name: CE339-Assignment 2
-- Target Devices: Basys3
-- Tool Versions: Vivado 2020
-- Description: Module function is to output player position which is corresponding to the button signal
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity walk is
  Port (    R,L,U,D : in std_logic;                     -- buttons signal
            clk_10hz : in std_logic;                    -- walk clk
            rst : in std_logic;                         -- reset
            mask : in std_logic_vector(299 downto 0);  -- wall memory
            pos : inout integer                         -- player position
  );
end walk;

architecture Behavioral of walk is
    signal br,bl,bu,bd : std_logic;
begin
    mov:process(clk_10hz)
    begin
        if(rst='0')then                             -- reset 
            if(rising_edge(clk_10hz))then            -- player control clock signal        
                if(r='1')then                           
                    if(mask(pos+1)='1')then             --if hit wall, stay still
                        pos <= pos;
                    else
                        pos <= pos+1;                   -- move right one block
                    end if;
                elsif(l='1')then
                    if(mask(pos-1)='1')then
                        pos <= pos;                     --if hit wall, stay still
                    else
                         pos <= pos-1;                  -- move left one block
                    end if;
                elsif(u='1')then 
                    if(mask(pos-20)='1')then            --if hit wall, stay still
                        pos <= pos; 
                    else
                        pos<=pos-20;                    -- move up one block
                    end if;        
                elsif(d='1')then                   
                    if(mask(pos+20)='1')then            --if hit wall, stay still
                        pos <= pos;
                    else
                        pos<=pos+20;                    -- move down one block
                    end if;
                end if;
            end if;
        else
           pos <=50;                -- if reset, initiallize player position          
        end if;
    end process;
end Behavioral;
