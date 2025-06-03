LIBRARY ieee;
USE ieee.std_logic_1164.all;
-------------------------------------
ENTITY Shifter IS
  GENERIC (n : INTEGER := 8);
  PORT (     ALUFN: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
			 x,y: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
             cout: OUT STD_LOGIC;
             ALUout: OUT STD_LOGIC_VECTOR(n-1 downto 0));
END Shifter;
--------------------------------------------------------------
ARCHITECTURE arc_shift OF Shifter IS
	signal temp_y_R : std_logic_vector (n-1 downto 0);
	signal temp_y_L : std_logic_vector (n-1 downto 0);
	signal carry_out_R : std_logic ;
	SIGNAL carry_out_L: std_logic;

BEGIN


	R_shifter: with x(2 downto 0) select 
		temp_y_R <= 
			y(n-1 downto 0)                                 when "000",
			'0' & y(n-1 downto 1)                           when "001",
			"00" & y(n-1 downto 2)                          when "010",
			"000" & y(n-1 downto 3)                         when "011",
			"0000" & y(n-1 downto 4)                        when "100",
			"00000" & y(n-1 downto 5)                       when "101",
			"000000" & y(n-1 downto 6)                      when "110",
			"0000000" & y(n-1 downto 7)                     when "111",
			(others => 'Z')                                 when others;
							


	L_shifter: with x( 2 downto 0) select
		temp_y_L <= 
			y(n-1 downto 0)                                 when "000",
			y(n-2 downto 0) & '0'                           when "001",
			y(n-3 downto 0) & "00"                          when "010",
			y(n-4 downto 0) & "000"                         when "011",
			y(n-5 downto 0) & "0000"                        when "100",
			y(n-6 downto 0) & "00000"                       when "101",
			y(n-7 downto 0) & "000000"                      when "110",
			y(n-8 downto 0) & "0000000"                     when "111",
			(others => 'Z')                              	when others;


	carry_R: with x(2 downto 0) select
		carry_out_R <= 
			y(0)    when "001",
			y(1)    when "010",
			y(2)    when "011",
			y(3)    when "100",
			y(4)    when "101",
			y(5)    when "110",
			y(6)    when "111",
			'0'     when "000",  -- No shift → no carry
			'Z'     when others;

	carry_L: with x(2 downto 0) select
			carry_out_L <= 
			y(n-1)  when "001",
			y(n-2)  when "010",
			y(n-3)  when "011",
			y(n-4)  when "100",
			y(n-5)  when "101",
			y(n-6)  when "110",
			y(n-7)  when "111",
			'0'     when "000",  -- No shift → no carry
			'Z'     when others;

	ALUout <= temp_y_L when ALUFN ="000" else temp_y_R ;
	cout <= carry_out_L when ALUFN ="000" else carry_out_R ;
end architecture;