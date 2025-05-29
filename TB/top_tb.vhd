library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.aux_package.all;

ENTITY top_tb IS
END top_tb;

ARCHITECTURE pwm_tb_arch OF top_tb IS 
  --Inputs
  signal clk: std_logic;
  signal SW0, SW1, SW2, SW3, SW4, SW5, SW6, SW7, SW8, SW9 : std_logic ;
  signal Key0, Key1, Key2, Key3: std_logic ;


  --Outputs
  signal HEX0, HEX1, HEX2, HEX3, HEX4, HEX5 : std_logic_vector(6 downto 0);
  signal LEDR0, LEDR1, LEDR2, LEDR3, LEDR5, LEDR6, LEDR7, LEDR8, LEDR9: std_logic ;
  signal GPIO9 : std_logic ;






BEGIN
  process 
  begin 
  clk <= '1';
  wait for 10 ns;
  clk <= '0';
  wait for 10 ns;
  end process;

  process 
  begin 
  -- load Y low with 4
  SW0 <= '0';
  SW1 <= '0';
  SW2 <= '1';
  SW3 <= '0';
  SW4 <= '0';
  SW5 <= '0';
  SW6 <= '0';
  SW7 <= '0';
  Key0 <= '0';
  Key1 <= '1';
  Key2 <= '1';
  Key3 <= '1';
  SW9 <= '0';
  wait for 500 ns;
  -- load X low with 2
  SW0 <= '0';
  SW1 <= '1';
  SW2 <= '0';
  SW3 <= '0';
  SW4 <= '0';
  SW5 <= '0';
  SW6 <= '0';
  SW7 <= '0';
  Key0 <= '1';
  Key1 <= '0';
  Key2 <= '1';
  Key3 <= '1';
  SW9 <= '0';

  wait for 500 ns;

  -- load Y and X high with 0
  SW0 <= '0';
  SW1 <= '0';
  SW2 <= '0';
  SW3 <= '0';
  SW4 <= '0';
  SW5 <= '0';
  SW6 <= '0';
  SW7 <= '0';
  Key0 <= '0';
  Key1 <= '0';
  Key2 <= '1';
  Key3 <= '1';
  SW9 <= '1';

  wait for 500 ns ;
  -- load ALUFN with add
  SW0 <= '0';
  SW1 <= '0';
  SW2 <= '0';
  SW3 <= '1';
  SW4 <= '0';
  SW5 <= '0';
  SW6 <= '0';
  SW7 <= '0';
  Key0 <= '1';
  Key1 <= '1';
  Key2 <= '0';
  Key3 <= '1';
  SW9 <= '0';
  wait for 500 ns;
  Key0 <= '1';
  Key1 <= '1';
  Key2 <= '1';
  Key3 <= '1';
  wait for 2 us;

  -- load ALUFN with pwm-mode0
  SW0 <= '0';
  SW1 <= '0';
  SW2 <= '0';
  SW3 <= '0';
  SW4 <= '0';
  SW5 <= '0';
  SW6 <= '0';
  SW7 <= '0';
  Key0 <= '1';
  Key1 <= '1';
  Key2 <= '0';
  Key3 <= '1';
  wait for 500 ns;
  SW8 <= '1';
  Key0 <= '1';
  Key1 <= '1';
  Key2 <= '1';
  Key3 <= '0';
  wait for 500 ns;
  Key0 <= '1';
  Key1 <= '1';
  Key2 <= '1';
  Key3 <= '1';
  wait for 10 us;
  wait;

  end process;


    -- Instantiate the Unit Under Test (UUT)
  test: top port map (
    SW0    => SW0,
    SW1    => SW1,
    SW2    => SW2,
    SW3    => SW3,
    SW4    => SW4,
    SW5    => SW5,
    SW6    => SW6,
    SW7    => SW7,
    SW8    => SW8,
    SW9    => SW9,
    Key0   => Key0,
    Key1   => Key1,
    Key2   => Key2,
    Key3   => Key3,
    clk    => clk,
    HEX0   => HEX0,
    HEX1   => HEX1,
    HEX2   => HEX2,
    HEX3   => HEX3,
    HEX4   => HEX4,
    HEX5   => HEX5,
    LEDR0  => LEDR0,
    LEDR1  => LEDR1,
    LEDR2  => LEDR2,
    LEDR3  => LEDR3,
    LEDR5  => LEDR5,
    LEDR6  => LEDR6,
    LEDR7  => LEDR7,
    LEDR8  => LEDR8,
    LEDR9  => LEDR9,
    GPIO9  => GPIO9
  );



		

  
end architecture;


