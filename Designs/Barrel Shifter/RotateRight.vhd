Library IEEE;
use IEEE.std_logic_1164.all;

Entity RotateRight is
	port(
		Bytes_entrada: in std_logic_vector(31 downto 0);
		Bytes_salida: out std_logic_vector(31 downto 0);
		Rotate: in std_logic_vector(7 downto 0)
	);
end entity RotateRight;

Architecture Behaivorial of RotateRight is
	
	Component BarrelShiftBlock is -- Bloque para 32 bits
		port(
			entradaA: in std_logic_vector(31 downto 0);
			entradaB: in std_logic_vector(31 downto 0);
			salida : out std_logic_vector(31 downto 0);
			shift: in std_logic
		);
	end component BarrelShiftBlock;
	
	Signal conexion01, conexion02, conexion03, conexion04: std_logic_vector(31 downto 0);
	
begin

	Primer_nivel: BarrelShiftBlock port map( -- Rotar 01 bits
		EntradaA=> Bytes_entrada, EntradaB=> Bytes_entrada(0) & Bytes_entrada(31 downto 1), salida=> conexion01, Shift=> Rotate(0)
	);
	
	Segundo_nivel: BarrelShiftBlock port map( -- Rotar 02 bits
		EntradaA=> conexion01, EntradaB=> conexion01(1 downto 0) & conexion01(31 downto 2), salida=> conexion02, Shift=> Rotate(1)
	);
	
	Tercer_nivel: BarrelShiftBlock port map( -- Rotar 04 bits
		EntradaA=> conexion02, EntradaB=> conexion02(3 downto 0) & conexion02(31 downto 4), salida=> conexion03, Shift=> Rotate(2)
	);
	
	Cuarto_nivel: BarrelShiftBlock port map( -- Rotar 08 bits
		EntradaA=> conexion03, EntradaB=> conexion03(7 downto 0) & conexion03(31 downto 8), salida=> conexion04, Shift=> Rotate(3)
	);
	
	Quinto_nivel: BarrelShiftBlock port map( -- Rotar 16 bits
		EntradaA=> conexion04, EntradaB=> conexion04(15 downto 0) & conexion04(31 downto 16), salida=> Bytes_salida, Shift=> Rotate(4)
	);
end architecture Behaivorial;