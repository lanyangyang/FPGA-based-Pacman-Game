----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Liu Ziyang
-- 
-- Create Date: 2022/03/09 16:35:54
-- Design Name: top design
-- Module Name: top - Behavioral
-- Project Name: CE339-Assignment 2
-- Target Devices: Basys3
-- Tool Versions: Vivado 2020
-- Description: This is tope design of assignment 2. It connects everything together.
-- 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity main is
  Port (    Hsync, Vsync: OUT STD_LOGIC;      -- Horizontal and vertical sync pulses for VGA
            vgaRed, vgaBlue, vgaGreen: OUT STD_LOGIC_VECTOR(3 downto 0);-- 4-bit colour values output to DAC on Basys 3 board
            CLK: IN STD_LOGIC;                          -- 100 MHz clock
            btnL,btnR,btnU,btnD : in std_logic;         -- buttons signal input
            rst : in std_logic;
            sw: IN std_logic ;                          -- Switches for monster speed input
            seg: OUT STD_LOGIC_VECTOR(6 downto 0);     -- 7-seg cathodes 
            an: OUT STD_LOGIC_VECTOR(3 downto 0)       -- 7-seg anodes      
  );
end main;

architecture Behavioral of main is
-- some preset parameters
signal clk_25m: std_logic:='0'; -- vga clk
signal mons_clk: std_logic:='0';   -- mons_clk
signal goal: std_logic:='0';                -- game clk
signal clk_10: std_logic:='0';  -- button smooth clk
signal clk_1k: std_logic:='0';  -- 7-segment display clk
signal h: unsigned(10 downto 0);    -- hcount
signal v: unsigned(10 downto 0);    -- vcount
signal bk: std_logic;               -- blank signal
signal pacs: std_logic;   
signal locate: integer:=0;          --block locate
signal pos: integer:=50;            -- player position
signal mask : std_logic_vector(299 downto 0);   -- mask
signal wall : std_logic_vector(299 downto 0);   -- wall matrix
signal ht: integer;
signal vt: integer;
signal btL,btR,btU,btD : std_logic;         -- buttons signal
signal dt0,dt1,dt2,dt3 : std_logic_vector(3 downto 0):="0000";  -- score count

begin
    keyR: entity work.button_smooth(Behavioral)port map(
        key => btnR,
        clk_1khz => clk_1k,
        key_out => btR
    );
    keyL: entity work.button_smooth(Behavioral)port map(
        key => btnL,
        clk_1khz => clk_1k,
        key_out => btL
    );
    keyU: entity work.button_smooth(Behavioral)port map(
        key => btnU,
        clk_1khz => clk_1k,
        key_out => btU
    );
    keyD: entity work.button_smooth(Behavioral)port map(
        key => btnD,
        clk_1khz => clk_1k,
        key_out => btD
    );
    vga: entity work.vga_controller_640_60(Behavioral) port map(
        pixel_clk => clk_25m,
        rst => rst,
        HS => Hsync,
        VS => Vsync,
        blank => bk,
        hcount => h,
        vcount => v
    );   
    clk_25MHZ: entity work.counter Generic map(b =>4)
    port map(
        countclk => clk,
        clear => rst,
        carry => clk_25m
    );
    clk_10HZ: entity work.counter Generic map(b =>1e7)
    port map(
        countclk => clk,
        clear => rst,
        carry => clk_10
    );
    clk_1KHZ: entity work.counter Generic map(b =>1e5)
    port map(
        countclk => clk,
        clear => rst,
        carry => clk_1k
    );

    player_move:entity work.walk(Behavioral) port map(
        R => btR,
        L => btL,
        U => btU,
        D => btD,
        clk_10hz => clk_10,
        pos => pos,
        mask => mask,
        rst => rst
    );
    mons_speed_control: entity work.mons_speed(Behavioral) port map(
        clk => clk_10,
        rst => rst,
        clk_out => mons_clk,
        sw => sw
    );
    wall_matrix: entity work.wall(Behavioral) port map(
        sel => pacs,
        load => wall
    );
    load_and_plot: entity work.load_plot(Behavioral) port map(       
        blank => bk,
        mons_clk => mons_clk,
        ht => ht,
        vt => vt,
        C => rst,
--        pacs => pacs,
        wall => wall,
        mask => mask,
        block_pos => locate,
        pos => pos,
        game => goal,
        RGB(11 downto 8) => vgaRed,
        RGB(7 downto 4) => vgaBlue,
        RGB(3 downto 0) => vgaGreen
    );
    display: entity work.four_digits(Behavioral)port map(
        d0 => dt0,
        d1 => dt1,
        d2 => dt2,
        d3 => dt3,
        ck => clk_1k,
        seg_out => seg,
        an_out => an
    );
    score0cnt: entity work.cnt4goal(Behavioral) port map(
        clk => goal,
        rst => rst,
        map_sw => pacs,
        dout0 => dt0,
        dout1 => dt1,
        dout2 => dt2,
        dout3 => dt3
    );
    block_counter: entity work.block_cnt(Behavioral) port map(
        x => h,
        y => v,
        hout => ht,
        vout => vt,
        rst => rst,
        clk => clk_25m,
        locate => locate
    );
end Behavioral;
