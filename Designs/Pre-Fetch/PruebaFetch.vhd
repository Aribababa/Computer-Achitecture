Library IEEE;
Use IEEE.std_logic_1164.all;

Entity PruebaFetch is
	port(
		clk: in std_logic;
		input: in std_logic_vector(15 downto 0);
		output: out std_logic_vector(15 downto 0)
	);
end entity PruebaFetch;

Architecture Behaivorial of PruebaFetch is

	Type estado is (Fetch01, Fetch02, Fetch03, Detener); --el estado Detener es para pruebas
	Signal pr_state, nx_state: estado;
	
begin

	SaltoDeEstado: Process (Clk) is begin
		if rising_edge(Clk) then		
			pr_state <= nx_state;
		else null;
		end if;
	end Process SaltoDeEstado;
	
	Process(pr_state) is begin
		case(pr_state) is
			
			When Fetch01 =>
				nx_state <= Fetch02;
			
			When Fetch02 =>
				nx_state <= Fetch03;
			
			When Fetch03 =>
				nx_state <= Detener;
			
			When Detener =>
				nx_state <= Detener;
			
			When others =>
				nx_state <= detener;
		end case;
	end Process;
end architecture Behaivorial;

