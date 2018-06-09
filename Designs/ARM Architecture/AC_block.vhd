Library IEEE;
use IEEE.std_logic_1164.all;

Entity AC_block is
	port(
		clk: in std_logic;
		load_ac, rst_ac, get_ac: in std_logic;
		numero_in: in std_logic_vector(31 downto 0);
		numero_out: out std_logic_vector(31 downto 0)
	);
end entity AC_block;

Architecture Behavioral of AC_block is
	Signal numero: std_logic_vector(31 downto 0);
begin

	Actualizar_dato: Process (load_ac, rst_ac, get_ac) is begin
		if(rising_edge(clk)) then
			if(load_ac = '1') then
				numero <= numero_in;
				
			elsif(get_ac = '1') then
				numero_out <= numero;
				
			elsif(rst_ac = '1') then
				numero <= (Others => '0');
				
			else 
				numero_out <= (Others => 'Z');
			end if;
		else null;
		end if;
	end Process Actualizar_dato;
end architecture Behavioral;