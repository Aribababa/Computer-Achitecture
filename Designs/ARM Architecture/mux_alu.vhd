Library IEEE;
Use IEEE.std_logic_1164.all;

Entity mux_alu is
	port(
		sel: in std_logic;
		registro: in std_logic_vector(31 downto 0);
		inm: in std_logic_vector(31 downto 0);
		B: out std_logic_vector(31 downto 0)
	);
end entity mux_alu;

Architecture Behaivorial of mux_alu is
begin
	Multiplexar:Process(sel) is begin
		case(sel) is
			when '0' =>
				B <= registro;
			when '1' =>
				B <= inm;
			When others =>
				null;
		end case;
	end process Multiplexar;
end architecture Behaivorial;