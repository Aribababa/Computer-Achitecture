Library IEEE;
use IEEE.std_logic_1164.all;

Entity Arithmetic_Shift_Right is
	port(
		Bytes_entrada: in std_logic_vector(31 downto 0);
		Bytes_salida: out std_logic_vector(31 downto 0);
		Shift: in std_logic_vector(7 downto 0)
	);
end entity Arithmetic_Shift_Right;

Architecture Behaivorial of Arithmetic_Shift_Right is

	Component BarrelShiftBlock is -- Bloque para 32 bits
		port(
			entradaA: in std_logic_vector(31 downto 0);
			entradaB: in std_logic_vector(31 downto 0);
			salida : out std_logic_vector(31 downto 0);
			shift: in std_logic
		);
	end component BarrelShiftBlock;
	
	Signal Signo, conexion01, conexion02, conexion03, conexion04: std_logic_vector(31 downto 0);
	
begin

	Process (Bytes_entrada) is begin
		if (Bytes_entrada(31) = '1') then
			Signo <= (Others => '1');
		else
			Signo <= (Others => '0');
		end if;
	end process;
	
	Primer_nivel: BarrelShiftBlock port map(
		EntradaA=> Bytes_entrada, EntradaB=> Signo(0) & Bytes_entrada(31 downto 1) , salida=> conexion01, Shift=> Shift(0)
	);
	
	Segundo_nivel: BarrelShiftBlock port map(
		EntradaA=> conexion01, EntradaB=> Signo(1 downto 0) & conexion01(31 downto 2) , salida=> conexion02, Shift=> Shift(1)
	);
	
	Tercer_nivel: BarrelShiftBlock port map(
		EntradaA=> conexion02, EntradaB=> Signo(3 downto 0) & conexion02(31 downto 4) , salida=> conexion03, Shift=> Shift(2)
	);
	
	Cuarto_nivel: BarrelShiftBlock port map(
		EntradaA=> conexion03, EntradaB=> Signo(7 downto 0) & conexion03(31 downto 8) , salida=> conexion04, Shift=> Shift(3)
	);
	
	Quinto_nivel: BarrelShiftBlock port map(
		EntradaA=> conexion04, EntradaB=> Signo(15 downto 0) & conexion04(31 downto 16) , salida=> Bytes_salida, Shift=> Shift(4)
	);
	
end architecture Behaivorial;