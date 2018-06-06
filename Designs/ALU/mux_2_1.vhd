library IEEE;
use IEEE.std_logic_1164.all;

entity mux_2_1 is
	port(
		a, b, sel: in std_logic;
		z: out std_logic
	);    
end entity mux_2_1;

architecture Behavioral  of mux_2_1 is
begin
	Seleccionar: process(sel) is
	begin
		if (sel = '0')then
			z <= a;
		elsif (SEL = '1')then
			z <= b;
		else null;				
		end if;	
	end process Seleccionar;            
end architecture Behavioral ;