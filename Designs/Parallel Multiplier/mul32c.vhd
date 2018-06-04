library IEEE;
use IEEE.std_logic_1164.all;

entity mul32c is
  port(
		a, b : in  std_logic_vector(31 downto 0);
      prod : out std_logic_vector(31 downto 0)
	);
end entity mul32c;

architecture Behaivorial of mul32c is

	component add32csa is -- Carry save adder
		port(
			b       : in  std_logic;
			a       : in  std_logic_vector(31 downto 0);
			sum_in  : in  std_logic_vector(31 downto 0);
			cin     : in  std_logic_vector(31 downto 0);
			sum_out : out std_logic_vector(31 downto 0);
			cout    : out std_logic_vector(31 downto 0)
		);
  end component add32csa;
  
	Component adder_32bits is -- Carry look Ahead Adder
		port(
			A, B : in std_logic_vector(31 downto 0);
			salida : out std_logic_vector(31 downto 0);
			carryIn: in std_logic;
			overFlow: out std_logic
		);
	end component adder_32bits;
	
	type arr32 is array(0 to 31) of std_logic_vector(31 downto 0);
	signal sum    : arr32;
	signal carry    : arr32;
	signal ss   : arr32;
  
   Signal Producto_parcial: std_logic_vector(63 downto 0);
   Signal zero : std_logic_vector(31 downto 0) := (Others => '0');
   Signal nc1  : std_logic;
  
begin
	CSA_Adders0: add32csa port map(
		B=> b(0), A=> a, Sum_in=> zero , Cin=> zero, Sum_out=> sum(0), Cout=> carry(0)
	);
	
	ss(0) <= '0' & sum(0)(31 downto 1);
	producto_parcial(0) <= sum(0)(0);

	Generar: for I in 1 to 31 generate
		CSA_Adders: add32csa port map(
			b(I), a, ss(I-1) , carry(I-1), sum(I), carry(I)
		);
		
		ss(I) <= '0' & sum(I)(31 downto 1);
		producto_parcial(I) <= sum(I)(0);
	end generate Generar;
  
	Adder_CLA: adder_32bits port map(
		A=> ss(31), B=> carry(31), salida=> producto_parcial(63 downto 32) , carryIn=> '0', overFlow=> nc1
	);
  
  prod <= Producto_parcial(31 downto 0);
  
end architecture Behaivorial;
