----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Liu Ziyang
-- 
-- Create Date: 2022/03/09 15:32:12
-- Design Name:  load and plot
-- Module Name: load_plot- Behavioral
-- Project Name: CE339-Assignment 2
-- Target Devices: Basys3
-- Tool Versions: Vivado 2020
-- Description: This module is load wall matrix, pac-dots matrix, monster position, player position. 
--              Then plot every blocks according to states with different color.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity load_plot is  
  Port (    block_pos : in integer;             -- load blocks 
            mons_clk : in std_logic;             -- monster clk
            blank : in std_logic;               -- blank signal
            C : in std_logic;                   -- reset
            wall : in std_logic_vector(299 downto 0);   -- load wall matrix
            ht : in integer;                -- hcount
            vt : in integer;                -- vcount
            pos : in integer;               -- player position
            game : out std_logic;           -- game score count clk
            RGB : out std_logic_vector(11 downto 0):="000000000000";    --RGB output
            MASK: out std_logic_vector(299 downto 0)    -- block state output
   );
end load_plot;

architecture Behavioral of load_plot is
    signal points : std_logic_vector(299 downto 0) :=(others=>'0'); -- pac-dots point matrix
    signal over : std_logic:='0';           -- game over signal
    signal mons : integer:=105;             -- monster start position 
    signal state : std_logic_vector(1 downto 0):="00";   -- state signal
    signal game_cnt : std_logic:='0';   -- game score count clk

begin
    mask <= wall;
    game <= game_cnt;
    
    mov:process(mons_clk,C,mons)                -- monster control
    variable mm : integer:=1;
    begin               
        if(C='0')then           -- reset
            if(rising_edge(mons_clk))then      -- move horizontally                                        
                mons <= mons + mm;
                if(wall(mons-2)='1')then        -- if hit wall, turn around
                    mm := 1;
                elsif(wall(mons+2)='1')then     -- if hit wall, turn around
                    mm := -1;
                elsif(mons+1=pos or mons-1=pos or mons-20=pos or mons+20=pos)then
                    over <='1';             -- if hit player, game over
                end if;
            end if;                              
        else
            over <= '0';        -- reset
        end if; 
    end process;
    
    play:process(block_pos,pos,C)       -- player eat dots
    begin
         if(pos>=0 and pos<=299)then            -- scan 300 blocks
            if(C='0')then           -- reset
                if(block_pos=pos and points(pos)='0')then   
                    points(pos)<='1';       -- if player eat a dots, remove this dots
                    game_cnt <= '1';        -- score clk becomes high 
                else
                    game_cnt <= '0';
                end if;
            else
                points <=(others=>'0');     -- reset
            end if;
         end if;
    end process;
    
    plot:process(block_pos,C,over)
    begin      
            if(C='0')then       -- reset
                if(over='0')then    -- when not game over
                    if(block_pos>=0 and block_pos<=299)then     -- read blocks state
                        state(0) <= wall(block_pos);                    
                        state(1) <= points(block_pos);
                    else
                        state <= "11";      -- game over
                    end if; 
            else
                state <= "00";      -- reset
            end if;
        end if;                      
    end process;
    
    color:process(state,blank,block_pos,pos,mons,over)
    begin                 
            if(blank='0')then               -- when not blank
                if(over='0')then            -- when not game over
                     if(state(0)='1')then       -- if block state is wall, plot wall
                        RGB <= "000000001111";  -- green
                     else
                        if(block_pos=mons)then          -- if block state is monster, plot monster
                            RGB <= "111100000000";      -- red rectangle
                        elsif(state(1)='0')then         -- if block state is dots, plot
                            if(ht*ht+vt*vt<64)then
                                RGB <= "000010101010";      -- blue circle
                            else
                                RGB <= "000000000000";
                            end if;
                        elsif(block_pos=pos)then        -- if block state is player, plot player
                            if(ht*ht+vt*vt<256)then     
                                RGB <= "111111111111";      -- white circle
                            else
                                RGB <= "000000000000";
                            end if;                                            
                        else
                            RGB <= "000000000000";      -- when in nothing state, plot black 
                        end if;
                    end if; 
                else
                    RGB <= "111111110000";   -- when game over, plot whole screen purple
                end if;             
            else
                RGB <= "000000000000";    --when blank, plot black
        end if;
    end process;
   
end Behavioral;
