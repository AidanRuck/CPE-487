----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/23/2025 01:17:16 PM
-- Design Name: 
-- Module Name: CombinationalLogic2 - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CombinationalLogic2 is
    port(
        u : in std_logic;
        v : in std_logic;
        w : in std_logic;
        z : out std_logic
        );
end entity CombinationalLogic2;

architecture rt1 of CombinationalLogic2 is

begin
-- z is (u OR w) AND (NOT v)
z <= (u or w) and (not v);

end architecture rt1;
