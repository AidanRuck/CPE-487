----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/23/2025 01:17:16 PM
-- Design Name: 
-- Module Name: CombinationalLogic1 - Behavioral
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

entity CombinationalLogic1 is
    port(
        a : in std_logic;
        b : in std_logic;
        c : in std_logic;
        y1 : out std_logic;
        y2 : out std_logic
        );
end entity CombinationalLogic1;

architecture rt1 of CombinationalLogic1 is

begin
-- y1 is (a AND b) XOR b
-- y2 is NOT(a AND c) OR b
y1 <= (a and b) xor c;
y2 <= (not (a and c)) or b;

end architecture rt1;
