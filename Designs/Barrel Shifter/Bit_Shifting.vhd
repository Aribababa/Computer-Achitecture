Library IEEE;
use IEEE. std_logic_1164.all;

Entity Bit_Shifting is
	port(
		enable: std_logic;
		Op: in std_logic_vector(1 downto 0);
		Bytes_en: in std_logic_vector(31 downto 0);
		Bytes_sal: out std_logic_vector(31 downto 0);
		Shift: in std_logic_vector(31 downto 0)
	);
end entity Bit_Shifting;

Architecture Behaivorial of Bit_Shifting is
	
	Component Logic_Shift_Left is
		port(
			Bytes: in std_logic_vector(31 downto 0);
			Bytes_salida: out std_logic_vector(31 downto 0);
			Shift: in std_logic_vector(7 downto 0)
		);
	end Component Logic_Shift_Left;

	Component Logic_Shift_Right is
		port(
			Bytes: in std_logic_vector(31 downto 0);
			Bytes_salida: out std_logic_vector(31 downto 0);
			Shift: in std_logic_vector(7 downto 0)
		);
	end Component Logic_Shift_Right;

	Component Arithmetic_Shift_Right is
		port(
			Bytes_entrada: in std_logic_vector(31 downto 0);
			Bytes_salida: out std_logic_vector(31 downto 0);
			Shift: in std_logic_vector(7 downto 0)
		);
	end Component Arithmetic_Shift_Right;

	Component RotateRight is
		port(
			Bytes_entrada: in std_logic_vector(31 downto 0);
			Bytes_salida: out std_logic_vector(31 downto 0);
			Rotate: in std_logic_vector(7 downto 0)
		);
	end Component RotateRight;
	
	Signal LSR_sal, LSL_sal, ASR_sal, ROR_sal: std_logic_vector(31 downto 0); --Salidas a selecccionar
begin

	Seleccionar: Process (enable, op) is begin
		if (enable = '1') then
			case(op) is
				When "00" => -- LSR
					Bytes_sal <= LSR_sal;
				When "01" => -- LSL
					Bytes_sal <= LSL_sal;
				When "10" => -- ASR
					Bytes_sal <= ASR_sal;
				When "11" => -- ROR
					Bytes_sal <= ROR_sal;
			end case;
		else
			Bytes_sal <= Bytes_en;
		end if;
	end process Seleccionar;

	LSR: logic_Shift_Right port map (
		Bytes=> Bytes_en, Bytes_salida=> LSR_sal, Shift=> Shift(7 downto 0)
	);
	
	LSL: Logic_Shift_Left port map(
		Bytes=> Bytes_en, Bytes_salida=> LSL_sal, Shift=> Shift(7 downto 0)
	);
	
	ASR: Arithmetic_Shift_Right port map(
		Bytes_entrada=> Bytes_en, Bytes_salida=> ASR_sal, Shift=> Shift(7 downto 0)
	);
	
	NotROR: RotateRight port map(
		Bytes_entrada=> Bytes_en, Bytes_salida=> ROR_sal, Rotate=> Shift(7 downto 0)
	);
end architecture Behaivorial;