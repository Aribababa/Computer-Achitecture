Library IEEE;
use IEEE. std_logic_1164.all;

Entity Logic_Shift_Right is
	port(
		Bytes: in std_logic_vector(31 downto 0);
		Bytes_salida: out std_logic_vector(31 downto 0);
		Shift: in std_logic_vector(7 downto 0)
	);
end entity Logic_Shift_Right;

Architecture Behaivorial of Logic_Shift_Right is
	
	Component BarrelShiftBlock is -- Bloque para 32 bits
		port(
			entradaA: in std_logic_vector(31 downto 0);
			entradaB: in std_logic_vector(31 downto 0);
			salida : out std_logic_vector(31 downto 0);
			shift: in std_logic
		);
	end component BarrelShiftBlock;
	
	Signal Conexion01, Conexion02, Conexion03, Conexion04, conexion05, conexion06, conexion07: std_logic_vector(31 downto 0);
	
begin
	Primer_nivel: BarrelShiftBlock port map( -- 01 Shift(s)
		EntradaA => Bytes, EntradaB => "0" & Bytes(31 downto 1), salida => Conexion01, Shift => Shift(0)
	);
	
	Segundo_nivel: BarrelShiftBlock port map( -- 02 Shift(s)
		EntradaA => Conexion01, EntradaB => "00" & Conexion01(31 downto 2), salida => Conexion02, Shift => Shift(1)
	);
	
	Tercer_nivel: BarrelShiftBlock port map( -- 04 Shift(s)
		EntradaA => Conexion02, EntradaB => "0000" & Conexion02(31 downto 4), salida => Conexion03, Shift => Shift(2)
	);
	
	Cuarto_nivel: BarrelShiftBlock port map( -- 08 Shift(s)
		EntradaA => Conexion03, EntradaB => "00000000" & Conexion03(31 downto 8), salida => Conexion04, Shift => Shift(3)
	);
	
	Quinto_nivel: BarrelShiftBlock port map( -- 16 Shift(s)
		EntradaA => Conexion04, EntradaB => "0000000000000000" & Conexion04(31 downto 16), salida => Bytes_salida, Shift => Shift(4)
	);
	
--	Sexto_nivel: BarrelShiftBlock port map( -- 06 Shift(s)
--		EntradaA => conexion05, EntradaB => "000000" & conexion05(31 downto 6), salida => conexion06, Shift => Shift(5)
--	);
--	
--	Septimo_nivel: BarrelShiftBlock port map( -- 07 Shift(s)
--		EntradaA => conexion06, EntradaB => "0000000" & conexion06(31 downto 7), salida => conexion07, Shift => Shift(6)
--	);
--	
--	Octavo_nivel: BarrelShiftBlock port map( -- 08 Shift(s)
--		EntradaA => conexion07, EntradaB => "00000000" & conexion07(31 downto 8), salida => Bytes_salida, Shift => Shift(7)
--	);

--	Primer_nivel: BarrelShiftBlock port map(
--		EntradaA, EntradaB, salida, Shift
--	);
end architecture Behaivorial;

