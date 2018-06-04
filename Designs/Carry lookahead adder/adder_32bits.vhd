library IEEE;
use IEEE.std_logic_1164.all;

entity adder_32bits is
	port(
		A, B : in std_logic_vector(31 downto 0);
		salida : out std_logic_vector(31 downto 0);
		carryIn: in std_logic;
		overFlow: out std_logic
	);
end entity adder_32bits;

architecture RTL of adder_32bits is

	component carryLookaheadAdder is
		port(
			a, b : in  std_logic_vector(3 downto 0);
			cin  : in  std_logic;
			sum  : out std_logic_vector(3 downto 0);
			cout : out std_logic
		);
	end component carryLookaheadAdder;
	
	signal carryOut1, carryOut2, carryOut3, carryOut4, carryOut5, carryOut6, carryOut7: std_logic;

begin
	
	Adder01: carryLookaheadAdder port map(  -- 4 bits
		a => A(3 downto 0), b => B(3 downto 0), cin => carryIn, sum => salida(3 downto 0), cout => carryOut1
	);
	Adder02: carryLookaheadAdder port map( -- 8 bits
		a => A(7 downto 4), b => B(7 downto 4), cin => carryOut1, sum => salida(7 downto 4), cout => carryOut2
	);
	Adder03: carryLookaheadAdder port map( -- 12 bits
		a => A(11 downto 8), b => B(11 downto 8), cin => carryOut2, sum => salida(11 downto 8), cout => carryOut3
	);
	Adder04: carryLookaheadAdder port map( -- 16 bits
		a => A(15 downto 12), b => B(15 downto 12), cin => carryOut3, sum => salida(15 downto 12), cout => carryOut4
	);
	Adder05: carryLookaheadAdder port map( -- 20 bits
		a => A(19 downto 16), b => B(19 downto 16), cin => carryOut4, sum => salida(19 downto 16), cout => carryOut5
	);
	Adder06: carryLookaheadAdder port map( -- 24 bits
		a => A(23 downto 20), b => B(23 downto 20), cin => carryOut5, sum => salida(23 downto 20), cout => carryOut6
	);
	Adder07: carryLookaheadAdder port map( -- 28 bits
		a => A(27 downto 24), b => B(27 downto 24), cin => carryOut6, sum => salida(27 downto 24), cout => carryOut7
	);
	Adder08: carryLookaheadAdder port map( -- 32 bits
		a => A(31 downto 28), b => B(31 downto 28), cin => carryOut7, sum => salida(31 downto 28), cout => overFlow
	);
end architecture RTL;