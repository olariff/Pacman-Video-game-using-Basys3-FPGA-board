
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library UNISIM;
use UNISIM.VComponents.all;

-- declare constants used in the generic port and declare the necessary ports to be used within this module
entity food3 is
    generic (
    CX : natural;
    CY : natural;
    R : natural;
    COLOUR : std_logic_vector(11 downto 0));
    
    port (
    clk : in std_logic;
    X, Y: in unsigned (10 downto 0);
    RGB : out std_logic_vector(11 downto 0);
    MASK : out std_logic );

end food3;

architecture Behavioral of food3 is
--    signal CX  : integer := 120;
--    signal CY  : integer := 120;
--    signal R  : integer := 25;
    signal DX, DY : unsigned (X'range);
    signal DX2, DY2 : unsigned ((2*X'high+1) downto 0);
    signal FLAG : std_logic;
    constant R2 : unsigned(DX2'range) := to_unsigned(R * R, DX2'length);
    
begin
    
    -- begin process with a 25Mhz clock to draw and display the pac-dots circle shape
    draw_pac_dot : process
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

end Behavioral;
