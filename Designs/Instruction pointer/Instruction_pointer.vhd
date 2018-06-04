Library IEEE;
	Use IEEE.std_logic_1164.all;
	Use IEEE.std_logic_unsigned.all;
	Use IEEE.numeric_std.all;

Entity Instruction_pointer is
   Port( 
		clk : in  std_logic;
		load_ip, get_ip, inc_ip, rst_ip: in std_logic;
		cargar: in std_logic_vector(31 downto 0);
		instruccion: out std_logic_vector(12 downto 0)
   );
end entity Instruction_pointer;

architecture Behavioral of Instruction_pointer is
	Signal current_ip: std_logic_vector(12 downto 0):=(Others => '0');
begin
	Actualizar_dato: Process(clk) is begin
		if rising_edge(clk) then
			if (load_ip = '1') then
				current_ip <= cargar(12 downto 0);
				instruccion <= (Others => 'Z');
			
			elsif (get_ip = '1') then
				instruccion <= current_ip;
				
			elsif (inc_ip = '1') then
				current_ip <= current_ip + '1';--std_logic_vector(Unsigned(current_ip) + 1);
				instruccion <= (Others => 'Z');
				
			elsif (rst_ip = '1') then
				current_ip <= (Others => '0');
				instruccion <= (Others => 'Z');
			
			else
				instruccion <= (Others => 'Z');
			end if;
		else null;
		end if;
	end process Actualizar_dato;
end Architecture Behavioral;