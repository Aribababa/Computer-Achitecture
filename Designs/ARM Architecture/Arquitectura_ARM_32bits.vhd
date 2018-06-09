Library IEEE;
	Use IEEE.std_logic_1164.all;
	Use IEEE.numeric_std.all;
	
Entity Arquitectura_ARM_32bits is
	port(
		clk: in std_logic;
		-- Entradas de datos
		RM,
		RN,
		RD,
		RT
			: in std_logic_vector(3 downto 0);
		
		inm3,
		inm5,
		inm8,
		inm11
			: in std_logic_vector(31 downto 0);
		-- Selctor de registros
		sel_mux_reg_A,
		sel_mux_reg_B,
		sel_mux_reg_C,
		Sel_mux_inm
						:in std_logic_vector(1 downto 0);
		sel_mux_datos
						:in std_logic;
		-- Control de ALU
		cmd_alu
						:in std_logic_vector(6 downto 0);
		-- Control para PC
		load_ip, 
		get_ip, 
		inc_ip, 
		rst_ip
				: in std_logic;
		-- Control para Acumulador_de_datos
		load_ac, 
		rst_ac, 
		get_ac
					: in std_logic;
		-- Control pata acumulador_de_banderas
		load_flags, 
		rst_flags, 
		get_flags
					: in std_logic;
		-- Control para ROM
		enable
				: in std_logic;
		Address_out
				: out std_logic_vector(15 downto 0);
		-- Control para banco		
		load_bank
				: in std_logic;
		-- Control para Address Register	
		get_AD, 
		load_AD, 
		rst_AD
				: in std_logic;
		-- Control para RAM
		RWS
				:in std_logic;
	-----------------------
	debug_result: out std_logic_vector(31 downto 0)
	);
end entity Arquitectura_ARM_32bits;

Architecture Behaivorial of Arquitectura_ARM_32bits is

	Component divisor_de_frecuencia is
		port(
			Clk_in: in std_logic;
			Clk_out: out std_logic
		);
	end Component divisor_de_frecuencia;

	Component Instruction_pointer is
		port(
			clk : in  std_logic;
			load_ip, get_ip, inc_ip, rst_ip: in std_logic;
			cargar: in std_logic_vector(31 downto 0);
			instruccion: out std_logic_vector(12 downto 0)
		);
	end component Instruction_pointer;
	
	Component Mem_prog is
		port(
			clk: in std_logic;
			enable: in std_logic;
			Address_in: in std_logic_vector(12 downto 0);
			Address_out: out std_logic_vector(15 downto 0)
		);
	end component Mem_prog;
	
	component Mux_registros is
		port(
			Entrada_A,
			Entrada_B,
			Entrada_C,
			Entrada_D: in std_logic_vector(3 downto 0);
			sel_mux_reg: in std_logic_vector(1 downto 0);
			salida_mux_reg: out std_logic_vector(3 downto 0)
		);
	end component Mux_registros;
	
	component mux32_2a1 is
		port(
			Entrada_A, Entrada_B: in std_logic_vector(31 downto 0);
			sel_mux32: in std_logic;
			salida_mux32: out std_logic_vector(31 downto 0)
		);
	end component mux32_2a1;
	
	component Mux32_4a1 is
		port(
			Entrada_A,
			Entrada_B,
			Entrada_C,
			Entrada_D: in std_logic_vector(31 downto 0);
			sel_mux_4a1: in std_logic_vector(1 downto 0);
			salida_mux_4a1: out std_logic_vector(31 downto 0)
		);
	end component Mux32_4a1;
	
	component Banco_de_registros is
		Port(
			clk, Load: in std_logic;
			dato_in: in std_logic_vector(31 downto 0);
			Sel_a, Sel_b, address: in std_logic_vector(3 downto 0);
			salida_a, salida_b: out std_logic_vector(31 downto 0)
		);
	end component Banco_de_registros;
	
	
	component ALU is -- ALU 32 bits
		port(
			A, B      : in  std_logic_vector(31 downto 0);
			carry_in  : in std_logic;
			cmd       : in  std_logic_vector(6 downto 0);
			Flags     : out std_logic_vector(3 downto 0); -- OverFlow, Carry out, Negative, Zero
			resultado : out std_logic_vector(31 downto 0)
		);
	end component ALU;
	
	component AC_block is
		port(
			clk: in std_logic;
			load_ac, 
			rst_ac, 
			get_ac: in std_logic;
			numero_in: in std_logic_vector(31 downto 0);
			numero_out: out std_logic_vector(31 downto 0)
		);
	end component AC_block;
	
	component BFlags is
		port(
			load_flags, 
			rst_flags, 
			get_flags: in std_logic;
			Flags_in: in std_logic_vector(3 downto 0);
			Flags_out: out std_logic_vector(3 downto 0)
		);
	end component BFlags; 
	
	component Address_register is
		port(
			clk: in std_logic;
			get_AD, load_AD, rst_AD: in std_logic;
			Add_in: in std_logic_vector(31 downto 0);
			Add_out: out std_logic_vector(12 downto 0)
		);
	end component Address_register;
	
	component memoriaRam is
		port(	
			clk: in std_logic;
			wr: in std_logic;
			adress: in std_logic_vector(12 downto 0);
			data_in: in std_logic_vector(31 downto 0);
			data_out: out std_logic_vector(31 downto 0)
		);
	end component memoriaRam;

	
	
	
	---------------------Signal------------------------------------
	Signal	clk_dr
								: std_logic;
								
	Signal 	SAL_MUX_TO_SEL_A,
				SAL_MUX_TO_SEL_B,
				SAL_MUX_TO_ADDRESS_BANK,
				ALU_TO_FLAGS,
				FLAGS_TO_UC
								: std_logic_vector(3 downto 0);
								
	
	Signal 	IP_TO_MEM,
				ADDRESS_TO_RAM
								: std_logic_vector(12 downto 0);
								
	Signal 	MEM_TO_DR
								: std_logic_vector(15 downto 0);
	
	Signal 	BUS_DE_DATOS,
				A_TO_ALU_A,
				B_TO_ALU_B,
				MUX_TO_ALU_B,
				INM_TO_MUX,
				ALU_TO_AC
								:std_logic_vector(31 downto 0);
	
begin
	PC: instruction_pointer port map(
		clk => clk,
		load_ip => load_ip, 
		get_ip => get_ip, 
		inc_ip => inc_ip,
		rst_ip => rst_ip,
		cargar => BUS_DE_DATOS,
		instruccion => IP_TO_MEM
	);
	
	Memoria_de_programa: Mem_prog port map(
		clk => CLK,
		enable => enable,
		Address_in => IP_TO_MEM,
		Address_out => Address_out
	);
	
	Mux_para_selector_A: mux_registros port map(
		Entrada_A => RM,
		Entrada_B => RN,
		Entrada_C => RD,
		Entrada_D => RT,
		sel_mux_reg => sel_mux_reg_A,
		salida_mux_reg => SAL_MUX_TO_SEL_A
	);
	
	Mux_para_selector_B: mux_registros port map(
		Entrada_A => RM,
		Entrada_B => RN,
		Entrada_C => RD,
		Entrada_D => RT,
		sel_mux_reg => sel_mux_reg_B,
		salida_mux_reg => SAL_MUX_TO_SEL_B
	);
	
	Mux_para_selector_C: mux_registros port map(
		Entrada_A => RM,
		Entrada_B => RN,
		Entrada_C => RD,
		Entrada_D => "1111",
		sel_mux_reg => sel_mux_reg_C,
		salida_mux_reg => SAL_MUX_TO_ADDRESS_BANK
	);
	
	BancoDeRegistros: banco_de_registros port map(
		clk => clk, 
		Load => load_bank,
		dato_in => BUS_DE_DATOS,
		Sel_a => SAL_MUX_TO_SEL_A, 
		Sel_b => SAL_MUX_TO_SEL_B, 
		address => SAL_MUX_TO_ADDRESS_BANK,
		salida_a => A_TO_ALU_A, 
		salida_b => B_TO_ALU_B
	);
	
	Muliplexor_de_inmediatos: mux32_4a1 port map(
		Entrada_A => inm3,
		Entrada_B => inm5,
		Entrada_C => inm8,
		Entrada_D => inm11,
		sel_mux_4a1 => Sel_mux_inm,
		salida_mux_4a1 => INM_TO_MUX
	);
	
	Multiplexor_para_datos: mux32_2a1 port map(
		Entrada_A => B_TO_ALU_B, 
		Entrada_B => INM_TO_MUX,
		sel_mux32 => sel_mux_datos,
		salida_mux32 => MUX_TO_ALU_B
	);
	
	Unidad_aritmetico: ALU port map(
		A => A_TO_ALU_A, 
		B => MUX_TO_ALU_B,
		carry_in => FLAGS_TO_UC(1),
		cmd => cmd_alu,
		Flags => ALU_TO_FLAGS,
		resultado => ALU_TO_AC
	);
	
	Acumulador_de_datos: AC_block port map(
		clk => clk,
		load_ac => load_ac, 
		rst_ac => rst_ac, 
		get_ac => get_ac,
		numero_in => ALU_TO_AC,
		numero_out => BUS_DE_DATOS
	);
	
	Acumulador_de_banderas: BFlags port map(
		load_flags => load_flags, 
		rst_flags => rst_flags, 
		get_flags => get_flags,
		Flags_in => ALU_TO_FLAGS,
		Flags_out => FLAGS_TO_UC
	);
	
	AddressRegister: address_register port map(
		clk => clk,
		get_AD => get_AD, 
		load_AD => load_AD, 
		rst_AD => rst_AD,
		Add_in => BUS_DE_DATOS,
		Add_out => ADDRESS_TO_RAM
	);
	
	RAM: memoriaRam port map(
		clk => clk,
		wr => RWS,
		adress => ADDRESS_TO_RAM,
		data_in => BUS_DE_DATOS,
		data_out => BUS_DE_DATOS
	);
	
	
	
	debug_result <= BUS_DE_DATOS;
	
end architecture Behaivorial;