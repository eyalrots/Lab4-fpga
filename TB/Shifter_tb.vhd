LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Shifter_tb IS
END Shifter_tb;

ARCHITECTURE behavior OF Shifter_tb IS 

  -- Component Declaration for the Unit Under Test (UUT)
	component Shifter is
		GENERIC (n : INTEGER := 8);
		PORT (     ALUFN: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
			 x,y: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
             cout: OUT STD_LOGIC;
             ALUout: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
	end component;

  --Inputs
  signal x : std_logic_vector(7 downto 0) := (others => '0');
  signal y : std_logic_vector(7 downto 0) := (others => '0');
  signal ALUFN : std_logic_vector(2 downto 0) := (others => '0');

  --Outputs
  signal cout : std_logic;
  signal ALUout : std_logic_vector(7 downto 0);

BEGIN

  -- Instantiate the Unit Under Test (UUT)
  uut: Shifter PORT MAP (
       x => x,
       y => y,
       ALUFN => ALUFN,
       cout => cout,
       ALUout => ALUout
      );

  -- Stimulus process
  stim_proc: process
  begin     
    -- Test case 1: shl-1
    x <= "00000001";
    y <= "00000110";
    ALUFN <= "000";
    wait for 500 ns;
    assert(ALUout = "00001100" and cout = '0')
      report "Test case 1 failed" severity error;

    -- Test case 2: shl-1-c
    x <= "00000001";
    y <= "10000000";
    ALUFN <= "000";
    wait for 500 ns;
    assert(ALUout = "00000000" and cout = '1')
      report "Test case 2 failed" severity error;

    -- Test case 3: shr-1
    x <= "00000001";
    y <= "00000010";
    ALUFN <= "001";
    wait for 500 ns;
    assert(ALUout = "00000001" and cout = '0')
      report "Test case 3 failed" severity error;

    -- Test case 4: shr-1-c
    x <= "00000001";
    y <= "00000001";
    ALUFN <= "001";
    wait for 500 ns;
    assert(ALUout = "00000000" and cout = '1')
      report "Test case 4 failed" severity error;
	  
    -- Test case 5: shl-4
    x <= "00000100";
    y <= "00000001";
    ALUFN <= "000";
    wait for 500 ns;
    assert(ALUout = "00010000" and cout = '0')
      report "Test case 5 failed" severity error;
	  
    -- Test case 6: shr-4
    x <= "00000100";
    y <= "10000000";
    ALUFN <= "001";
    wait for 500 ns;
    assert(ALUout = "00001000" and cout = '0')
      report "Test case 6 failed" severity error;
	  
    -- Test case 7: shl-4-c
    x <= "00000100";
    y <= "00100000";
    ALUFN <= "000";
    wait for 500 ns;
    assert(ALUout = "00000000" and cout = '0')
      report "Test case 7 failed" severity error;

    wait;
  end process;

END;


