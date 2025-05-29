LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Logic_tb IS
END Logic_tb;

ARCHITECTURE behavior OF Logic_tb IS 

  -- Component Declaration for the Unit Under Test (UUT)
	component Logic is
		GENERIC (n : INTEGER := 8);
		PORT (ALUFN: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
			 x,y: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
             ALUout: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
	end component;

  --Inputs
  signal x : std_logic_vector(7 downto 0) := (others => '0');
  signal y : std_logic_vector(7 downto 0) := (others => '0');
  signal ALUFN : std_logic_vector(2 downto 0) := (others => '0');

  --Outputs
  signal ALUout : std_logic_vector(7 downto 0);

BEGIN

  -- Instantiate the Unit Under Test (UUT)
  uut: Logic PORT MAP (
       x => x,
       y => y,
       ALUFN => ALUFN,
       ALUout => ALUout
      );

  -- Stimulus process
  stim_proc: process
  begin     
    -- Test case 1: not
    x <= "01010111";
    y <= "00000110";
    ALUFN <= "000";
    wait for 500 ns;
    assert(ALUout = "11111001")
      report "Test case 1 failed" severity error;

    -- Test case 2: or
    x <= "01010111";
    y <= "00000110";
    ALUFN <= "001";
    wait for 500 ns;
    assert(ALUout = "01010111")
      report "Test case 2 failed" severity error;

    -- Test case 3: and
    x <= "01010111";
    y <= "00000110";
    ALUFN <= "010";
    wait for 500 ns;
    assert(ALUout = "00000110")
      report "Test case 3 failed" severity error;

    -- Test case 4: xor
    x <= "01010111";
    y <= "00000110";
    ALUFN <= "011";
    wait for 500 ns;
    assert(ALUout = "01010001")
      report "Test case 4 failed" severity error;
	  
    -- Test case 5: nor
    x <= "01010111";
    y <= "00000110";
    ALUFN <= "100";
    wait for 500 ns;
    assert(ALUout = "10101000")
      report "Test case 5 failed" severity error;
	  
    -- Test case 6: nand
    x <= "01010111";
    y <= "00000110";
    ALUFN <= "101";
    wait for 500 ns;
    assert(ALUout = "11111001")
      report "Test case 6 failed" severity error;
	  
    -- Test case 7: xnor
    x <= "01010111";
    y <= "00000110";
    ALUFN <= "111";
    wait for 500 ns;
    assert(ALUout = "10101110")
      report "Test case 7 failed" severity error;

    wait;
  end process;

END;


