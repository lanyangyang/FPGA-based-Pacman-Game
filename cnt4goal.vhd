----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Liu Ziyang
-- 
-- Create Date: 2022/03/20 15:56:20
-- Design Name: counnt for game score
-- Module Name: cnt4goal - Behavioral
-- Project Name: CE339-Assignment 2
-- Target Devices: Basys3
-- Tool Versions: Vivado 2020
-- Description: Receive game count clock and count score. Then output score to four digits 7-segment display
--              Include 4 count-10 counter.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity cnt4goal is
  Port (    clk : in std_logic;         -- game score count clk
            rst : in std_logic;         -- reset
            map_sw : out std_logic;       -- map switch signal
            dout0,dout1,dout2,dout3 : out std_logic_vector(3 downto 0)  -- game score
  );
end cnt4goal;

architecture Behavioral of cnt4goal is
    signal ct,ct1,ct2,ct3: std_logic_vector(3 downto 0):="0000"; -- score
    signal ca : std_logic:='0';
begin
    dout0 <= ct;
    dout1 <= ct1;
    dout2 <= ct2;
    dout3 <= ct3;
    map_sw <= ca;
    cnt0:process(clk,rst)       -- LSB digit
    begin
        if(rst='0')then     -- reset
            if(rising_edge(clk))then
                ct <= ct+1;
                if(ct=9)then        -- count to 10
                    ct <="0000";
                end if;
            end if;
       else
            ct <="0000";
       end if;
   end process;
   cnt1: process(rst,clk,ct)        -- second digit
   begin
        if(rst='0')then
            if(rising_edge(clk))then
                if(ct=9)then
                    ct1 <= ct1+1;
                    if(ct1=9)then       -- count to 10
                        ct1<="0000";
                    end if;
                end if;
            end if;
        else
            ct1 <="0000";
        end if;
    end process;
   cnt2: process(rst,clk,ct1)       -- third digit
   begin
        if(rst='0')then
            if(rising_edge(clk))then
                if(ct1=9 and ct=9)then
                    ct2 <= ct2+1;
                    if(ct2=9)then       -- count to 10
                        ct2 <="0000";
                    end if;
                end if;
            end if;
        else
            ct2 <="0000";
        end if;
    end process;
   cnt3: process(clk,ct2)       -- MSB digit
   begin
        if(rst='0')then
            if(rising_edge(clk))then
                if(ct2=9 and ct1=9 and ct=9)then
                    ct3 <= ct3+1;
                    if(ct3=9)then       -- count to 10
                        ct3<="0000";
                    end if;
                end if;
            end if;
        else
            ct3 <="0000";
        end if;       
    end process;
    map_switch:process(rst,ct,ct1,ct2)  -- switch map
    begin
        if(rst='0')then
            if(ct=0 and ct1=3 and ct2=3)then    -- if eat all dots, change map
                ca <='1';
            end if;
        else
            ca <='0';
        end if;
    end process;
end Behavioral;
