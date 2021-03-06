library ieee;
use ieee.std_logic_1164.all;

entity carryLookaheadAdder is
	port(
		a, b : in  std_logic_vector(3 downto 0);
		cin  : in  std_logic;
		sum  : out std_logic_vector(3 downto 0);
		cout : out std_logic
	);
end entity carryLookaheadAdder;

architecture Behaivorial of carryLookaheadAdder is
	signal G, P, C: std_logic_vector(3 downto 0);
begin
	G <= a AND b;
	P <= a XOR b;
	
    c(0) <= cin;
    c(1) <= G(0) OR (P(0) AND C(0));
    c(2) <= G(1) OR (G(0) AND P(1)) OR (C(0) AND P(0) AND P(1));
    c(3) <= G(2) OR (G(1) AND P(2)) OR (G(0) AND P(1) AND P(2)) OR (C(0) AND P(0) AND P(1) AND P(2));
    cout <= G(3) OR (G(2) AND P(3)) OR (G(1) AND P(2) AND P(3)) OR (G(0) AND P(1) AND P(2) AND P(3)) OR (C(0) AND P(0) AND P(1) AND P(2) AND P(3));
    sum <= P XOR C; 
end architecture Behaivorial;
