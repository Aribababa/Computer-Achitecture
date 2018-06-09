Library IEEE;
	Use IEEE.std_logic_1164.all;
	
Entity mux32_2a1 is
	port(
		Entrada_A, Entrada_B: in std_logic_vector(31 downto 0);
		sel_mux32: in std_logic;
		salida_mux32: out std_logic_vector(31 downto 0)
	);
end entity mux32_2a1;

Architecture Behaivorial of Mux32_2a1 is
begin
	Multiplexar: Process(sel_mux32) is begin
		case(sel_mux32) is
			When '0' => salida_mux32 <= Entrada_A;
			When '1' => salida_mux32 <= Entrada_B;
			When others => null;
		end case;
	end process Multiplexar;
end architecture Behaivorial;