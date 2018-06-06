Library IEEE;
use IEEE.std_logic_1164.all;

Entity fadd is
	port(
		a, b, cin: in std_logic;
		sum, cout: out std_logic
	);
end entity fadd;

architecture Behaivorial of fadd is
	signal Baux: std_logic;
begin
	Sum <= A XOR B XOR Cin;
	Cout <= (A AND B) OR (A AND Cin) OR (B AND Cin);
end architecture Behaivorial;

