LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
USE work.aux_package.all;

ENTITY alu_tb IS
END alu_tb;

ARCHITECTURE behavior OF alu_tb IS 
  -- Component Declaration for the Unit Under Test (UUT)

	component alu IS
	GENERIC (n : INTEGER := 8;
		   k : integer := 3;   -- k=log2(n)
		   m : integer := 4	); -- m=2^(k-1)
	PORT 
	(  
		Y_i,X_i: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
		  ALUFN_i : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		  ALUout_o: OUT STD_LOGIC_VECTOR(n-1 downto 0);
		  Nflag_o,Cflag_o,Zflag_o,Vflag_o: OUT STD_LOGIC
	); -- Zflag,Cflag,Nflag,Vflag
	end component;
	
-- Auxiliary variables
type memo is array (0 to 14) of std_logic_vector(4 downto 0);
signal ALUFN_inputs : memo := ( ("01000","01001","01010","10000","10001","10010","11000","11001",
									"11010","11011","11100","11101","11111","00000","00100")
							);
--Inputs
	
  signal Y_i : std_logic_vector(7 downto 0) ;
  signal X_i : std_logic_vector(7 downto 0) ;
  signal ALUFN_i : std_logic_vector(4 downto 0) ;
  
 --Outputs
  signal ALUout_o : std_logic_vector(7 downto 0);
  signal Nflag_o : std_logic;
  signal Cflag_o : std_logic;
  signal Zflag_o : std_logic;
  signal Vflag_o : std_logic;
  
  BEGIN
    -- Instantiate the Unit Under Test (UUT)
  uut: alu generic map (    n => 8,
							k => 3
						)
			PORT MAP (
							X_i => X_i,
							Y_i => Y_i,
							ALUFN_i => ALUFN_i,
							ALUout_o => ALUout_o,
							Nflag_o => Nflag_o,
							Cflag_o => Cflag_o,
							Zflag_o => Zflag_o,
							Vflag_o => Vflag_o
					);
					
	  
	  x_y_proc: process
  begin
  X_i <= "01010101";
  Y_i <= "01010101" ;
	wait for 50 ns ;
		for i in 0 to 29 loop
			X_i <= X_i + 1;
			Y_i <= Y_i - 1;
			wait for 50 ns;
		  end loop;
		  wait;
		  
        end process; 
		
			ALUFN_proc : process
        begin
		  ALUFN_i <= (others => '0');
		  for i in 0 to 14 loop
			ALUFN_i <= ALUFN_inputs(i);
			wait for 100 ns;
		  end loop;
		  wait;
        end process;
		
	
END ARCHITECTURE behavior ;
