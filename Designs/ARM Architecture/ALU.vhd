Library IEEE;
use IEEE.std_logic_1164.all;

Entity ALU is -- ALU 32 bits
	port(
		A, B      : in  std_logic_vector(31 downto 0);
		carry_in  : in std_logic;
		cmd       : in  std_logic_vector(6 downto 0);
		Flags     : out std_logic_vector(3 downto 0); -- OverFlow, Carry out, Negative, Zero
		resultado : out std_logic_vector(31 downto 0)
	);
end entity ALU;

Architecture Behaivorial of ALU is

	function IsZero(a : std_logic_vector(31 downto 0)) return std_logic;
	function REV(a : std_logic_vector(31 downto 0)) return std_logic_vector;
	function REV16(a : std_logic_vector(31 downto 0)) return std_logic_vector;
	function REVSH(a : std_logic_vector(31 downto 0)) return std_logic_vector;
	function SXTB(a : std_logic_vector(31 downto 0)) return std_logic_vector;
	function SXTH(a : std_logic_vector(31 downto 0)) return std_logic_vector;
	function UXTB(a : std_logic_vector(31 downto 0)) return std_logic_vector;
	function UXTH(a : std_logic_vector(31 downto 0)) return std_logic_vector;
	
	function REV(a : std_logic_vector(31 downto 0)) return std_logic_vector is
		Variable returnable : std_logic_vector(31 downto 0);
	begin
		returnable(31 downto 24) := a(7 downto 0);
		returnable(23 downto 16) := a(15 downto 8);
		returnable(15 downto 8)  := a(23 downto 16);
		returnable(7 downto 0)   := a(31 downto 24);
		return returnable;
	end function REV;

	function REV16(a : std_logic_vector(31 downto 0)) return std_logic_vector is
		Variable returnable : std_logic_vector(31 downto 0);
	begin
		returnable(31 downto 24) := a(23 downto 16);
		returnable(23 downto 16) := a(31 downto 24);
		returnable(15 downto 8)  := a(7 downto 0);
		returnable(7 downto 0)   := a(15 downto 8);
		return returnable;
	end function REV16;
	
	function REVSH(a : std_logic_vector(31 downto 0)) return std_logic_vector is
		Variable returnable : std_logic_vector(31 downto 0);
	begin
		if (a(7) = '1') then
			returnable(31 downto 0) := x"FFFFFF" & a(7 downto 0);
		else 
			returnable(31 downto 0) := x"000000" & a(7 downto 0);
		end if;
		returnable(7 downto 0) := a(15 downto 8);
		return returnable;
	end function REVSH;
	
	function IsZero(a : std_logic_vector(31 downto 0)) return std_logic is
		Variable zero: std_logic;
	begin
		if (a = x"00000000") then
			zero := '1';
		else
			zero := '0';
		end if;
		return zero;
	end function IsZero;
	
	function SXTB(a : std_logic_vector(31 downto 0)) return std_logic_vector is
		Variable returnable : std_logic_vector(31 downto 0);
	begin
		if (a(7) = '1') then
			returnable:= x"FFFFFF" & a(7 downto 0);
		else
			returnable:= x"000000" & a(7 downto 0);
		end if;
		return returnable;
	end function SXTB;
	
	function SXTH(a : std_logic_vector(31 downto 0)) return std_logic_vector is
		Variable returnable : std_logic_vector(31 downto 0);
	begin
		if (a(15) = '1') then
			returnable:= x"FFFF" & a(15 downto 0);
		else
			returnable:= x"0000" & a(15 downto 0);
		end if;
		return returnable;
	end function SXTH;
	
	function UXTB(a : std_logic_vector(31 downto 0)) return std_logic_vector is
		Variable returnable : std_logic_vector(31 downto 0);
	begin
		returnable:= x"000000" & a(7 downto 0);
		return returnable;
	end function UXTB;
	
	function UXTH(a : std_logic_vector(31 downto 0)) return std_logic_vector is
		Variable returnable : std_logic_vector(31 downto 0);
	begin
		returnable:= x"0000" & a(15 downto 0);
		return returnable;
	end function UXTH;
	
	
---------------------------------------------------------------------------------
	Component Bit_Shifting is
		port(
			enable    : std_logic;
			Op        : in  std_logic_vector(1 downto 0);
			Bytes_en  : in  std_logic_vector(31 downto 0);
			Bytes_sal : out std_logic_vector(31 downto 0);
			Shift     : in  std_logic_vector(31 downto 0)
		);
	end Component Bit_Shifting;

	Component mul32c is
		port(
			a, b : in  std_logic_vector(31 downto 0);
			prod : out std_logic_vector(31 downto 0)
		);
	end Component mul32c;
	
	Component bmul32 is 
		port (
			a : in  std_logic_vector(31 downto 0);
			b : in  std_logic_vector(31 downto 0);
			p : out std_logic_vector(63 downto 0)
		);
	end Component bmul32;

	Component adder_32bits is
		port(
			A, B     : in  std_logic_vector(31 downto 0);
			salida   : out std_logic_vector(31 downto 0);
			carryIn  : in  std_logic;
			overFlow : out std_logic
		);
	end Component adder_32bits;

	Signal AM, BM, SalidaMult, SalidaBS, SalidaSuma, salidaFlags, Ac2, Bc2 : std_logic_vector(31 downto 0); --Señales para controlar las operaciiones internas
	Signal wenoders, wenoders1, wenoders2, carryIn, OV, Zero, Neg          : std_logic; -- Señales legendarias.
	Signal cmd_shifting                                                    : std_logic_vector(1 downto 0);

begin
	Seleccionar : Process(cmd) is
	begin
		AM <= A;
		BM <= B;
		case (cmd) is
			when "0000000" =>           -- ADD
				salidaFlags <= salidaSuma; carryIn <= '0';

			when "0000001" =>           -- MUL
				salidaFlags <= salidaMult;

			when "0000010" =>           -- LSR
				cmd_shifting <= "00";
				salidaFlags  <= salidaBS;

			when "0000011" =>           -- LSL
				cmd_shifting <= "01";
				salidaFlags  <= salidaBS;

			when "0000100" =>           -- ASR
				cmd_shifting <= "10";
				salidaFlags  <= salidaBS;

			when "0000101" =>				 -- ROR
				cmd_shifting <= "11";
				salidaFlags  <= salidaBS;

			when "0000110" =>           -- AND
				salidaFlags <= A AND B;

			when "0000111" =>           -- BIC
				salidaFlags <= A AND NOT (B);
				
			when "0001000" =>           -- MVN
				salidaFlags <= NOT(A);
			
			when "0001001" =>           -- ORR
				salidaFlags <= A OR B;
				
			when "0001010" =>           -- EOR
				salidaFlags <= A XOR B;
				
			when "0001011" =>           -- SUB
				BM <= Bc2; salidaFlags <= salidaSuma; carryIn <= '0';
				
			when "0001100" =>				-- REV
				salidaFlags <= REV(AM);
				
			when "0001101" =>				-- REV16
				salidaFlags <= REV16(AM);
				
			when "0001110" =>				-- REVSH
				salidaFlags <= REVSH(A);
				
			when "0001111" =>      		-- ADC
				salidaFlags <= salidaSuma; carryIn <= carry_in;
				
			when "0010000" =>      		-- SBC
				BM <= Bc2; salidaFlags <= salidaSuma; carryIn <= carry_in;
				
			when "0010001" =>  			-- SXTB
				salidaFlags <= SXTB(AM);
				
			when "0010010" =>  			-- SXTH
				salidaFlags <= SXTH(AM);
				
			when "0010011" =>  			-- UXTB
				salidaFlags <= UXTB(AM);
				
			when "0010100" =>  			-- UXTH
				salidaFlags <= UXTH(AM);
			
			when "0010101" =>  			-- Paso libre A
				salidaFlags <= A AND x"FFFFFFFF";
				
			when "0010110" =>  			-- Paso libre B
				salidaFlags <= x"FFFFFFFF" AND B;
				
			when others =>
		end case;
	end process Seleccionar;

	Actualizar_Flags : Process(salidaFlags) is
	begin
		Flags(0) <= NOT (AM(31) XOR BM(31)) AND salidaFlags(31);
		Flags(1) <= wenoders;
		Flags(2) <= salidaFlags(31);
		Flags(3) <= IsZero(salidaFlags);
		resultado <= salidaFlags;
	end process Actualizar_Flags;

	-----------------------Entidades----------------------------------------------------
	Sumador : adder_32bits port map(
			A => Am, B => Bm, salida => salidaSuma, carryIn => carryIn, overFlow => wenoders
		);

	ComplA2_A : adder_32bits port map(
			A => Not (A), B => x"00000001", salida => Ac2, carryIn => '0', overFlow => wenoders1
		);

	ComplA2_B : adder_32bits port map(
			A => Not (B), B => x"00000001", salida => Bc2, carryIn => '0', overFlow => wenoders2
		);

	Multiplicador : mul32c port map(
			A => Am, B => Bm, Prod => salidaMult
		);

		
--	Multiplicador_Booth: bmul32 port map(
--		a => Am,
--		b => Bm,
--		p(31 downto 0) => salidaMult
--	);
	
	Shifters : bit_Shifting port map(
			enable => '1', Op => cmd_shifting, Bytes_en => A, Bytes_sal => salidaBS, Shift => B
		);

end architecture Behaivorial;
