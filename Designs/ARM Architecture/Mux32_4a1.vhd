Library IEEE;
	Use IEEE.std_logic_1164.all;
	
Entity Mux32_4a1 is
	port(
	Entrada_A,
	Entrada_B,
	Entrada_C,
	Entrada_D: in std_logic_vector(31 downto 0);
	sel_mux_4a1: in std_logic_vector(1 downto 0);
	salida_mux_4a1: out std_logic_vector(31 downto 0)
	);
end entity Mux32_4a1;

Architecture Behaivorial of Mux32_4a1 is
begin
	Multiplexar: Process(sel_mux_4a1) is begin
		Case(sel_mux_4a1) is
			When "00" => salida_mux_4a1 <= Entrada_A;
			When "01" => salida_mux_4a1 <= Entrada_B;
			When "10" => salida_mux_4a1 <= Entrada_C;
			When "11" => salida_mux_4a1 <= Entrada_D;
			When Others => null;
		end case;
	end process Multiplexar;
end architecture Behaivorial;