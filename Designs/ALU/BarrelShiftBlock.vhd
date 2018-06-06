library IEEE;
use IEEE.std_logic_1164.all;

Entity BarrelShiftBlock is -- Bloque para 32 bits
	port(
		entradaA: in std_logic_vector(31 downto 0);
		entradaB: in std_logic_vector(31 downto 0);
		salida : out std_logic_vector(31 downto 0);
		shift: in std_logic
	);
end entity BarrelShiftBlock;

Architecture Behavioral of BarrelShiftBlock is

	Component Mux_2_1 IS
		port(
			a, b, sel: in std_logic;
			z: out std_logic
		);    
	end component Mux_2_1;

begin

	Generar: for i in 0 to 31 generate
		Mux: Mux_2_1 port map(
			A => entradaA(i), B => entradaB(i), sel => shift, z => salida(i)
		);
	end generate Generar;
end architecture Behavioral;