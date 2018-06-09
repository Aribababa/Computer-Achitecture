LIBRARY IEEE;
	Use IEEE.std_logic_1164.all;
	Use IEEE.numeric_std.all;

	
ENTITY MemoriaRAM IS
	PORT(	
		CLK: IN STD_LOGIC;
		WR: IN STD_LOGIC;
		ADRESS: IN STD_LOGIC_VECTOR(12 DOWNTO 0);
		DATA_IN: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		DATA_OUT: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END MemoriaRAM;

architecture Behaivorial of MemoriaRAM is
	TYPE RAM_TYPE IS ARRAY (63 downto 0) of std_logic_vector(31 DOWNTO 0);
	SIGNAL MYRAM: RAM_TYPE;
BEGIN	
	PROCESS(CLK) is begin
		--Lectura=1
		--Escritura=0
		IF(rising_edge(clk))THEN
			IF(WR='0')THEN
				DATA_OUT <= (Others => 'Z');
				MYRAM(to_integer(Unsigned(adrESS))) <= DATA_IN;
			ELSE
				DATA_OUT <= MYRAM(to_integer(Unsigned(adrESS)));
			END IF;
		END IF;
	END PROCESS;
END architecture Behaivorial;