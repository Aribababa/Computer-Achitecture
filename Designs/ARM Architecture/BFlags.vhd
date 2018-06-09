Library IEEE;
use IEEE.std_logic_1164.all;

Entity BFlags is
	port(
		load_flags, rst_flags, get_flags: in std_logic;
		Flags_in: in std_logic_vector(3 downto 0);
		Flags_out: out std_logic_vector(3 downto 0)
	);
end entity BFlags; 

Architecture Behavorial of BFlags is
	Signal S_Flags: std_logic_vector(3 downto 0);
begin

	Actualiar_Flags: Process(load_flags, rst_flags, get_flags) is 
	begin 
		--if(rising_edge(clk)) then
			if(load_flags = '1') then
				S_Flags <= Flags_in;
				
			elsif (rst_flags = '1') then
				S_Flags <= (Others => '0');
				
			elsif (get_flags = '1') then
				Flags_out <= S_Flags;
				
			else 
				Flags_out <= (Others => 'Z');
			end if;
		--else null;
		--end if;
	end process Actualiar_Flags;
end architecture Behavorial;