library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
-------------------------------------
ENTITY pwm IS
  GENERIC (n : INTEGER := 16);
  PORT (     mode: IN STD_LOGIC_VECTOR (1 DOWNTO 0);
			 x,y: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
             en, rst, clk: in STD_LOGIC;
             pwm_wave: out std_logic);
END pwm;
--------------------------------------------------------------
architecture arc_logic of pwm is
    signal timer_mem: std_logic_vector(n-1 downto 0);
    signal equy: boolean;
    signal wave: std_logic;
begin
	timer_16bit: process(clk, rst, en)
    begin
        if (rst='1') then
            timer_mem <= (others => '0');
        elsif (clk'event and clk='1') then
            if (en='1') then
                if (equy) then
                    timer_mem <= (others=>'0');
                else
                    timer_mem <= timer_mem+1;
                end if;
            end if;
        end if;
    end process;

    digital_circuit: process(clk, en, mode)
    begin
        equy <= (timer_mem=y);
        if (clk'event and clk='1') then
            if (en='1') then
                case mode is
                    when "00" =>
                        if (timer_mem < x) then
                            wave <= '0';
                        else
                            wave <= '1';
                        end if;
                    when "01" =>
                        if (timer_mem < x) then
                            wave <= '1';
                        else
                            wave <= '0';
                        end if;
                    when "10" =>
                        if (timer_mem = x) then
                            wave <= not(wave);
                        end if;
                    when others =>
                        wave <= '0';
                end case;
            end if;
        end if;
    end process;
	
    pwm_wave <= wave;
end architecture;