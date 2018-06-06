Library IEEE;
Use IEEE.std_logic_1164.all;

Entity add32 is
	port(
		a    : in  std_logic_vector(31 downto 0);
      b    : in  std_logic_vector(31 downto 0);
      cin  : in  std_logic; 
      sum  : out std_logic_vector(31 downto 0);
      cout : out std_logic
	);
end entity add32;

architecture Behaivorial of add32 is

	Component fadd is
		port(
			a, b, cin: in std_logic;
			sum, cout: out std_logic
		);
	end Component fadd;

  signal c : std_logic_vector(0 to 30);
begin
  
	Adder0: fadd port map(a(0), b(0), cin, sum(0), c(0));

	Generar: for I in 1 to 30 generate
		Adders:fadd port map(a(I), b(I), c(I-1) , sum(I), c(I));
	end generate Generar;
	
	Adder31:fadd port map(a(31), b(31), c(30) , sum(31), cout);
end architecture Behaivorial;
