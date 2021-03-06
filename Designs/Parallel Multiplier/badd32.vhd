library IEEE;
use IEEE.std_logic_1164.all;

entity badd32 is
  port (
		a       : in  std_logic_vector(2 downto 0);
		b       : in  std_logic_vector(31 downto 0);
		sum_in  : in  std_logic_vector(31 downto 0);
		sum_out : out std_logic_vector(31 downto 0);
		prod    : out std_logic_vector(1 downto 0)
	);
end entity badd32;

architecture Behaivorial of badd32 is

  subtype arreglo is std_logic_vector(31 downto 0);
  signal bb        : arreglo;
  signal psum      : arreglo;
  signal b_bar     : arreglo;
  signal two_b     : arreglo;
  signal two_b_bar : arreglo;
  signal cout      : std_logic;
  signal cin       : std_logic;
  signal topbit    : std_logic;
  signal topout    : std_logic;
  signal nc1       : std_logic;
  
  component fadd is
		port(
			a, b, cin: in std_logic;
			sum, cout: out std_logic
		);
	end component fadd;
	
	component add32 is
		port(
			a    : in  std_logic_vector(31 downto 0);
			b    : in  std_logic_vector(31 downto 0);
			cin  : in  std_logic; 
			sum  : out std_logic_vector(31 downto 0);
			cout : out std_logic
		);
	end component add32;


begin 

  two_b <= b(30 downto 0) & '0';
  
  b_bar <= NOT b;
  
  two_b_bar <= b_bar(30 downto 0) & '0';
  
  bb <= b when a="001" OR a="010" 
				else two_b when a="011"
				else two_b_bar when a="100"     
				else b_bar when a="101" or a="110"  
				else (Others => '0');
 

	cin <= '1' when a="100" or a="101" or a="110" 
		else '0';
	
	topbit <= b(31) when a="001" or a="010" or a="011"
					else b_bar(31) when a="100" or a="101" or a="110"
					else '0';

  a1: add32 port map(sum_in, bb, cin, psum, cout);
  a2: fadd port map(sum_in(31), topbit, cout, topout, nc1);

  sum_out(29 downto 0) <= psum(31 downto 2);
  sum_out(31) <= topout;
  sum_out(30) <= topout;
  prod <= psum(1 downto 0);
  
end architecture Behaivorial;