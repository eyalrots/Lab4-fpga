library ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
USE work.aux_package.all;
-------------------------------------
ENTITY top IS
  GENERIC (n : INTEGER := 16);
  PORT  
  (  SW0, SW1, SW2, SW3, SW4, SW5, SW6, SW7, SW8, SW9: in std_logic;
    Key0, Key1, Key2, Key3: in std_logic;
    clk: in std_logic;
    HEX0, HEX1, HEX2, HEX3, HEX4, HEX5: out std_logic_vector(6 downto 0);
    LEDR0, LEDR1, LEDR2, LEDR3, LEDR5, LEDR6, LEDR7, LEDR8, LEDR9: out std_logic;
    GPIO9: out std_logic
  );
END top;
------------- complete the top Architecture code --------------
architecture top_arch of top is 
  signal Y_i,X_i: STD_LOGIC_VECTOR (n-1 DOWNTO 0);
	signal ALUFN_i : STD_LOGIC_VECTOR (4 DOWNTO 0);
  signal en_ylow, en_yhigh, en_xlow, en_xhigh, en_alu: std_logic;
  signal sw_reg: std_logic_vector(7 downto 0);
  signal X_3_0_seg,X_7_4_seg,X_11_8_seg,X_15_12_seg: std_logic_vector (6 downto 0);
  signal Y_3_0_seg,Y_7_4_seg,Y_11_8_seg,Y_15_12_seg: std_logic_vector (6 downto 0);
  signal ALUout_3_0_seg,ALUout_7_4_seg: std_logic_vector (6 downto 0);
  signal ALUout: std_logic_vector (7 downto 0);
  signal PLLout: std_logic;
  signal local_rst: std_logic;
  
begin
  
  en_ylow <= '1' when ((Key0='0') and (SW9='0')) else '0';
  en_yhigh <= '1' when ((Key0='0') and (SW9='1')) else '0';
  en_xlow <= '1' when ((Key1='0') and (SW9='0')) else '0';
  en_xhigh <= '1' when ((Key1='0') and (SW9='1')) else '0';
  en_alu <= '1' when (Key2='0') else '0';

  local_rst <= not(Key3);

  sw_reg <= (0=>SW0, 1=>SW1, 2=>SW2, 3=>SW3, 4=>SW4, 5=>SW5, 6=>SW6, 7=>SW7);

  -- call to the decoder 10 times 
decdoe_x_3_0: hex_decoder port map ( 
Hex_in => X_i(3 downto 0 ),
seg => X_3_0_seg
); 

decdoe_x_7_4: hex_decoder port map ( 
Hex_in => X_i(7 downto 4 ),
seg => X_7_4_seg
); 
decdoe_x_11_8: hex_decoder port map ( 
Hex_in => X_i(11 downto 8 ),
seg => X_11_8_seg
); 

decdoe_x_15_12: hex_decoder port map ( 
Hex_in => X_i(15 downto 12 ),
seg => X_15_12_seg
); 

decdoe_y_3_0: hex_decoder port map ( 
Hex_in => Y_i(3 downto 0 ),
seg => Y_3_0_seg
); 

decdoe_y_7_4: hex_decoder port map ( 
Hex_in => Y_i(7 downto 4 ),
seg => Y_7_4_seg
); 
decdoe_y_11_8: hex_decoder port map ( 
Hex_in => Y_i(11 downto 8 ),
seg => Y_11_8_seg
); 

decdoe_y_15_12: hex_decoder port map ( 
Hex_in => Y_i(15 downto 12 ),
seg => Y_15_12_seg
); 

decdoe_ALUout_3_0: hex_decoder port map ( 
Hex_in => ALUout(3 downto 0 ),
seg => ALUout_3_0_seg
); 

decdoe_ALUout_7_4: hex_decoder port map ( 
Hex_in => ALUout(7 downto 4 ),
seg => ALUout_7_4_seg
); 

-- muxes for the decoder outputs

  with SW9 select
    HEX2 <= Y_3_0_seg when '0',
            Y_11_8_seg when '1',
            (others => '1') when others;
    with SW9 select
    HEX3 <= Y_7_4_seg when '0',
            Y_15_12_seg when '1',
            (others=>'1') when others;
    with SW9 select
    HEX0 <= X_3_0_seg when '0',
            X_11_8_seg when '1',
            (others => '1') when others;
    with SW9 select
    HEX1 <= X_7_4_seg when '0',
            X_15_12_seg when '1',
            (others=>'1') when others;
    HEX4 <= ALUout_3_0_seg;
    HEX5 <= ALUout_7_4_seg;


  y_low: process(en_ylow)
  begin
    if (en_ylow='1') then
      Y_i(7 downto 0) <= sw_reg;
    end if;
  end process;

  y_high: process(en_yhigh)
  begin
    if (en_yhigh='1') then
      Y_i(15 downto 8) <= sw_reg;
    end if;
  end process;

  x_low: process(en_xlow)
  begin
    if (en_xlow='1') then
      X_i(7 downto 0) <= sw_reg;
    end if;
  end process;

  x_high: process(en_xhigh)
  begin
    if (en_xhigh='1') then
      X_i(15 downto 8) <= sw_reg;
    end if;
  end process;

  alu_func: process(en_alu)
  begin
    if (en_alu='1') then
      ALUFN_i <= sw_reg(4 downto 0);
    end if;
  end process;

  -- LED for ALUFN
  LEDR5 <= ALUFN_i(0);
  LEDR6 <= ALUFN_i(1);
  LEDR7 <= ALUFN_i(2);
  LEDR8 <= ALUFN_i(3);
  LEDR9 <= ALUFN_i(4);

 
  PLL_call: PLL port map (
    inclk0 => clk,
    c0 => PLLout
  );

	alu_configuration: alu_fmax port map (
        clk => PLLout,
        Y_i => Y_i(7 downto 0),
        X_i => X_i(7 downto 0),
        ALUFN_i => ALUFN_i,
        ALUout_o => ALUout,
        Nflag_o => LEDR3,
        Cflag_o => LEDR2,
        Zflag_o => LEDR1,
        Vflag_o => LEDR0
    );

    pwm_configuration: pwm_top generic map (n=>n) port map (
        Y_i => Y_i,
        X_i => X_i,
        ALUFN_i => ALUFN_i,
        en => SW8,
        clk => PLLout,
        rst => local_rst,
        pwm_out => GPIO9
    );
end architecture;