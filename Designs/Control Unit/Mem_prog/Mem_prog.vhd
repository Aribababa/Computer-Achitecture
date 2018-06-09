Library IEEE;
Use IEEE.std_logic_1164.all;
Use IEEE.numeric_std.all;

Entity Mem_prog is
	port(
		clk: in std_logic;
		Address_in: in std_logic_vector(31 downto 0);
		Address_out: out std_logic_vector(15 downto 0)
	);
end entity Mem_prog;

Architecture Behaivorial of Mem_prog is
	
	Type registros is array (0 to 42) of std_logic_vector(15 downto 0);
	Signal registro: registros:=(others => (others => '0'));
	
begin

--	registro(0) <=
--	registro(1) <=
--	registro(2) <=
--	registro(3) <=
--	registro(4) <=
--	registro(5) <=
--	registro(6) <=
--	registro(7) <=
--	registro(8) <=
--	registro(9) <=
	
	Instruccion: Process(Address_in, clk) is begin
		if rising_edge(clk) then
			address_out <= registro(to_integer(unsigned(address_in)));
		else null;
		end if;
	end process Instruccion;

end architecture Behaivorial;