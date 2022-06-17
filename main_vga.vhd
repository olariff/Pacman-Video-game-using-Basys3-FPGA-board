library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library UNISIM;
use UNISIM.VComponents.all;

-- declare the necessary ports to be used within this module
-- in line with the names used in the constraint file
entity main_vga is
    Port ( btnC : in STD_LOGIC;
            HS  : out std_logic;
            VS  : out std_logic;
            RGB: out std_logic_vector (11 downto 0);
            btnR : in std_logic;
            btnL : in std_logic;
            btnU : in std_logic;
            btnD : in std_logic;
            clk : in STD_LOGIC);
end main_vga;

architecture Behavioral of main_vga is

    -- declare the ports of the clocking wizard
    component clk_wiz_0
    port
     (-- Clock in ports
      -- Clock out ports
      clk_out1          : out    std_logic;
--      clk_out2          : out    std_logic;
--      clk_out3          : out    std_logic;
      -- Status and control signals
      reset             : in     std_logic;
      locked            : out    std_logic;
      clk_in1           : in     std_logic
     );
    end component;
            
    signal MASK : std_logic;
    signal hcount : unsigned(10 downto 0);
    signal vcount : unsigned(10 downto 0);
    signal blank : std_logic;
    signal reset : std_logic := '0';
    signal locked : std_logic;
    signal clk_25mhz : std_logic;
--    signal clk_50mhz : std_logic;
--    signal clk_8mhz : std_logic; 
    
begin

-- instantiate the clocking wizard
clk_wiz_0_inst : clk_wiz_0
   port map ( 
  -- Clock out ports  
   clk_out1 => clk_25mhz,
--   clk_out2 => clk_8mhz,
--   clk_out3 => clk_50mhz,
  -- Status and control signals                
   reset => reset,
   locked => locked,
   -- Clock in ports
   clk_in1 => clk
 );           

-- port map the vga controller unit and the shapes unit
vga_controller_unit : entity work.vga_controller_640_60(Behavioral)
            Port map (pixel_clk => clk_25mhz, rst => reset, HS => HS, VS => VS, hcount => hcount, vcount => vcount, blank => blank); 
            
shapes_unit : entity work.shapes(Behavioral)
            Port map (X => hcount, Y => vcount, RGB => RGB, MASK => MASK, clk => clk_25mhz, reset => reset, btnR => btnR, btnL => btnL, btnU => btnU, btnD => btnD);            

end Behavioral;
