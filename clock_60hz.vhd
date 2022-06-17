----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.02.2022 18:16:57
-- Design Name: 
-- Module Name: freq_div - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


-- This is the code for the Clock divider to multiplex through the segments
--declare the necessary ports
entity clock_60hz is
    Port ( clk : in STD_LOGIC;
    clk_out : out STD_LOGIC
    );
end clock_60hz;

architecture Behavioral of clock_60hz is

-- declare signals for use in clock process
Signal count : INTEGER := 0;
Signal a : STD_LOGIC := '0';

begin
     
     -- Process for the clock divider   
     process(clk)
        begin
        
            -- when a rising clock edge occurs
            if clk'event and clk = '1' then
                count <= count + 1;
            
               
            if(count = 416666) then
                a <= not a;
                count <= 0;   
                 
            end if;
            end if;
            clk_out <= a;
    end process;       

end Behavioral;
