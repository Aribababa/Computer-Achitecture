Library IEEE;
	Use IEEE.std_logic_1164.all;
	
Entity Acumulador_de_registros is
	Port(
		clk: in std_logic;
		get_ac_reg: in std_logic;
		rst_ac_reg: in std_logic;
		registro_RM_in, registro_RN_in, registro_RD_in : in std_logic_vector(2 downto 0);
		registro_RM_out, registro_RN_out, registro_RD_out: out std_logic_vector(3 downto 0)
	);
end entity Acumulador_de_registros;

Architecture Behaivorial of Acumulador_de_registros is
	Signal 	current_register_RM,
				current_register_RN,
				current_register_RD: std_logic_vector(2 downto 0);
begin
	Cambiar_registro: Process(clk) is begin
		if falling_edge(clk) then
			
			if (get_ac_reg = '1') then
				registro_RM_out <= "0" & current_register_RM;
				registro_RN_out <= "0" & current_register_RN;
				registro_RD_out <= "0" & current_register_RD;
				
			elsif (rst_ac_reg = '1') then
				current_register_RM <= (Others => '0');
				current_register_RN <= (Others => '0');
				current_register_RD <= (Others => '0');
				
				registro_RM_out <= (Others => 'Z');
				registro_RN_out <= (Others => 'Z');
				registro_RD_out <= (Others => 'Z');
					
			else
			
				current_register_RM <= registro_RM_in;
				current_register_RN <= registro_RN_in;
				current_register_RD <= registro_RD_in;
			
				registro_RM_out <= (Others => 'Z');
				registro_RN_out <= (Others => 'Z');
				registro_RD_out <= (Others => 'Z');
				
			end if;
		else null;
		end if;
	end Process Cambiar_registro;		
end architecture Behaivorial;