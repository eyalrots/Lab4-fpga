
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.aux_package.all;
-------------------------------------
ENTITY Logic IS
  GENERIC (n : INTEGER := 8);
  PORT (     ALUFN: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
			 x,y: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
             ALUout: OUT STD_LOGIC_VECTOR(n-1 downto 0));
END Logic;
--------------------------------------------------------------
architecture arc_logic of Logic is

begin
	
	-- ALUout <= not(y) when (ALUFN = "000") else
	-- 			(y or x) when (ALUFN = "001") else
	-- 			(y and x) when (ALUFN = "010") else
	-- 			(y xor x) when (ALUFN = "011") else
	-- 			(y nor x) when (ALUFN = "100") else
	-- 			(y nand x) when (ALUFN = "101") else
	-- 			(y xnor x) when (ALUFN = "111");

	with ALUFN select
		ALUout <= not(x) when "000",
				y or x when "001",
				y and x when "010",
				y xor x when "011",
				y nor x when "100",
				y nand x when "101",
				y xnor x when "110",
				(others=>'Z') when others;
	
end arc_logic;