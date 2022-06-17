
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library UNISIM;
use UNISIM.VComponents.all;

-- declare constants to be used within this module in the generic port
--declare the necessary ports to be used within this module
entity margin4 is
    generic(hpos1 : natural;
            hpos2 : natural;
            vpos1 : natural;
            vpos2 : natural;
            COLOUR : std_logic_vector(11 downto 0));
    port (X, Y: in unsigned (10 downto 0);
    RGB: out std_logic_vector (11 downto 0);
    clk : in std_logic;
    reset : in std_logic;
    MASK : out std_logic);
end margin4;

architecture Behavioral of margin4 is
    signal FLAG : std_logic;
    
begin
    -- begin process with a 25Mhz clock to draw and display the wall's rectangular shape
    movement : process(clk,X,Y)
    begin
        -- assign the output mask to the flag for the display of the shape
        MASK <= FLAG;
        if rising_edge(clk) then
        
            -- the x and y ranges (hpos1,hpos2,vpos1,vpos2) within which the rectangle is drawn.
            if((X >= hpos1) and (X < hpos2) and (Y >= vpos1) and (Y < vpos2)) then
                FLAG <= '1';
                RGB <= "111111111111";
                                      
            else
                FLAG <= '0';    
                RGB <= (OTHERS => '0');
                
            end if;           
        end if;    
    end process;

end Behavioral;
