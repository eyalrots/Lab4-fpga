LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
USE work.aux_package.all;

ENTITY alu_fmax IS
  GENERIC (n : INTEGER := 8;
		   k : integer := 3);
  PORT 
  (  clk: std_logic;
	Y_i,X_i: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
		  ALUFN_i : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		  ALUout_o: OUT STD_LOGIC_VECTOR(n-1 downto 0);
		  Nflag_o,Cflag_o,Zflag_o,Vflag_o: OUT STD_LOGIC
  ); -- Zflag,Cflag,Nflag,Vflag
END alu_fmax;

ARCHITECTURE behavior OF alu_fmax IS
--Inputs
	
  signal x_local, y_local: std_logic_vector(n-1 downto 0) ;
  signal ALUFN_local : std_logic_vector(4 downto 0) ;
  
 --Outputs
  signal ALUout_local : std_logic_vector(n-1 downto 0);
  signal Nflag_local : std_logic;
  signal Cflag_local : std_logic;
  signal Zflag_local : std_logic;
  signal Vflag_olocal: std_logic;
begin
    input: process (clk)
    begin
    if (clk'event and clk='1') then
        x_local <= X_i;
        y_local <= Y_i;
        ALUFN_local <= ALUFN_i;
    end if;
    end process;

    alu_configuration: alu generic map (n=>n) port map (
        Y_i => y_local,
        X_i => x_local,
        ALUFN_i => ALUFN_local,
        ALUout_o => ALUout_local,
        Nflag_o => Nflag_local,
        Cflag_o => Cflag_local,
        Zflag_o => Zflag_local,
        Vflag_o => Vflag_olocal
    );

    output: process(clk)
    begin
    if (clk'event and clk='1') then
        ALUout_o <= ALUout_local;
        Nflag_o <= Nflag_local;
        Cflag_o <= Cflag_local;
        Zflag_o <= Zflag_local;
        Vflag_o <= Vflag_olocal;
    end if;
    end process;
END ARCHITECTURE behavior ;
