Library IEEE;
Use IEEE.std_logic_1164.all;
Use IEEE.numeric_std.all;

Entity Mem_prog is
	port(
		clk: in std_logic;
		enable: in std_logic;
		Address_in: in std_logic_vector(12 downto 0);
		Address_out: out std_logic_vector(15 downto 0)
	);
end entity Mem_prog;

Architecture Behaivorial of Mem_prog is
	
	Type registros is array (0 to 63) of std_logic_vector(15 downto 0);
	Signal registro: registros:=(others => (others => '0'));
	
begin

	registro(0) <= "0001110011001001"; -- ADDS 1, 1, #3 
	registro(1) <= "0001110010010010"; -- ADDS 2, 2, #2	
	registro(2) <= "0001100001010001"; -- ADDS 1, 2, 1
	
	--	registro(3) <=
	--	registro(4) <=
	--	registro(5) <=
	--	registro(6) <=
	--	registro(7) <=
	--	registro(8) <=
	--	registro(9) <=
	
	Instruccion: Process(Address_in, clk) is begin
		if rising_edge(clk) then
			if enable = '1' then
				address_out <= registro(to_integer(unsigned(address_in)));
			else
				address_out <= (Others => 'Z');
			end if;
		else null;
		end if;
	end process Instruccion;
end architecture Behaivorial;