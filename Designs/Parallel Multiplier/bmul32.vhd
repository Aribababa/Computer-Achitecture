Library IEEE;
	Use IEEE.std_logic_1164.all;

Entity bmul32 is
  port (
		a : in  std_logic_vector(31 downto 0);
      b : in  std_logic_vector(31 downto 0);
      p : out std_logic_vector(63 downto 0)
	);
end entity bmul32;

architecture Behaivorial of bmul32 is
  signal zer : std_logic_vector(31 downto 0) := (Others => '0');
  signal mul0: std_logic_vector(2 downto 0);
  subtype arreglo is std_logic_vector(31 downto 0);
  type ary is array(0 to 15) of arreglo;
  signal s : ary; 

	component badd32 is
	  port (
			a       : in  std_logic_vector(2 downto 0);
			b       : in  std_logic_vector(31 downto 0);
			sum_in  : in  std_logic_vector(31 downto 0);
			sum_out : out std_logic_vector(31 downto 0);
			prod    : out std_logic_vector(1 downto 0)
		);
	end component badd32;
begin
  mul0 <= a(1 downto 0) & '0';
  a0: badd32 port map(
              mul0,            b, zer,   s( 0), p( 1 downto  0));
   a1: badd32 port map(
              a(3  downto  1), b, s( 0), s( 1), p( 3 downto  2));
   a2: badd32 port map(
              a(5  downto  3), b, s( 1), s( 2), p( 5 downto  4));
   a3: badd32 port map(
              a(7  downto  5), b, s( 2), s( 3), p( 7 downto  6));
   a4: badd32 port map(
              a(9  downto  7), b, s( 3), s( 4), p( 9 downto  8));
   a5: badd32 port map(
              a(11 downto  9), b, s( 4), s( 5), p(11 downto 10));
   a6: badd32 port map(
              a(13 downto 11), b, s( 5), s( 6), p(13 downto 12));
   a7: badd32 port map(
              a(15 downto 13), b, s( 6), s( 7), p(15 downto 14));
   a8: badd32 port map(
              a(17 downto 15), b, s( 7), s( 8), p(17 downto 16));
   a9: badd32 port map(
              a(19 downto 17), b, s( 8), s( 9), p(19 downto 18));
   a10:badd32 port map(
              a(21 downto 19), b, s( 9), s(10), p(21 downto 20));
   a11:badd32 port map(
              a(23 downto 21), b, s(10), s(11), p(23 downto 22));
   a12:badd32 port map(
              a(25 downto 23), b, s(11), s(12), p(25 downto 24));
   a13:badd32 port map(
              a(27 downto 25), b, s(12), s(13), p(27 downto 26));
   a14:badd32 port map(
              a(29 downto 27), b, s(13), s(14), p(29 downto 28));
	a15:badd32 port map(
		a(31 downto 29), b, s(14), p(63 downto 32) , p(31 downto 30));
end architecture Behaivorial;