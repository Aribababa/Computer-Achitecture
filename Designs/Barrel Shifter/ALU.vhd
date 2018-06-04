Library IEEE;
use IEEE.std_logic_1164.all;

Entity ALU is -- ALU 32 bits
	port(
		A, B: in std_logic_vector(31 downto 0);
		Carry_In: std_logic;
		cmd: in std_logic_vector(3 downto 0);
		resultado: out std_logic_vector(31 downto 0)
	);
end entity ALU;

Architecture Behaivorial of ALU is
	
	Component Bit_Shifting is
		port(
			enable: std_logic;
			Op: in std_logic_vector(1 downto 0);
			Bytes_en: in std_logic_vector(31 downto 0);
			Bytes_sal: out std_logic_vector(31 downto 0);
			Shift: in std_logic_vector(31 downto 0)
		);
	end Component Bit_Shifting;
	
	Component mul32c is
		port(
		a, b : in  std_logic_vector(31 downto 0);
      prod : out std_logic_vector(31 downto 0)
	);
	end Component mul32c;
	
	Component adder_32bits is
		port(
			A, B : in std_logic_vector(31 downto 0);
			salida : out std_logic_vector(31 downto 0);
			carryIn: in std_logic;
			overFlow: out std_logic
		);
	end Component adder_32bits;

	Signal sal_BitShifting, sal_sum, sal_mult: std_logic_vector(31 downto 0); 
	Signal enable_shifting, wenoders: std_logic; -- Wenoders es para pruebas
	Signal cmd_shifting: std_logic_vector(1 downto 0);
	Signal default: std_logic_vector(31 downto 0):= (Others => '0');
	
begin
	Seleccionar: Process (CMD) is begin
		Case (CMD) is
			When "0000" => -- AND
				resultado <= A AND B;
				
			When "0001" => -- EOR
				resultado <= A XOR B;
				
			When "0010" => -- LSL
				cmd_shifting <= "01";
				resultado <= sal_BitShifting;
				
			When "0011" => -- LSR
				cmd_shifting <= "00";
				resultado <= sal_BitShifting;
				
			When "0100" => -- ASR
				cmd_shifting <= "10";
				resultado <= sal_BitShifting;
				
			When "0101" => -- ADC
			When "0110" => -- SBC
			When "0111" => -- ROR
				cmd_shifting <= "11";
				resultado <= sal_BitShifting;
				
			When "1000" => -- TST
				Resultado <= default;
				
			When "1001" => -- RSB
			When "1010" => -- CMP
				Resultado <= default;
				
			When "1011" => -- CMN
				Resultado <= default;
				
			When "1100" => -- ORR
				resultado <= A OR B;
				
			When "1101" => -- MUL
				Resultado <= sal_mult;
				
			When "1110" => -- BIC
				resultado <= A AND NOT(B);
				
			When "1111" => -- MVN
				Resultado <= default;
				
		end case;
	end process Seleccionar;
	
	Sumador: adder_32bits port map(
		A=> A, B=> B, salida=> sal_sum ,carryIn=> carry_In ,overFlow=> wenoders
	);
	
	Multiplicador: mul32c port map(
		A=> A, B=> B, Prod=> sal_mult
	);
	
	Shifters: bit_Shifting port map(
			enable=> '1', Op=> cmd_shifting, Bytes_en=> A, Bytes_sal=> sal_BitShifting, Shift=> B
	);
end architecture Behaivorial;