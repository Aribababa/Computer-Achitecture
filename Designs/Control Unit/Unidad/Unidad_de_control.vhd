Library IEEE;
	Use IEEE.std_logic_1164.all;
	Use IEEE.numeric_std.all;
	
Entity Unidad_de_control is
	port(
		clk: in std_logic;
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
end entity Unidad_de_control;

Architecture Behaivorial of Unidad_de_control is

	Component Control_de_estados is
		port(
			clk: in std_logic;
			instruccion: in std_logic_vector(15 downto 0);
			instruccion_O: out std_logic_vector(15 downto 0);
			estadoActual: out std_logic_vector(9 downto 0)
		);
	end Component Control_de_estados;
	
	Component Decoder_UC is
		port(
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
	end component Decoder_UC;
	
	
	
	Signal Pasa_Estados: std_logic_vector(9 downto 0);
	Signal Pasa_instrucciones: std_logic_vector(15 downto 0);
begin

	MaquinaDeEstados: Control_de_estados port map(
		clk => clk,
		instruccion => Instruccion,
		instruccion_O => Pasa_instrucciones,
		estadoActual => Pasa_Estados
	);
	
	Decodificador: Decoder_UC port map(
		EstadoActual => Pasa_Estados,
		instruccion => Pasa_instrucciones,
		RM => RM,
		RN => RN,
		RD => RD,
		RT => RT,
		inm3 => inm3,
		inm5 => inm5,
		inm8 => inm8,
		inm11 => inm11,
		sel_mux_reg_A => sel_mux_reg_A,
		sel_mux_reg_B => sel_mux_reg_B,
		sel_mux_reg_C => sel_mux_reg_C,
		Sel_mux_inm => sel_mux_inm,
		sel_mux_datos => sel_mux_datos,
		cmd_alu => cmd_alu,
		load_ip => load_ip, 
		get_ip => get_ip, 
		inc_ip => inc_ip, 
		rst_ip => rst_ip,
		load_ac => load_ac, 
		rst_ac => rst_ac, 
		get_ac => get_ac,
		load_flags => load_flags, 
		rst_flags => rst_flags, 
		get_flags => get_flags,
		enable => enable,
		load_bank => load_bank,
		get_AD => get_AD, 
		load_AD => load_AD, 
		rst_AD => rst_AD,
		RWS => RWS
	);
end architecture Behaivorial;