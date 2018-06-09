Library IEEE;
	Use IEEE.std_logic_1164.all;
	
Entity ext_IP is
	Port(
		clk: in std_logic;
		load_ext_ip, get_ext_ip, rst_ext_ip: in std_logic;
		entrada_ip: in std_logic_vector(12 downto 0);
		salida_ip: out std_logic_vector(31 downto 0)
	);
end entity ext_IP;

Architecture Behaivorial of ext_IP is
	Signal ip: std_logic_vector(12 downto 0):=(Others=>'0');
begin
	Process(load_ext_ip, get_ext_ip, rst_ext_ip) is begin
		--if rising_edge(clk) then
			if (load_ext_ip = '1') then
				ip <= entrada_ip;
				salida_ip <= (Others => 'Z');
				
			elsif (get_ext_ip = '1') then
				salida_ip <= "0000000000000000000" & ip;
				
			elsif (rst_ext_ip = '1') then
				ip <= (Others => '0');
				salida_ip <= (Others => 'Z');
				
			else
				salida_ip <= (Others => 'Z');
			end if;	
		--else null;
		--end if;
	end process;
end architecture Behaivorial;
