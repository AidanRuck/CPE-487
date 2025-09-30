--  https://electronicstopper.blogspot.com/2017/07/t-flip-flop-in-vhdl-with-testbench.html
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY TFF_tb IS
END TFF_tb;

-- Testbench should be TFF1 -> CL1 -> TFF2 -> CL2 -> TFF3

ARCHITECTURE behavior OF TFF_tb IS 

    COMPONENT TFF
    PORT(
         T : IN  std_logic;
         clk : IN  std_logic;
         rst : IN  std_logic;
         set : in std_logic;
         Q : OUT  std_logic
        );
    END COMPONENT;
    
    component combinationalLogic1
    port(
        a : in std_logic;
        b : in std_logic;
        c : in std_logic;
        y1 : out std_logic;
        y2 : out std_logic
        );
    end component;
    
    component combinationalLogic2
    port(
        u : in std_logic;
        v : in std_logic;
        w : in std_logic;
        z : out std_logic
        );
    end component;

-- clock
signal clk : std_logic := '0';
signal rst : std_logic := '0';
signal set : std_logic := '0';

-- external input
signal T0_in : std_logic := '0';
signal B_in : std_logic := '0';
signal C_in : std_logic := '0';
signal V_in : std_logic := '0';

-- connect
signal Q0, Q1, Q2 : std_logic;
signal Y1, Y2 : std_logic; --CL1
signal Z : std_logic; --CL2

-- constant clk_period : time := 10 ns;
-- Changing to be within the loop, keeping 10 ns time
BEGIN
    clk <= not clk after 5 ns;
    
    TFF1: TFF port map(T => T0_in, clk => clk, rst => rst, set => set, Q => Q0);
    CL1: combinationalLogic1 port map(a => Q0, b => B_in, c => C_in, y1 => Y1, y2 => Y2);
    TFF2: TFF port map(T => Y1, clk => clk, rst => rst, set => set, Q => Q1);
    CL2: combinationalLogic2 port map(u => Q1, v => V_in, w => Y2, z => Z);
    TFF3: TFF port map(T => Z, clk => clk, rst => rst, set => set, Q => Q2);
    
    --stimulus
    stim : process
    begin
        --reset
        rst <= '1';
        set <= '0';
        T0_in <= '0';
        B_in <= '0';
        C_in <= '0';
        V_in <= '0';
        wait for 20 ns;
        rst <= '0';
        
        --hold
        wait for 40 ns;
        
        --toggle TFF1 on each rising edge
        T0_in <= '1';
        wait for 60 ns;
        
        --CL1
        B_in <= '1';
        wait for 40 ns;
        c_in <= '1';
        wait for 40 ns;
        
        --assert v to block cl2
        V_in <= '1';
        wait for 40 ns;
        V_in <= '0';
        wait for 40 ns;
        
        --set async
        set <= '1';
        wait for 15 ms;
        set <= '0';
        wait for 25 ns;
        
        --reset async
        rst <= '1';
        wait for 10 ns;
        rst <= '0';
        
        --mix
        B_in <= '0';
        C_in <= '1';
        V_in <= '0';
        wait for 60 ns;
        B_in <= '1';
        C_in <= '0';
        V_in <= '1';
        wait for 60 ns;
        
        wait for 200 ns;
        assert false report "End of Simulation" severity failure;
       end process;
END architecture behavior;
