Library IEEE;
Use IEEE.std_logic_1164.all;

Entity Mux_registros is
	port(
		Entrada_A,
		Entrada_B,
		Entrada_C,
		Entrada_D: in std_logic_vector(3 downto 0);
		sel_mux_reg: in std_logic_vector(1 downto 0);
		salida_mux_reg: out std_logic_vector(3 downto 0)
	);
end entity Mux_registros;

Architecture Behaivorial of Mux_registros is
begin
	Process(sel_mux_reg) is begin
		case(sel_mux_reg) is
			When "00" => salida_mux_reg <= Entrada_A;
			When "01" => salida_mux_reg <= Entrada_B;
			When "10" => salida_mux_reg <= Entrada_C;
			When "11" => salida_mux_reg <= Entrada_D;
			When others => null;
		end case;
	end process;
end architecture Behaivorial;