Library IEEE;
	Use IEEE.std_logic_1164.all;
	Use IEEE.std_logic_unsigned.all;
	
Entity divisor_de_frecuencia is
	port(
		Clk_in: in std_logic;
		Clk_out: out std_logic
	);
end entity divisor_de_frecuencia;

Architecture Behaivorial of divisor_de_frecuencia is
	Signal temp_clk: std_logic;
begin
	Dividir_de_frecuencia: Process(clk_in) is
		Variable contar: Integer:=0;
	begin
		if rising_edge(clk_in) then
			if contar = 1	then
				contar := 0;
				clk_out <= '1';
			else
				contar := contar + 1;
				clk_out <= '0';
			end if;
		else null;
		end if;
	end process dividir_de_frecuencia;
end architecture Behaivorial;