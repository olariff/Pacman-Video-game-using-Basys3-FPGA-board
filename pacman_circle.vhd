
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library UNISIM;
use UNISIM.VComponents.all;

-- declare constants used in the generic port and declare the necessary ports to be used within this module
entity pacman_circle is
    generic (
--    CX : natural;
--    CY : natural;
    R : natural;
    COLOUR : std_logic_vector(11 downto 0));
    
    port (
    clk : in std_logic;
    clk_60hz : in std_logic;
    btnR : in std_logic;
    btnL : in std_logic;
    btnU : in std_logic;
    btnD : in std_logic;
    X, Y: in unsigned (10 downto 0);
    RGB : out std_logic_vector(11 downto 0);
    enablefood1 : out std_logic := '0';
    enablefood2 : out std_logic := '0';
    enablefood3 : out std_logic := '0';
    MASK : out std_logic );

end pacman_circle;

architecture Behavioral of pacman_circle is
    signal CX  : integer := 120;
    signal CY  : integer := 120;
    
    signal CX1  : integer := 150;
    signal CY1  : integer := 400;
    
    signal CX2  : integer := 600;
    signal CY2  : integer := 200;
    
    signal CX3  : integer := 350;
    signal CY3  : integer := 100;

    signal DX, DY : unsigned (X'range);
    signal DX2, DY2 : unsigned ((2*X'high+1) downto 0);
    signal FLAG : std_logic;
    constant R2 : unsigned(DX2'range) := to_unsigned(R * R, DX2'length);
    
begin

food1 : entity work.food1(Behavioral)
            generic map(CX => 150, CY => 400, R => 4, COLOUR => "111111111111")
            Port map (X => X, Y => Y, clk => clk );    

food2 : entity work.food2(Behavioral)
            generic map(CX => 600, CY => 200, R => 4, COLOUR => "111111111111")
            Port map (X => X, Y => Y, clk => clk); 
            
food3 : entity work.food3(Behavioral)
            generic map(CX => 350, CY => 100, R => 4, COLOUR => "111111111111")
            Port map (X => X, Y => Y, clk => clk);
    
    -- these food process assigns enable food to '1' when it comes in contact with the Pacman
    food1_inside_pacman : process
    begin
    wait until rising_edge(clk);
        
        if CX > CX1-22 and CX < CX1+22 and CY > CY1-22 and CY < CY1+22 then
            enablefood1 <= '1';        
        end if;
            
    end process;    
    
    food2_inside_pacman : process
    begin
    wait until rising_edge(clk);
        
        if CX > CX2-22 and CX < CX2+22 and CY > CY2-22 and CY < CY2+22 then
            enablefood2 <= '1';        
        end if;
            
    end process;
    
    food3_inside_pacman : process
    begin
    wait until rising_edge(clk);
        
        if CX > CX3-22 and CX < CX3+22 and CY > CY3-22 and CY < CY3+22 then
            enablefood3 <= '1';        
        end if;
            
    end process;
    
--    reappearance_of_food : process
--    begin
--    wait until rising_edge(clk);
        
--        if enablefood1='1' and enablefood2='1' and enablefood3='1' then
--            enablefood1 <= '0';
--            enablefood2 <= '0';
--            enablefood3 <= '0';        
--        end if;
            
--    end process;
    
    -- begin process with a 25Mhz clock to draw and display the Pacman circle shape
    draw_pacman_circle : process
    begin
    
    -- assign the output mask to the flag for the display of the shape
    MASK <= FLAG;
    wait until rising_edge(clk);
    
        if X > CX then
            DX <= X - CX;
        else
            DX <= CX - X;
        end if;
        DX2 <= DX * DX;
        
        if Y > CY then
            DY <= Y - CY;
        else
            DY <= CY - Y;
        end if;
        DY2 <= DY * DY;
        
        -- the condition within which the circle is drawn
        -- using the formula (X-CX)2 + (Y-CY)2 <= R2
        if (R2 >= DX2 + DY2) then
            FLAG <= '1';
            RGB <= COLOUR;
    
        else
            FLAG <= '0';    
            RGB <= (OTHERS => '0');            
        end if; 
           
    end process;        
    
     -- begin process with a 60hz clock to enable the movement of the Pacman to be controlled    
    pacman_horizontal_movement_control : process(clk_60hz)
        variable check : std_logic;
        begin
            if rising_edge(clk_60hz) then
                if btnL = '1' then
                    if CX > 0+25 then
                    -- commented section is the code to prevent the pacman from
                    -- moving through the inner walls, however its a bit buggy        
--                        if CX > 125 and CX < 185 and CY > 75 and CY < 325 then
--                            CX <= CX;
--                        elsif CX > 275 and CX < 335 and CY > 75 and CY < 325 then
--                            CX <= CX;
--                        elsif CX > 425 and CX < 485 and CY > 75 and CY < 325 then
--                            CX <= CX;
--                        else
                            CX <= CX - 1;    
--                        end if;              
                    end if;    
                elsif btnR = '1' then
                    if CX < 640-25 then
                    -- commented section is the code to prevent the pacman from
                    -- moving through the inner walls, however its a bit buggy
--                        if CX > 125 and CX < 185 and CY > 75 and CY < 325 then
--                            CX <= CX;
--                        elsif CX > 275 and CX < 335 and CY > 75 and CY < 325 then
--                            CX <= CX;
--                        elsif CX > 425 and CX < 485 and CY > 75 and CY < 325 then
--                            CX <= CX;
--                        else
                            CX <= CX + 1;    
--                        end if;
                    end if;    
                end if;    
            end if;
                    
    end process;    
    
    pacman_vertical_movement_control : process(clk_60hz)
        variable check : std_logic;
        begin
            if rising_edge(clk_60hz) then
                if btnD = '1' then
                    if CY < 480-25 then
                        CY <= CY + 1;    
                    end if;
                 
                            
                elsif btnU = '1' then
                    if CY > 0+25 then
                       CY <= CY - 1;    
                    end if;
                end if;
                    
                    
            end if;
                    
    end process;  
    
end Behavioral;
