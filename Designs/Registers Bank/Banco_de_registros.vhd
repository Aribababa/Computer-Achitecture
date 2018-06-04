Library IEEE;
Use IEEE.std_logic_1164.all;
Use IEEE.numeric_std.all;

Entity Banco_de_registros is
	Port(
		clk, Load: in std_logic;
		dato_in: in std_logic_vector(31 downto 0);
		Sel_a, Sel_b, address: in std_logic_vector(3 downto 0);
		salida_a, salida_b: out std_logic_vector(31 downto 0)
	);
end entity Banco_de_registros;

Architecture Behaivorial of Banco_de_registros is

	-- Arreglo para banco de 16 registros.
	-- Cada registro contiene un vector de 32 bits.
	-- R(15) <= intrucction pointer
	-- R(14) <= Link register
	-- R(13) <= Stack pointer
	-- R(0) - R(12) <= Proposito general
	
	Type registros is array (0 to 15) of std_logic_vector(31 downto 0);
	Signal registro: registros:=(others => (others => '0'));
	
begin

	Cargar_dato: Process(clk, load) is begin
		if rising_edge(clk) then
			if load = '1' then
				registro(to_integer(unsigned(address))) <= dato_in;
			else
				registro(to_integer(unsigned(address))) <= registro(to_integer(unsigned(address)));
			end if;
		else null;
		end if;
	end process Cargar_dato;
	
	Salida: Process(sel_a, sel_b) is begin
		salida_a <= registro(to_integer(unsigned(sel_a)));
		salida_b <= registro(to_integer(unsigned(sel_b)));
	end process Salida;

end architecture Behaivorial;

