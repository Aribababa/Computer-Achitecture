Library IEEE;
USe IEEE.std_logic_1164.all;

Entity Address_register is
	port(
		clk: in std_logic;
		get_AD, load_AD, rst_AD: in std_logic;
		Add_in: in std_logic_vector(31 downto 0);
		Add_out: out std_logic_vector(31 downto 0)
	);
end entity Address_register;

Architecture Behaivorial of Address_register is
	Signal temp: std_logic_vector(31 downto 0);
begin
	Actualizar_dato: Process (clk) is begin
		if(rising_edge(clk)) then
			if(load_ad = '1') then
				temp <= add_in;
				
			elsif(get_ad = '1') then
				Add_out <= temp;
				
			elsif(rst_ad = '1') then
				temp <= (Others => '0');
				
			else 
				Add_out <= (Others => 'Z');
			end if;
		else null;
		end if;
	end Process Actualizar_dato;
end architecture Behaivorial;