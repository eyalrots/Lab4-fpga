LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY AdderSub_tb IS
END AdderSub_tb;

ARCHITECTURE behavior OF AdderSub_tb IS 

  -- Component Declaration for the Unit Under Test (UUT)
component AdderSub is
	GENERIC (n : INTEGER := 8);
	PORT (     ALUFN: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
		 x,y: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
		 cout: OUT STD_LOGIC;
		 v: OUT STD_LOGIC;
		 s: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
end component;

  --Inputs
  signal x : std_logic_vector(7 downto 0) := (others => '0');
  signal y : std_logic_vector(7 downto 0) := (others => '0');
  signal ALUFN : std_logic_vector(2 downto 0) := (others => '0');

  --Outputs
  signal cout : std_logic;
  signal v : std_logic;
  signal s : std_logic_vector(7 downto 0);

BEGIN

  -- Instantiate the Unit Under Test (UUT)
  uut: AdderSub PORT MAP (
       x => x,
       y => y,
       ALUFN => ALUFN,
       cout => cout,
	   v => v,
       s => s
      );

  -- Stimulus process
  stim_proc: process
  begin     
    -- Test case 1: Addition
    x <= "00001100";
    y <= "00000110";
    ALUFN <= "000";
    wait for 500 ns;
    assert(s = "00010010" and cout = '0')
      report "Test case 1 failed" severity error;

    -- Test case 2: Subtraction
    x <= "00000110";
    y <= "00001100";
    ALUFN <= "001";
    wait for 500 ns;
    assert(s = "00000110" and cout = '1')
      report "Test case 2 failed" severity error;

    -- Test case 3: Carry
    x <= "11111111";
    y <= "00000001";
    ALUFN <= "000";
    wait for 500 ns;
    assert(s = "00000000" and cout = '1')
      report "Test case 3 failed" severity error;

    -- Test case 4: Zero value
    x <= "00000000";
    y <= "00000000";
    ALUFN <= "000";
    wait for 500 ns;
    assert(s = "00000000" and cout = '0')
      report "Test case 4 failed" severity error;
	  
	-- Test case 5: negative
    x <= "00000110";
    y <= "00001100";
    ALUFN <= "010";
    wait for 500 ns;
    assert(s = "11111010" and cout = '0')
      report "Test case 5 failed" severity error;
	  
    -- Test case 6: Increment
    x <= "00000110";
    y <= "00001100";
    ALUFN <= "011";
    wait for 500 ns;
    assert(s = "00001101" and cout = '0')
      report "Test case 6 failed" severity error;
	  
    -- Test case 7: Decrement
    x <= "00000110";
    y <= "00001100";
    ALUFN <= "100";
    wait for 500 ns;
    assert(s = "00001011" and cout = '1')
      report "Test case 7 failed" severity error;
	  
    -- Test case 8: OverFlow
    x <= "10000000";
    y <= "10000000";
    ALUFN <= "000";
    wait for 500 ns;
    assert(s = "00000000" and cout = '1' and v = '1')
      report "Test case 8 failed" severity error;

    wait;
  end process;

END;
