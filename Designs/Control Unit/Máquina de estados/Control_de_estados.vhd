Library IEEE;
	Use IEEE.std_logic_1164.all;
	Use IEEE.numeric_std.all;
	
Entity Control_de_estados is
	port(
		clk: in std_logic;
		instruccion: in std_logic_vector(12 downto 0);
		estadoActual: out std_logic_vector(9 downto 0)
	);
end entity Control_de_estados;

Architecture Behaivorial of Control_de_estados is
	Type estados is (
		Fetch01, Fetch02
	);
	
	Signal pr_state, nx_state: estados;
	
begin

	Cambio_de_estado: Process(clk) is begin
		if rising_edge(clk) then
			pr_state <= nx_state;
		else null;
		end if;
	end process Cambio_de_estado;
	
	Maquina_de_estado: Process(pr_state) is begin
		case(pr_state) is
		
			When Fetch01 =>
				estadoActual <= "0000000000";
				nx_state <= Fetch02;
				
			When Fetch02 =>
				estadoActual <= "0000000001";
				nx_state <= Fetch01;
				
			When Others => 
				null;
		end case;
	end process Maquina_de_estado;
	
end architecture Behaivorial;