Library IEEE;
Use IEEE.std_logic_1164.all;

Entity Arquitectura_ARM is
	port(
		-- Señal de reloj.
		clk: in std_logic;
		
		-- Señales para instrucction pointer.
		rst_ip, 
		load_ip, 
		inc_ip, 
		get_ip: in std_logic;
		
		-- Señales para el acumulador de datos.
		load_ac, 
		rst_ac, 
		get_ac: in std_logic;
		
		-- Señal para DR
		get_data: in std_logic;
		
		-- Señales para acumulador de flags.
		load_flags, 
		rst_flags, 
		get_flags: in std_logic;
		
		-- Señales para banco de registros.
		Load: in std_logic;
		
		-- Señales para ALU.       
		cmd: in std_logic_vector(6 downto 0);
		
		-- Señales para MUX_alu
		sel: in std_logic;
		
		-- Señales para extend zeros
		sal_3,
		sal_5,
		sal_8,
		sal_11: in std_logic;
		
		-- Señales para AC_INM
		get_inm, 
		load_inm, 
		rst_inm: in std_logic;
		
		-- Señales para MUX_address 01
		sel_mux_address01: in std_logic;
		
		-- Señales para MUX_address 02
		sel_mux_address02: in std_logic;
			
		-- Señales para ext_ip
		load_ext_ip, 
		get_ext_ip, 
		rst_ext_ip: in std_logic;
			
		-- Señales para AC_Address
		load_AC_Address, 
		get_AC_Address, 
		rst_AC_Address: in std_logic;
		
		-- Señal para mux INM
		sel_mux_4a1: in std_logic_vector(1 downto 0);
			
		
		
		-- Señales temporales.
		-- B: in std_logic_vector(31 downto 0); -- temp
		Debig_IP: out std_logic_vector(12 downto 0);
		Debug_MEM: out std_logic_vector(15 downto 0);
		flags: out std_logic_vector(3 downto 0);
		debug_inm: out std_logic_vector(31 downto 0);
		debug_reg: out std_logic_vector(3 downto 0);
		resultado: out std_logic_vector(31 downto 0) -- temp
		--sel_a,sel_b: in std_logic_vector(3 downto 0)
	);
end entity Arquitectura_ARM;

Architecture Behaivorial of Arquitectura_ARM is
-------------------------------------------------
	Component Instruction_pointer is
		port(
			clk : in  std_logic;
			load_ip, get_ip, inc_ip, rst_ip: in std_logic;
			cargar: in std_logic_vector(31 downto 0);
			instruccion: out std_logic_vector(12 downto 0)
		);
	end component Instruction_pointer;
---------------------------------------------------------
	Component Mem_prog is
		port(
			clk: in std_logic;
			Address_in: in std_logic_vector(12 downto 0);
			Address_out: out std_logic_vector(15 downto 0)
		);
	end component Mem_prog;
---------------------------------------------------------
	Component ext_IP is
		Port(
			clk: in std_logic;
			load_ext_ip, get_ext_ip, rst_ext_ip: in std_logic;
			entrada_ip: in std_logic_vector(12 downto 0);
			salida_ip: out std_logic_vector(31 downto 0)
		);
	end component ext_IP;
---------------------------------------------------------
	Component Mux_address is
		Port(
			sel_mux_address: in std_logic;
			Address_A, Address_B: in std_logic_vector(3 downto 0);
			sal_mux_sel: out std_logic_vector(3 downto 0)	
		);
	end component Mux_address;

---------------------------------------------------------
	Component Direcction_register is
		port(
			clk, get_data: in std_logic;
			Instruccion_in: in std_logic_vector(15 downto 0);
			RM, RN, RD, RT: out std_logic_vector(2 downto 0);
			inm3: out std_logic_vector(31 downto 0);
			inm5: out std_logic_vector(31 downto 0);
			inm8: out std_logic_vector(31 downto 0);
			inm11: out std_logic_vector(31 downto 0);
			Instruccion_out: out std_logic_vector(15 downto 0)
		);
	end component Direcction_register;
	---------------------------------------------------------
	Component Mux32_4a1 is
		port(
			Entrada_A,
			Entrada_B,
			Entrada_C,
			Entrada_D: in std_logic_vector(31 downto 0);
			sel_mux_4a1: in std_logic_vector(1 downto 0);
			salida_mux_4a1: out std_logic_vector(31 downto 0)
		);
	end component Mux32_4a1;

	---------------------------------------------------------
--	Component AC_address is
--		port(
--			clk: in std_logic;
--			load_AC_Address, get_AC_Address, rst_AC_Address: in std_logic;
--			RM_in, RN_in, RD_in: in std_logic_vector(2 downto 0);
--			RM_out, RN_out, RD_out: out std_logic_vector(3 downto 0)
--		);
--	end component AC_address;
	---------------------------------------------------------
	Component mux32_2a1 is
		port(
			Entrada_A, Entrada_B: in std_logic_vector(31 downto 0);
			sel_mux32: in std_logic;
			salida_mux32: out std_logic_vector(31 downto 0)
		);
	end component mux32_2a1;

	---------------------------------------------------------
	Component Acumulador_de_registros is
		Port(
			clk: in std_logic;
			get_ac_reg: in std_logic;
			rst_ac_reg: in std_logic;
			registro_RM_in, registro_RN_in, registro_RD_in : in std_logic_vector(2 downto 0);
			registro_RM_out, registro_RN_out, registro_RD_out: out std_logic_vector(3 downto 0)
			);
	end component Acumulador_de_registros;
	---------------------------------------------------------
	Component AC_INM is
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
	end Component AC_INM;
---------------------------------------------------------
	Component ext_zeros is
		port(
			sal_3, sal_5, sal_8, sal_11: in std_logic;
			inm3: in std_logic_vector(2 downto 0);
			inm5: in std_logic_vector(4 downto 0);
			inm8: in std_logic_vector(7 downto 0);
			inm11: in std_logic_vector(10 downto 0);
			salida: out std_logic_vector(31 downto 0)
		);
	end component ext_zeros;
---------------------------------------------------------
	Component Banco_de_registros is
		Port(
			clk, Load: in std_logic;
			dato_in: in std_logic_vector(31 downto 0);
			Sel_a, Sel_b, address: in std_logic_vector(3 downto 0);
			salida_a, salida_b: out std_logic_vector(31 downto 0)
		);
	end component Banco_de_registros;
--------------------------------------------------------------------	
	Component mux_alu is
		port(
			sel: in std_logic;
			registro: in std_logic_vector(31 downto 0);
			inm: in std_logic_vector(31 downto 0);
			B: out std_logic_vector(31 downto 0)
		);
	end component mux_alu;
---------------------------------------------------------------------
	Component ALU is -- ALU 32 bits
		port(
			A, B      : in  std_logic_vector(31 downto 0);
			carry_in  : in std_logic;
			cmd       : in  std_logic_vector(6 downto 0);
			Flags     : out std_logic_vector(3 downto 0); -- OverFlow, Carry out, Negative, Zero
			resultado : out std_logic_vector(31 downto 0)
		);
	end component ALU;
-------------------------------------------------------------	
	Component AC_block is
		port(
			clk: in std_logic;
			load_ac, rst_ac, get_ac: in std_logic;
			numero_in: in std_logic_vector(31 downto 0);
			numero_out: out std_logic_vector(31 downto 0)
		);
	end component AC_block;
	--------------------------------------------------------------
	Component BFlags is
		port(
			load_flags, rst_flags, get_flags: in std_logic;
			Flags_in: in std_logic_vector(3 downto 0);
			Flags_out: out std_logic_vector(3 downto 0)
		);
	end component BFlags;
---------------------------------------------------------
	-- Señales temporales.
	Signal wenoders: std_logic_vector(3 downto 0); -- temp
	Signal wenoders2: std_logic_vector(12 downto 0);
	Signal wenoders4: std_logic_vector(31 downto 0);
	
	-- Señales definitivas
	Signal 	ALU_TO_AC, 
				AC_TO_BUS, 
				BANK_TO_A, 
				BANK_TO_B, 
				MUX_TO_B, 
				EXT_TO_MUX, 
				EXT_IP_TO_BUS: std_logic_vector(31 downto 0);
				
	Signal 	ALU_TO_FLAGS,
				FLAGS_TO_UC, 
				MUX_ADDRESS_TO_BANK, 
				ACR_RM_TO_BANK_A, 
				ACR_RN_TO_MUX, 
				ACR_RD_TO_MUX, 
				MUX_TO_BANK_B: std_logic_vector(3 downto 0);
				
	Signal 	MEM_TO_DR, 
				DR_TO_IP : std_logic_vector(15 downto 0);
				
	Signal IP_TO_MEM: std_logic_vector(12 downto 0);
	
	Signal 	DR_TO_INM3, 
				DR_TO_RM, 
				DR_TO_RN, 
				DR_TO_RD, 
				DR_TO_RT, 
				INM3_TO_EXT: std_logic_vector(2 downto 0);
				
	Signal 	DR_TO_INM5, 
				INM5_TO_EXT: std_logic_vector(4 downto 0);
				
	Signal 	DR_TO_INM8, 
				INM8_TO_EXT: std_logic_vector(7 downto 0);
				
	Signal 	DR_TO_INM11, 
				INM11_TO_EXT: std_logic_vector(10 downto 0);
				
	Signal 	DIR_TO_INM3,
				DIR_TO_INM5,
				DIR_TO_INM8,
				DIR_TO_INM11,
				MUX_INM_TO_MUX_ALU: std_logic_vector(31 downto 0);
	
	-- Valores Constantes
	Constant ADDRESS_IP: std_logic_vector(3 downto 0):="1111";
	
begin

	PC: instruction_pointer port map(
		clk => clk,
		load_ip => load_ip, 
		get_ip => get_ip, 
		inc_ip => inc_ip,
		rst_ip => rst_ip,
		cargar => AC_TO_BUS,
		instruccion => IP_TO_MEM
	);
	
	Extend_zeros_IP: ext_IP port map(
		clk => Clk,
		load_ext_ip => load_ext_ip, 
		get_ext_ip => get_ext_ip, 
		rst_ext_ip => rst_ext_ip,
		entrada_ip => IP_TO_MEM,
		salida_ip => AC_TO_BUS --EXT_IP_TO_BUS
	);
	
	Multiplexor_Para_Banco: Mux_address port map(
		sel_mux_address => sel_mux_address01,
		Address_A => "0" & DR_TO_RD, 
		Address_B => ADDRESS_IP,
		sal_mux_sel	=> MUX_ADDRESS_TO_BANK
	);
	
	Memoria_de_programa: Mem_prog port map(
		clk => CLK,
		Address_in => IP_TO_MEM,
		Address_out => MEM_TO_DR
	);
	
	Dir_reg: Direcction_register port map(
		clk => clk,
		get_data => get_data,
		Instruccion_in => MEM_TO_DR,
		RM => DR_TO_RM, 
		RN => DR_TO_RN, 
		RD => DR_TO_RD, 
		RT => DR_TO_RT,
		inm3 => DIR_TO_INM3,
		inm5 => DIR_TO_INM5,
		inm8 => DIR_TO_INM8,
		inm11 => DIR_TO_INM11,
		Instruccion_out => DR_TO_IP
	);
	-------------------------------------------------------
	Mux_Para_inmediatos: Mux32_4a1 port map(
		Entrada_A => DIR_TO_INM3,
		Entrada_B => DIR_TO_INM5,
		Entrada_C => DIR_TO_INM8,
		Entrada_D => DIR_TO_INM11,
		sel_mux_4a1 => sel_mux_4a1,
		salida_mux_4a1 => MUX_INM_TO_MUX_ALU
	);
	-------------------------------------------------------
--	AcumuladorDeRegistros: Acumulador_de_registros port map(
--		clk => clk,
--		get_ac_reg => get_AC_Address,
--		rst_ac_reg => rst_AC_Address,
--		registro_RM_in => DR_TO_RM, 
--		registro_RN_in => DR_TO_RN,
--		registro_RD_in => DR_TO_RD,
--		registro_RM_out => ACR_RM_TO_BANK_A, 
--		registro_RN_out => ACR_RN_TO_MUX, 
--		registro_RD_out => ACR_RD_TO_MUX
--	);
	
	MUX_Para_Registros: MUX_address port map(
		sel_mux_address => sel_mux_address02,
		Address_A => "0" & DR_TO_RN, 
		Address_B => "0" & DR_TO_RD,
		sal_mux_sel	=> MUX_TO_BANK_B
	);
	
--	Acumulador_de_inmediatos: AC_INM port map(
--		get_inm => get_inm, 
--		load_inm => load_inm, 
--		rst_inm => rst_inm,
--		inm3_in => DR_TO_INM3,
--		inm5_in => DR_TO_INM5,
--		inm8_in => DR_TO_INM8,
--		inm11_in => DR_TO_INM11,
--		inm3_out => INM3_TO_EXT,
--		inm5_out => INM5_TO_EXT,
--		inm8_out => INM8_TO_EXT,
--		inm11_out => INM11_TO_EXT
--	);
	
--	extend_zeros: ext_zeros port map(
--		sal_3 => Sal_3, 
--		sal_5 => Sal_5, 
--		sal_8 => Sal_8, 
--		sal_11 => Sal_11,
--		inm3 => INM3_TO_EXT,
--		inm5 => INM5_TO_EXT,
--		inm8 => INM8_TO_EXT,
--		inm11 => INM11_TO_EXT,
--		salida => EXT_TO_MUX
--	);
	
	Registros: Banco_de_registros port map(
		clk => clk,
		load => load,
		dato_in => AC_TO_BUS,
		Sel_a => ACR_RM_TO_BANK_A,  -----------------
		Sel_b => MUX_TO_BANK_B,     -----------------
		address => MUX_ADDRESS_TO_BANK,
		salida_a => BANK_TO_A,
		Salida_b => BANK_TO_B
	);
	
	Multiplexor: mux_alu port map(
		sel => sel,
		registro => BANK_TO_B,
		inm => MUX_INM_TO_MUX_ALU,
		B => MUX_TO_B
	);

	Unidad_Aritmetica: ALU port map(
		A => BANK_TO_A,
		B => MUX_TO_B,
		Carry_in => FLAGS_TO_UC(1),
		cmd => cmd,
		flags => ALU_TO_FLAGS,
		resultado => ALU_TO_AC
	);
	
	Acumulador: AC_block port map(
		clk => clk,
		load_ac => load_ac, 
		rst_ac => rst_ac, 
		get_ac => get_ac,
		numero_in => ALU_TO_AC,
		numero_out => AC_TO_BUS
	);
	
	Acumulador_de_flags: Bflags port map(
		load_flags => load_flags,
		rst_flags => rst_flags,
		get_flags => get_flags,
		Flags_in => ALU_TO_FLAGS,
		Flags_out => FLAGS_TO_UC
	);
	
---------------------------
	 -- Salida de debug
	resultado <= AC_TO_BUS; --ALU_TO_AC;
	flags <= FLAGS_TO_UC;
	debig_IP <= IP_TO_MEM(12 downto 0);
	debug_MEM <=  MEM_TO_DR;
	debug_inm <=  "00000000000000000000000000000" & INM3_TO_EXT;
	debug_reg <=  ACR_RM_TO_BANK_A;
	
end architecture Behaivorial;