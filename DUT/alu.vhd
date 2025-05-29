library ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
USE work.aux_package.all;
-------------------------------------
ENTITY alu IS
  GENERIC (n : INTEGER := 8;
		   k : integer := 3);
  PORT 
  (  
	Y_i,X_i: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
		  ALUFN_i : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		  ALUout_o: OUT STD_LOGIC_VECTOR(n-1 downto 0);
		  Nflag_o,Cflag_o,Zflag_o,Vflag_o: OUT STD_LOGIC
  ); -- Zflag,Cflag,Nflag,Vflag
END alu;
------------- complete the top Architecture code --------------
architecture alu_arch of alu is 
	signal c_arithmetic, c_shifter: std_logic;
	signal v_arithmetic: std_logic;
	signal out_arithmetic, out_logic, out_shifter, out_temp: std_logic_vector(n-1 downto 0);
	signal comp_01, comp_11, comp_10: std_logic_vector(n-1 downto 0);
	signal x_01, x_11, x_10, y_01, y_11, y_10: std_logic_vector(n-1 downto 0);
	signal zero_vec: std_logic_vector (n-1 downto 0) := (others => '0');
begin
	comp_01 <= (others => '1') when (ALUFN_i(4 downto 3)="01") else (others => '0');
	comp_11 <= (others => '1') when (ALUFN_i(4 downto 3)="11") else (others => '0');
	comp_10 <= (others => '1') when (ALUFN_i(4 downto 3)="10") else (others => '0');
	
	x_01 <= X_i and comp_01;
    y_01 <= Y_i and comp_01;
    x_11 <= X_i and comp_11;
    y_11 <= Y_i and comp_11;
    x_10 <= X_i and comp_10;
    y_10 <= Y_i and comp_10;

	add: AdderSub generic map (n=>n) port map (
		ALUFN => ALUFN_i(2 downto 0),
		x => x_01,
		y => y_01,
		cout => c_arithmetic,
		v => v_arithmetic,
		s => out_arithmetic
	);
		
		
	log: Logic generic map (n=>n) port map(
		ALUFN => ALUFN_i(2 downto 0),
		x => x_11,
		y => y_11,
		ALUout => out_logic
	);
	
	sft: Shifter generic map (n=>n) port map(
		ALUFN => ALUFN_i(2 downto 0),
		x => x_10,
		y => y_10,
		cout => c_shifter,
		ALUout => out_shifter
	);

	with ALUFN_i(4 downto 3) select
		out_temp <= out_arithmetic when "01",
					out_logic when "11",
					out_shifter when "10",
					(others => 'Z') when others;
	
	with ALUFN_i(4 downto 3) select
		Cflag_o <= c_arithmetic when "01",
					c_shifter when "10",
					'0' when others;
	
	Zflag_o <= '1' when (out_temp=zero_vec) else '0';

	Nflag_o <= '1' when (out_temp(n-1) = '1') else '0';

	Vflag_o <= v_arithmetic when (ALUFN_i(4 downto 3)="01") else '0';

	ALUout_o <= out_temp;
end architecture;