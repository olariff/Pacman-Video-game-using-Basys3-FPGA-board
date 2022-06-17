
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library UNISIM;
use UNISIM.VComponents.all;

-- declare constants used in the generic port and declare the necessary ports to be used within this module
entity draw_shapes is
    generic(vpos : natural;
            hposmax : natural;
            hposmin : natural;
            startpos : natural;
            COLOUR : std_logic_vector(11 downto 0));
    port (X, Y: in unsigned (10 downto 0);
    RGB: out std_logic_vector (11 downto 0);
    clk : in std_logic;
    clk_60hz : in std_logic;
    reset : in std_logic;
    MASK : out std_logic);
end draw_shapes;

architecture Behavioral of draw_shapes is
    
    signal hpos  : integer := startpos; -- starting position of the square
    signal FLAG : std_logic;
      
begin
    -- begin process with a 25Mhz clock to draw and display the square shape
    draw : process(clk,X,Y)
    begin
        -- assign the output mask to the flag for the display of the shape
        MASK <= FLAG; 
        if rising_edge(clk) then
            
            -- the x and y ranges within which the square is drawn. A dimension of 50x50 is declared
            if((X >= hpos) and (X < hpos+50) and (Y >= vpos) and (Y < vpos+50)) then
                FLAG <= '1';
                RGB <= COLOUR;
                                      
            else
                FLAG <= '0';    
                RGB <= (OTHERS => '0');
                
            end if;           
        end if;    
    end process;         
    
    -- begin process with a 60hz clock to enable the movement of the square to be seen
    movement : process(clk_60hz)
    variable check : std_logic;
    begin
        if rising_edge(clk_60hz) then
            
            -- hposmax and hposmin are the boundaries within which 
            -- the shape is allowed to move
            if hpos = hposmax then
                check := '1';
            elsif hpos = hposmin then
                check := '0';
            end if;        
            
            if check = '1' then
                -- decrease the x ranges by 1, maintaining its width of 50
                hpos <= hpos - 1;       
            else
                -- increase the x ranges by 1, maintaining its width of 50
                hpos <= hpos + 1; 
            end if;    
        end if;                        
        
    end process;
    
end Behavioral;
