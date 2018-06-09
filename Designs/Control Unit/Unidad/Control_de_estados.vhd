Library IEEE;
	Use IEEE.std_logic_1164.all;
	Use IEEE.numeric_std.all;
	
Entity Control_de_estados is
	port(
		clk: in std_logic;
		instruccion: in std_logic_vector(15 downto 0);
		instruccion_O: out std_logic_vector(15 downto 0);
		estadoActual: out std_logic_vector(9 downto 0)
	);
end entity Control_de_estados;

Architecture Behaivorial of Control_de_estados is
	Type estados is (
		Fetch01, Fetch02, Fetch03,
		ADD_INM_01, ADD_INM_02,
		ADD_REG_01, ADD_REG_02,
		B_01, B_02,
		AND_REG_01,AND_REG_02,
		MUL_01, MUL_02
		
	);
	
	Signal pr_state, nx_state, salto_de_estado: estados;
	Signal Instruccion_actual: std_logic_vector(15 downto 0);
	
begin

	Cambio_de_estado: Process(clk) is begin
		if rising_edge(clk) then
			pr_state <= nx_state;
		else null;
		end if;
	end process Cambio_de_estado;
	
	Maquina_de_estado: Process(pr_state) is begin
		case(pr_state) is
		
			When Fetch01 =>
				estadoActual <= "0000000000";  -- 0
				nx_state <= Fetch02;
				
			When Fetch02 =>
				estadoActual <= "0000000001";  -- 1
				instruccion_actual <= instruccion;
				nx_state <= Fetch03;
			
			When Fetch03 => 
				estadoActual <= "0000000010";  -- 2
				if (instruccion_actual(15 downto 9) = "0001110") then
					nx_state <= ADD_INM_01;
				elsif (instruccion_actual(15 downto 9) = "0001100") then
					nx_state <= ADD_REG_01;
				elsif (instruccion_actual(15 downto 12) = "1101") then
					nx_state <= B_01;
				elsif (instruccion_actual(15 downto 6) = "0100000000") then
					nx_state <= AND_REG_01;
				else 
					nx_state <= Fetch01;
				end if;
--------------------------------------------------------		
			When ADD_INM_01 =>
				instruccion_O <= instruccion_actual;
				estadoActual <= "0000000011"; -- 3
				nx_state <= ADD_INM_02;
			
			When ADD_INM_02 =>
				instruccion_O <= instruccion_actual;
				estadoActual <= "0000000100"; -- 4
				nx_state <= Fetch01;
----------------------------------------------------------
			When ADD_REG_01 =>
				instruccion_O <= instruccion_actual;
				EstadoActual <= "0000000101"; -- 5
				nx_state <= ADD_REG_02;
			
			When ADD_REG_02 => 
				instruccion_O <= instruccion_actual;
				EstadoActual <= "0000000110"; -- 6
				nx_state <= Fetch01;
-----------------------------------------------------------	
			When B_01 =>
				instruccion_O <= instruccion_actual;
				EstadoActual <= "0000000111"; -- 7
				nx_state <= B_02;
				
			When B_02 =>
				instruccion_O <= instruccion_actual;
				EstadoActual <= "0000001000"; -- 8
				nx_state <= Fetch01;
---------------------------------------------------------
			When AND_REG_01 =>
				instruccion_O <= instruccion_actual;
				EstadoActual <= "0000001001"; -- 9
				nx_state <= AND_REG_02;
				
			When AND_REG_02 =>
				instruccion_O <= instruccion_actual;
				EstadoActual <= "0000001010"; -- 10
				nx_state <= Fetch01;
-------------------------------------------------------
			When MUL_01 =>
				instruccion_O <= instruccion_actual;
				EstadoActual <= "0000001011"; -- 11
				nx_state <= MUL_02;
				
			When MUL_02 =>
				instruccion_O <= instruccion_actual;
				EstadoActual <= "0000001100"; -- 12
				nx_state <= Fetch01;
			
				
			When Others => null;
			
		end case;
	end process Maquina_de_estado;
	
end architecture Behaivorial;