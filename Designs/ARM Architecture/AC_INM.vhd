Library IEEE;
Use IEEE.std_logic_1164.all;

Entity AC_INM is
	port(
		get_inm, load_inm, rst_inm: in std_logic;
		inm3_in : in std_logic_vector(2 downto 0);
		inm5_in: in std_logic_vector(4 downto 0);
		inm8_in: in std_logic_vector(7 downto 0);
		inm11_in: in std_logic_vector(10 downto 0);
		inm3_out: out std_logic_vector(2 downto 0);
		inm5_out: out std_logic_vector(4 downto 0);
		inm8_out: out std_logic_vector(7 downto 0);
		inm11_out: out std_logic_vector(10 downto 0)
		
	);
end entity AC_INM;

Architecture Behaivorial of AC_INM is
	Signal INM03 : std_logic_vector(2 downto 0);
	Signal INM05 : std_logic_vector(4 downto 0);
	Signal INM08 : std_logic_vector(7 downto 0);
	Signal INM011: std_logic_vector(10 downto 0);
begin

	Cargar: Process(get_inm, load_inm, rst_inm) is begin
		if (load_inm = '1') then
			INM03 <= inm3_in;
			INM05 <= inm5_in;
			INM08 <= inm8_in;
			INM011 <= inm11_in;
			
		elsif (get_inm = '1') then
			inm3_out <= INM03;
			inm5_out <= INM05;
			inm8_out <= INM08;
			inm11_out <= INM011;
			
		elsif (rst_inm = '1') then
			INM03 <= (Others => '0');
			INM05 <= (Others => '0');
			INM08 <= (Others => '0');
			INM011 <= (Others => '0');
			
		else
			inm3_out <= (Others => 'Z');
			inm5_out <= (Others => 'Z');
			inm8_out <= (Others => 'Z');
			inm11_out <= (Others => 'Z');
		end if;
	end Process Cargar;
end architecture Behaivorial;