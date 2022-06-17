
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library UNISIM;
use UNISIM.VComponents.all;

-- declare the necessary ports to be used within this module
entity shapes is
    port (X, Y: in unsigned (10 downto 0);
    RGB: out std_logic_vector (11 downto 0);
    clk : in std_logic;
    btnR : in std_logic;
    btnL : in std_logic;
    btnU : in std_logic;
    btnD : in std_logic;
    reset : in std_logic;
    MASK : out std_logic);
end shapes;

architecture Behavioral of shapes is
    
    -- RGB signals assigned to the port mapped RGB values of the various shapes
    signal RGB1 : std_logic_vector (11 downto 0);
    signal RGB2 : std_logic_vector (11 downto 0);
    signal RGB3 : std_logic_vector (11 downto 0);
    signal RGB4 : std_logic_vector (11 downto 0);
    signal RGB5 : std_logic_vector (11 downto 0);
    signal RGB6 : std_logic_vector (11 downto 0);
    signal RGB7 : std_logic_vector (11 downto 0);
    signal RGB8 : std_logic_vector (11 downto 0);
    signal RGB9 : std_logic_vector (11 downto 0);
    signal RGB10 : std_logic_vector (11 downto 0);
    signal RGB11 : std_logic_vector (11 downto 0);
    signal RGB12 : std_logic_vector (11 downto 0);
    signal RGB13 : std_logic_vector (11 downto 0);
    
    -- Mask signals assigned to the port mapped Mask values of the various shapes
    signal MASK1 : std_logic;
    signal MASK2 : std_logic;
    signal MASK3 : std_logic;
    signal MASK4 : std_logic;
    signal MASK5 : std_logic;
    signal MASK6 : std_logic;
    signal MASK7 : std_logic;
    signal MASK8 : std_logic;
    signal MASK9 : std_logic;
    signal MASK10 : std_logic;
    signal MASK11 : std_logic;
    signal MASK12 : std_logic;
    signal MASK13 : std_logic;
    
    -- signals declared to know when the pacman comes in contact(collects) with the pac-dots
    signal enablefood1 : std_logic := '0';
    signal enablefood2 : std_logic := '0';
    signal enablefood3 : std_logic := '0';
    
    -- 60hz clock signal
    signal clk_60hz : std_logic;
    
begin   

-- multiplex through the RGB values of each shape and assign it to the main output RGB port
-- the mask is used as a constraint to achieve this
-- For the pac-dots', another constraint enablefood is added to detect when the pac-dots are visible
RGB <= RGB1 when mask1 = '1' else
       RGB2 when mask2 = '1' else
       RGB3 when mask3 = '1' else
       RGB13 when mask13 = '1' else
       RGB4 when mask4 = '1' else
       RGB5 when mask5 = '1' else
       RGB6 when mask6 = '1' else
       RGB7 when mask7 = '1' else
       RGB8 when mask8 = '1' else
       RGB9 when mask9 = '1' else
       RGB10 when (mask10 = '1' and enablefood1 = '0') else
       RGB11 when (mask11 = '1' and enablefood2 = '0') else
       RGB12 when (mask12 = '1' and enablefood3 = '0') else
       (others => '0'); 


-- port map the 60Hz clock, pac-dots modules(food), enemies modules(rectangle), walls module(margin)
-- and pacman module (pacman_circle)
clock_60hz_portmap : entity work.clock_60hz(Behavioral)
            Port map (clk => clk, clk_out => clk_60hz);

draw_rectangle0 : entity work.draw_shapes(Behavioral)
            generic map(vpos => 50, hposmax => 640-50, hposmin => 0, startpos => 0, COLOUR => "000011110000")
            Port map (X => X, Y => Y, RGB => RGB1, MASK => MASK1, clk => clk, reset => reset, clk_60hz => clk_60hz); 
            
draw_rectangle1 : entity work.rectangle1(Behavioral)
            generic map(hpos => 20, vposmax => 480-50, vposmin => 0, startpos => 0, COLOUR => "111100000000")
            Port map (X => X, Y => Y, RGB => RGB2, MASK => MASK2, clk => clk, reset => reset, clk_60hz => clk_60hz);
            
draw_rectangle2 : entity work.draw_shapes(Behavioral)
            generic map(vpos => 420, hposmax => 640-50, hposmin => 0, startpos => 640-50, COLOUR => "111111110000")
            Port map (X => X, Y => Y, RGB => RGB13, MASK => MASK13, clk => clk, reset => reset, clk_60hz => clk_60hz);            
            
draw_rectangle3 : entity work.rectangle3(Behavioral)
            generic map(hpos => 580, vposmax => 480-50, vposmin => 0, startpos => 480-50, COLOUR => "111100000000")
            Port map (X => X, Y => Y, RGB => RGB3, MASK => MASK3, clk => clk, reset => reset, clk_60hz => clk_60hz);            
            
draw_pacman : entity work.pacman_circle(Behavioral)
            generic map(R => 25, COLOUR => "111100001111")
            Port map (X => X, Y => Y, RGB => RGB4, MASK => MASK4, clk => clk, clk_60hz => clk_60hz,
             btnR => btnR, btnL => btnL, btnU => btnU, btnD => btnD, enablefood1 => enablefood1,enablefood2 => enablefood2,
             enablefood3 => enablefood3);                        

margin1_unit : entity work.margin1(Behavioral)
            generic map(hpos1 => 150, hpos2 => 160, vpos1 => 100, vpos2 => 300, COLOUR => "111111111111")
            Port map (X => X, Y => Y, RGB => RGB5, MASK => MASK5, clk => clk, reset => reset);

margin2_unit : entity work.margin2(Behavioral)
            generic map(hpos1 => 150, hpos2 => 300, vpos1 => 100, vpos2 => 110, COLOUR => "111111111111")
            Port map (X => X, Y => Y, RGB => RGB6, MASK => MASK6, clk => clk, reset => reset);
            
margin3_unit : entity work.margin3(Behavioral)
            generic map(hpos1 => 300, hpos2 => 310, vpos1 => 100, vpos2 => 300, COLOUR => "111111111111")
            Port map (X => X, Y => Y, RGB => RGB7, MASK => MASK7, clk => clk, reset => reset);
            
margin4_unit : entity work.margin4(Behavioral)
            generic map(hpos1 => 300, hpos2 => 450, vpos1 => 300, vpos2 => 310, COLOUR => "111111111111")
            Port map (X => X, Y => Y, RGB => RGB8, MASK => MASK8, clk => clk, reset => reset);
            
margin5_unit : entity work.margin5(Behavioral)
            generic map(hpos1 => 450, hpos2 => 460, vpos1 => 100, vpos2 => 310, COLOUR => "111111111111")
            Port map (X => X, Y => Y, RGB => RGB9, MASK => MASK9, clk => clk, reset => reset);
            
food1 : entity work.food1(Behavioral)
            generic map(CX => 150, CY => 400, R => 4, COLOUR => "111111111111")
            Port map (X => X, Y => Y, RGB => RGB10, MASK => MASK10, clk => clk);
            
food2 : entity work.food2(Behavioral)
            generic map(CX => 600, CY => 200, R => 4, COLOUR => "111111111111")
            Port map (X => X, Y => Y, RGB => RGB11, MASK => MASK11, clk => clk); 
            
food3 : entity work.food3(Behavioral)
            generic map(CX => 350, CY => 100, R => 4, COLOUR => "111111111111")
            Port map (X => X, Y => Y, RGB => RGB12, MASK => MASK12, clk => clk);                                                 
            
end Behavioral;