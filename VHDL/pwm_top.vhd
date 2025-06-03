library ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
USE work.aux_package.all;
-------------------------------------
ENTITY pwm_top IS
  GENERIC (n : INTEGER := 8);
  PORT 
  (  
	Y_i,X_i: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
		  ALUFN_i : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		  en, clk, rst: in std_logic;
          pwm_out: out std_logic
  );
END pwm_top;
------------- complete the top Architecture code --------------
architecture pwm_top_arch of pwm_top is 
	signal comp_en: std_logic;
    signal en_00: std_logic;
	signal comp_00: std_logic_vector(n-1 downto 0);
	signal x_00, y_00: std_logic_vector(n-1 downto 0);
begin
	comp_00 <= (others => '1') when (ALUFN_i(4 downto 3)="00") else (others => '0');
    comp_en <= '1' when (ALUFN_i(4 downto 3)="00") else '0';
	
	x_00 <= X_i and comp_00;
    y_00 <= Y_i and comp_00;
    en_00 <= en and comp_en;

	pwm_operation: pwm generic map (n=>n) port map (
        mode => ALUFN_i(1 downto 0),
        x => x_00,
        y => y_00,
        en => en_00,
        rst => rst,
        clk => clk,
        pwm_wave => pwm_out
    );
end architecture;