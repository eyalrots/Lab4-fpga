LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.aux_package.all;
-------------------------------------
ENTITY AdderSub IS
  GENERIC (n : INTEGER := 8);
  PORT (     ALUFN: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
			 x,y: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
             cout: OUT STD_LOGIC;
			 v: OUT STD_LOGIC;
             s: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
END AdderSub;
--------------------------------------------------------------
ARCHITECTURE arith_arch OF AdderSub IS
	SIGNAL reg : STD_LOGIC_VECTOR(n-1 DOWNTO 0);
	SIGNAL sub_cont : STD_LOGIC;
	SIGNAL in_sign : STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL local_y : STD_LOGIC_VECTOR(n-1 downto 0);
	SIGNAL local_x : STD_LOGIC_VECTOR(n-1 downto 0);
	SIGNAL temp_s : STD_LOGIC_VECTOR(n-1 downto 0);
	SIGNAL temp_xor : STD_LOGIC_VECTOR(n-1 downto 0);
	signal swap_y : std_logic_vector(n-1 downto 0);
BEGIN
	
	sub_cont <= '1' WHEN (ALUFN = "001" or ALUFN = "010" or ALUFN = "100")
			ELSE '0';
	local_y <= (OTHERS => '0') WHEN (ALUFN = "010") ELSE y;
	local_x <= (0=>'1', OTHERS => '0') WHEN (ALUFN = "011" or ALUFN = "100") ELSE x;
	
	in_sign(0) <= local_y(n-1);
	in_sign(1) <= local_x(n-1);
	
	temp_xor(0) <= (local_x(0) xor sub_cont);
	first : FA port map(
			xi => temp_xor(0),
			yi => local_y(0),
			cin => sub_cont,
			s => temp_s(0),
			cout => reg(0)
	);
	
	rest : for i in 1 to n-1 generate
		temp_xor(i) <= (local_x(i) xor sub_cont);
		chain : FA port map(
			xi => temp_xor(i),
			yi => local_y(i),
			cin => reg(i-1),
			s => temp_s(i),
			cout => reg(i)
		);
	end generate;
	
	-- swap operation
	swap_y <= y((n/2-1) downto 0) & y(n-1 downto (n/2));

	cout <= '0' WHEN (ALUFN = "111") ELSE reg(n-1);

	with ALUFN select
		s <= swap_y when "101",
			(others => '0') when "111",
			temp_s when others;
	
	 v <= '1' WHEN (
			(
				(
					(in_sign(0) = '1' AND in_sign(1) = '1' AND temp_s(n-1) = '0') OR
					(in_sign(0) = '0' AND in_sign(1) = '0' AND temp_s(n-1) = '1')
				) AND (ALUFN = "000" OR ALUFN = "011")
			) OR (
				(
					(in_sign(0) = '0' AND in_sign(1) = '1' AND temp_s(n-1) = '1') OR
					(in_sign(0) = '1' AND in_sign(1) = '0' AND temp_s(n-1) = '0')
				) AND (ALUFN = "001" OR ALUFN = "100")
			)
		) ELSE '0';

END architecture;


