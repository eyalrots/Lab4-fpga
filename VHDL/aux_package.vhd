library IEEE;
use ieee.std_logic_1164.all;

package aux_package is
--------------------------------------------------------
	component alu is
	GENERIC (n : INTEGER := 8;
		   k : integer := 3); -- m=2^(k-1)
	PORT 
	(  
		Y_i,X_i: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
		ALUFN_i : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		ALUout_o: OUT STD_LOGIC_VECTOR(n-1 downto 0);
		Nflag_o,Cflag_o,Zflag_o,Vflag_o: OUT STD_LOGIC 
	); -- Zflag,Cflag,Nflag,Vflag
	end component;
---------------------------------------------------------  
	component alu_fmax is
	GENERIC (n : INTEGER := 8;
		   k : integer := 3); -- m=2^(k-1)
	PORT 
	(  clk: std_logic;
		Y_i,X_i: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
		ALUFN_i : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		ALUout_o: OUT STD_LOGIC_VECTOR(n-1 downto 0);
		Nflag_o,Cflag_o,Zflag_o,Vflag_o: OUT STD_LOGIC 
	); -- Zflag,Cflag,Nflag,Vflag
	end component;
--------------------------------------------------------
	component FA is
		PORT (xi, yi, cin: IN std_logic;
			      s, cout: OUT std_logic);
	end component;
---------------------------------------------------------
	component hex_decoder is 
	PORT (Hex_in		: in STD_LOGIC_VECTOR (3 DOWNTO 0);
			seg   		: out STD_LOGIC_VECTOR (6 downto 0));
	end component;
---------------------------------------------------------
	component Logic is
		GENERIC (n : INTEGER := 8);
		PORT (ALUFN: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
			 x,y: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
             ALUout: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
	end component;
---------------------------------------------------------	
	component AdderSub is
		GENERIC (n : INTEGER := 8);
		PORT (     ALUFN: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
			 x,y: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
             cout: OUT STD_LOGIC;
			 v: OUT STD_LOGIC;
             s: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
	end component;
---------------------------------------------------------
	component Shifter is
		GENERIC (n : INTEGER := 8);
		PORT (     ALUFN: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
			 x,y: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
             cout: OUT STD_LOGIC;
             ALUout: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
	end component;
---------------------------------------------------------
	component pwm is
		GENERIC (n : INTEGER := 16);
		PORT (     mode: IN STD_LOGIC_VECTOR (1 DOWNTO 0);
					x,y: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
					en, rst, clk: in STD_LOGIC;
					pwm_wave: out std_logic);
	end component;
---------------------------------------------------------
component pwm_top IS
  GENERIC (n : INTEGER := 8);
  PORT 
  (  
	Y_i,X_i: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
		  ALUFN_i : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		  en, clk, rst: in std_logic;
		  pwm_out: out std_logic
  );
END component;
---------------------------------------------------------
component top IS
  GENERIC (n : INTEGER := 16);
  PORT 
  (  SW0, SW1, SW2, SW3, SW4, SW5, SW6, SW7, SW8, SW9: in std_logic;
    Key0, Key1, Key2, Key3: in std_logic;
    clk: in std_logic;
    HEX0, HEX1, HEX2, HEX3, HEX4, HEX5: out std_logic_vector(6 downto 0);
    LEDR0, LEDR1, LEDR2, LEDR3, LEDR5, LEDR6, LEDR7, LEDR8, LEDR9: out std_logic;
    GPIO9: out std_logic
  );
END component;
---------------------------------------------------------
	component PLL is
		PORT
			(
				areset		: IN STD_LOGIC  := '0';
				inclk0		: IN STD_LOGIC  := '0';
				c0		: OUT STD_LOGIC ;
				locked		: OUT STD_LOGIC 
			);
	end component;
END aux_package;