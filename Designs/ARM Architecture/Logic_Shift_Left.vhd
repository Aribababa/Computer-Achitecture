Library IEEE;
use IEEE. std_logic_1164.all;

Entity Logic_Shift_Left is
	port(
		Bytes: in std_logic_vector(31 downto 0);
		Bytes_salida: out std_logic_vector(31 downto 0);
		Shift: in std_logic_vector(7 downto 0)
	);
end entity Logic_Shift_Left;

Architecture Behaivorial of Logic_Shift_Left is
	
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
		EntradaA => Bytes, EntradaB => Bytes(30 downto 0) & "0", salida => Conexion01, Shift => Shift(0)
	);
	
	Segundo_nivel: BarrelShiftBlock port map( -- 02 Shift(s)
		EntradaA => Conexion01, EntradaB => Conexion01(29 downto 0) & "00", salida => Conexion02, Shift => Shift(1)
	);
	
	Tercer_nivel: BarrelShiftBlock port map( -- 04 Shift(s)
		EntradaA => Conexion02, EntradaB => Conexion02(27 downto 0) & "0000", salida => Conexion03, Shift => Shift(2)
	);
	
	Cuarto_nivel: BarrelShiftBlock port map( -- 08 Shift(s)
		EntradaA => Conexion03, EntradaB => Conexion03(23 downto 0) & "00000000", salida => Conexion04, Shift => Shift(3)
	);
	
	Quinto_nivel: BarrelShiftBlock port map( -- 16 Shift(s)
		EntradaA => Conexion04, EntradaB => Conexion04(15 downto 0) & "0000000000000000", salida => Bytes_salida, Shift => Shift(4)
	);
	
--	Sexto_nivel: BarrelShiftBlock port map( -- 06 Shift(s)
--		EntradaA => conexion05, EntradaB => conexion05(25 downto 0) & "000000", salida => conexion06, Shift => Shift(5)
--	);
--	
--	Septimo_nivel: BarrelShiftBlock port map( -- 07 Shift(s)
--		EntradaA => conexion06, EntradaB => conexion06(24 downto 0) & "0000000", salida => conexion07, Shift => Shift(6)
--	);
--	
--	Octavo_nivel: BarrelShiftBlock port map( -- 08 Shift(s)
--		EntradaA => conexion07, EntradaB => conexion07(23 downto 0) & "00000000", salida => Bytes_salida, Shift => Shift(7)
--	);

--	Primer_nivel: BarrelShiftBlock port map(
--		EntradaA, EntradaB, salida, Shift
--	);
end architecture Behaivorial;

