--  https://ghdl.readthedocs.io/en/stable/using/QuickStartGuide.html
--  A testbench has no ports.
entity adder_tb is
end adder_tb;

architecture behav of adder_tb is
  --  Declaration of the component that will be instantiated.
  component adder
    port (ci : in bit; a, b : in bit; s : out bit; co : out bit);
  end component;

  signal a0, a1, a2, a3, b0, b1, b2, b3, s0, s1, s2, s3, ci, co0, co1, co2, co3 : bit;
begin
  --  Component instantiation.
  adder_0: adder port map (ci => ci, a => a0, b=> b0, s => s0, co => co0);
  adder_1: adder port map (ci => co0, a => a1, b => b1, s => s1, co => co1);
  adder_2: adder port map (ci => co1, a => a2, b => b2, s => s2, co => co2);
  adder_3: adder port map (ci => co2, a => a3, b => b3, s => s3, co => co3);

  --  This process does the real job.
  process
    type pattern_type is record
      --  The inputs of the adder.
      ci, a, b : bit;
      --  The expected outputs of the adder.
      co, s : bit;
    end record;
    --  The patterns to apply.
    type pattern_array is array (natural range <>) of pattern_type;
    constant patterns : pattern_array :=
      (('0', '0', '0', '0', '0'),
       ('0', '0', '1', '0', '1'),
       ('0', '1', '0', '0', '1'),
       ('0', '1', '1', '1', '0'),
       ('1', '0', '0', '0', '1'),
       ('1', '0', '1', '1', '0'),
       ('1', '1', '0', '1', '0'),
       ('1', '1', '1', '1', '1'));
  begin
    --  Check each pattern.
    for i in patterns' range loop
      --  Set the inputs.
      a1 <= '1';
      a2 <= '1';
      a3 <= '1';
      
        a0 <= patterns(i).a;
        b0 <= patterns(i).b;
        ci <= patterns(i).ci;
      --  Wait for the results.
        wait for 1 ns;
      --  Check the outputs.
         assert s0 = patterns(i).s
            report "bad sum value" severity error;
        assert co0 = patterns(i).co
          report "bad carry out value" severity error;
    end loop;
    assert false report "end of test" severity note;
    --  Wait forever; this will finish the simulation.
    wait;
  end process;
end behav;
