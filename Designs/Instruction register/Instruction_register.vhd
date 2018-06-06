Library IEEE;
Use IEEE.std_logic_1164.all;

Entity Instruction_register is
	port(
		clk, load_IR, get_IR: in std_logic;
		instruccion_in: in std_logic_vector(9 downto 0);
		instruccion_out: out std_logic_vector(9 downto 0)
	);
end entity Instruction_register;

Architecture Behaivorial of Instruction_register is
	Signal Que_Wey: std_logic_vector(9 downto 0);
begin

	Cargar_instruccion: Process(clk) is begin
		if rising_edge(clk) then
			if load_IR = '1' then
				que_Wey <= instruccion_in;
			else 
				Que_Wey <= Que_Wey;
			end if;
		else null;
		end if;
	end process Cargar_instruccion;
	
	Leer_instruccion: Process(clk) is begin
		if rising_edge(clk) then
			if get_IR = '1' then
				instruccion_out <= Que_Wey;
			else
				Instruccion_out <= (Others => 'Z');
			end if;
		else null;
		end if;
	end process Leer_instruccion;
end architecture Behaivorial;