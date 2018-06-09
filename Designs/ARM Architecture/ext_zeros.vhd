Library IEEE;
Use IEEE.std_logic_1164.all;

Entity ext_zeros is
	port(
	sal_3, sal_5, sal_8, sal_11: in std_logic;
	inm3: in std_logic_vector(2 downto 0);
	inm5: in std_logic_vector(4 downto 0);
	inm8: in std_logic_vector(7 downto 0);
	inm11: in std_logic_vector(10 downto 0);
	salida: out std_logic_vector(31 downto 0)
	);
end entity ext_zeros;

Architecture Behaivorial of ext_zeros is
	
begin
	Multiplexar: Process(sal_3, sal_5, sal_8, sal_11) is begin
		if sal_3 = '1' then
			salida <= "00000000000000000000000000000" & inm3;
		elsif sal_5 = '1' then
			salida <= "000000000000000000000000000" & inm5;
		elsif sal_8 = '1' then
			salida <= "000000000000000000000000" & inm8;
		elsif sal_11 = '1' then
			salida <= "000000000000000000000" & inm11;
		else
			salida <= (others => 'Z');
		end if;
	end Process Multiplexar;
end architecture BEhaivorial;