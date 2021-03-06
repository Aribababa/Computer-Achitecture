Library IEEE;
use IEEE.std_logic_1164.all;

Entity adder_64bits is
	port(
		A, B: in std_logic_vector(63 downto 0);
		salida: out std_logic_vector(63 downto 0);
		Cin: in std_logic;
		overFlow: out std_logic
	);
end entity adder_64bits;

Architecture Behaivorial of adder_64bits is
	component adder_32bits is
		port(
			A, B : in std_logic_vector(31 downto 0);
			salida : out std_logic_vector(31 downto 0);
			carryIn: in std_logic;
			overFlow: out std_logic
		);
	end component adder_32bits;
	
	Signal Salida01, salida02: std_logic_vector(31 downto 0);
	SIgnal overFlow01: std_logic;
	
begin

	Adder0: adder_32bits port map(
		A => A(31 downto 0), B => B(31 downto 0), Salida => salida01, CarryIn => Cin, overflow => overFlow01
	);
	Adder1: adder_32bits port map(
		A => A(63 downto 32), B => B(63 downto 32), Salida => salida02, CarryIn => overFlow01, overflow => overflow
	);
	salida <= Salida02 & salida01;
end architecture Behaivorial;