# FPGA-based-Pacman-Game

## Intro
To deploy this, u need Basys3 FPGA board and a VGA screen. Copy everything to your workspace and open it with Vivado 2020.1.
Enjoy the game
## About Game
In this game, there are monsters, player, pac-dots and walls. User will use 4 buttons to control player eat all dots without caught by the monster. Four digits 7-segment display is used to show the score. There are two game levels in my design. The clearance condition is to eat all the dots.   
The following figure shows these two levels and all the game elements.  

![image](https://user-images.githubusercontent.com/117359375/235606943-8c69d6b3-c5e6-4f47-afb3-cfaa1b1513b1.png)

## Hierarchy design
It has three inputs, clock signal (100MHz), switch signal and buttons signal. It has 5 outputs, HS, VS and RGB for VGA display, Seg and an for 7-segment display. It includes 6 main partsshown as follows,  
* Reset: initialize all parameters if reset switch is on.
* Clock divider: generate different frequency clock signal for each synchronous module.
* VGA controller: generate necessary parameters for VGA display and for calculation blocks.
* Main program: 
    * 1. divider screen to 300 blocks, 
    * 2. user interface (player control), monster moving at different speed, 
    * 3. plot all elements with different RGB color.
    * 4. Map switch if all pac-dots are eaten.
* Score count: count game score.
* Four digits 7-segment display: display game score.  
![image](https://user-images.githubusercontent.com/117359375/235607211-87d19fe4-4cd2-4e36-a811-9ca08e07d01d.png)

