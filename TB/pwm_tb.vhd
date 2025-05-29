library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

ENTITY pwm_tb IS
END pwm_tb;

ARCHITECTURE pwm_tb_arch OF pwm_tb IS 

  -- Component Declaration for the Unit Under Test (UUT)
	component pwm is
		GENERIC (n : INTEGER := 16);
        PORT (mode: IN STD_LOGIC_VECTOR (1 DOWNTO 0);
			 x,y: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
             en, rst, clk: in STD_LOGIC;
             pwm_wave: out std_logic);
	end component;

  --Inputs
  signal x : std_logic_vector(7 downto 0) := "00001000";
  signal y : std_logic_vector(7 downto 0) := "00000100";
  signal mode : std_logic_vector(1 downto 0) := (others => '0');
  signal en, clk, rst: std_logic;

  --Outputs
  signal wave_out : std_logic;

BEGIN

  -- Instantiate the Unit Under Test (UUT)
  test: pwm generic map (n=>8) PORT MAP (
        mode => mode,
       x => x,
       y => y,
       en => en,
       rst => rst,
       clk => clk,
       pwm_wave => wave_out
      );

    -- clock generation
    clock: process
    begin
        clk <= '0';
        wait for 50 ns;
        clk <= '1';
        wait for 50 ns;
    end process;

    -- reset generation
    reset: process
    begin
        rst <= '1';
        wait for 100 ns;
        rst <= '0';
        wait for 700 ns;
        rst <= '1';
        wait for 100 ns;
        rst <= '0';
        wait;
    end process;

    -- enable generation
    enable: process
    begin
        en <= '1';
        wait for 400 ns;
        en <= '0';
        wait for 200 ns;
        en <= '1';
        wait;
    end process;

    -- simulation
    simulation: process
    begin
        mode <= "00";
        wait for 10 us;
        mode <= "01";
        wait for 10 us;
        mode <= "10";
        wait;
    end process;
  
end architecture;


