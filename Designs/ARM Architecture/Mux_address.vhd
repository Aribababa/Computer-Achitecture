Library IEEE;
	Use IEEE.std_logic_1164.all;
	
Entity Mux_address is
	Port(
		sel_mux_address: in std_logic;
		Address_A, Address_B: in std_logic_vector(3 downto 0);
		sal_mux_sel: out std_logic_vector(3 downto 0)	
	);
end entity Mux_address;

Architecture Behaivorial of Mux_address is
begin
	Seleccionar: Process(sel_mux_address) is begin
		if (Sel_mux_address = '1') then
			sal_mux_sel <= Address_B;
		else
			sal_mux_sel <= Address_A;
		end if;
	end process Seleccionar;
end architecture Behaivorial;