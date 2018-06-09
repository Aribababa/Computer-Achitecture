Library IEEE;
	Use IEEE.std_logic_1164.all;
	Use IEEE.numeric_std.all;
	
Entity Decoder_UC is
	port(
		clk: in std_logic;
		EstadoActual: in std_logic_vector(9 downto 0);
		instruccion: in std_logic_vector(15 downto 0);
		RM,
		RN,
		RD,
		RT
			: out std_logic_vector(3 downto 0);
		inm3,
		inm5,
		inm8,
		inm11
			: out std_logic_vector(31 downto 0);
		sel_mux_reg_A,
		sel_mux_reg_B,
		sel_mux_reg_C,
		Sel_mux_inm
						:out std_logic_vector(1 downto 0);
		sel_mux_datos
						:out std_logic;
		cmd_alu
						:out std_logic_vector(6 downto 0);
		load_ip, 
		get_ip, 
		inc_ip, 
		rst_ip
				: out std_logic;
		load_ac, 
		rst_ac, 
		get_ac
					: out std_logic;
		load_flags, 
		rst_flags, 
		get_flags
					: out std_logic;
		enable
				: out std_logic;	
		load_bank
				: out std_logic;
		get_AD, 
		load_AD, 
		rst_AD
				: out std_logic;
		RWS
				:out std_logic
	);
end entity Decoder_UC;

Architecture Behaivorial of Decoder_UC is
begin 

	RM <= (Others => '0');
	
	RN  <= "0" & instruccion(5 downto 3) when
								EstadoActual = "0000000011" OR-- ADD_INM_01
								EstadoActual = "0000000100"	-- ADD_INM_02
		else (Others => '0');
	
	RD <= "0" & instruccion(2 downto 0) when
								EstadoActual = "0000000011" OR-- ADD_INM_01
								EstadoActual = "0000000100"	-- ADD_INM_02
		else (Others => '0');
	
	RT <= (Others => '0');
	
	inm3  <= "00000000000000000000000000000" & instruccion(8 downto 6) when
								estadoActual = "0000000011" OR -- ADD_INM_01
								estadoActual = "0000000100"    -- ADD_INM_02
		else (Others => '0');
		
	inm5 <= (Others => '0');
		
	inm8 <= (Others => '0');
		
	inm11 <= (Others => '0');
	
	sel_mux_reg_A <= "01" when
								estadoActual <= "0000000011" 	-- ADD_INM_01
		else (Others => '0');
		
	sel_mux_reg_B <= "00" When
								estadoActual <= "0000000011" -- ADD_INM_01
		else (Others => '0');
	
	sel_mux_reg_C <= "10" when
								estadoActual <= "0000000100" 	-- ADD_INM_02
		else (Others => '0');
	
	Sel_mux_inm <= "00" when 
								estadoActual <= "0000000011" -- ADD_INM_01
		else (Others => '0');
	
	sel_mux_datos <= '1' when
								estadoActual <= "0000000011" -- ADD_INM_01
		else '0';
	
	cmd_alu <= "0000000" when
								estadoActual <= "0000000011" -- ADD_INM_01
		else (Others => '0');
	
	load_ip <= '0'; 
		
	get_ip <= '1' when 	estadoActual = "0000000000"  	-- Fetch 01
		else '0';
	
	inc_ip <= '1' when 	estadoActual = "0000000001" 	-- Fetch 02
		else '0';
	
	rst_ip <= '0';
	
	load_ac <= '1' when estadoActual = "0000000011" 	-- ADD_INM_01
		else '0';
		
	rst_ac <= '0'; 
		
	get_ac <= '1' when 	estadoActual = "0000000100" 	-- ADD_INM_02
		else '0';
	
	load_flags <= '1' when 	
								estadoActual = "0000000011" 	-- ADD_INM_01
		else '0';
		
	rst_flags <= '0'; 
		
	get_flags <= '0';
	
	enable <= '1' when 	estadoActual = "0000000001" 	-- Fetch 03
		else '0';
	
	load_bank <= '0';
	
	get_AD <= '0';
		
	load_AD <= '0';
		
	rst_AD <= '0';

	RWS <= '0';

end architecture Behaivorial;