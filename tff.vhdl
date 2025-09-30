--  https://electronicstopper.blogspot.com/2017/07/t-flip-flop-in-vhdl-with-testbench.html
library ieee;
use ieee.std_logic_1164.all;

entity TFF is
port( T: in std_logic;
clk: in std_logic;
rst: in std_logic;
set: in std_logic;
Q: out std_logic);
end TFF;

architecture rt1 of TFF is
    signal q_reg : std_logic := '0';
begin
    Q <= q_reg;
process(set,rst,clk)
begin
if (set='1') then
    q_reg <= '1';
elsif(rst = '1') then
    q_reg <= '0';
elsif(rising_edge(clk)) then
    if(T = '1') then
        q_reg <= not q_reg;
    else
        q_reg <= q_reg;
    end if;
end if;
end process;

end architecture rt1;
