Library IEEE;
use IEEE. std_logic_1164.all;

Entity add32csa is
	port(
		b       : in  std_logic;
		a       : in  std_logic_vector(31 downto 0);
		sum_in  : in  std_logic_vector(31 downto 0);
		cin     : in  std_logic_vector(31 downto 0);
		sum_out : out std_logic_vector(31 downto 0);
		cout    : out std_logic_vector(31 downto 0)
	);
end entity add32csa;

architecture Behaivioral of add32csa is
	signal zero : std_logic_vector(31 downto 0) := X"00000000";
	signal aa : std_logic_vector(31 downto 0) := X"00000000";
 
	component fadd is
		port(
			a    : in  std_logic;
			b    : in  std_logic;
			cin  : in  std_logic;
			sum   : out std_logic;
			cout : out std_logic
		);
	end component fadd;
	
begin
	aa <= a when b='1' else zero;
	
	Generar: for I in 0 to 31 generate
		Sumador: fadd port map(aa(I), sum_in(I), cin(I) , sum_out(I), cout(I));
	end generate Generar;  
end architecture Behaivioral;