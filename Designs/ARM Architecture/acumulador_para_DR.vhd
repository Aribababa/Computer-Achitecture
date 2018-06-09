Library IEEE;
	Use IEEE.std_logic_1164.all;
	
Entity Acumulador_para_DR is
	port(
		clk: in std_logic;
		load_ac_dr, get_ac_dr, rst_ac_dr: in std_logic;
		RM,
		RN,
		RD,
		RT
			: in std_logic_vector(2 downto 0);
		INM3,
		INM5,
		INM8,
		INM11
			: in std_logic_vector(31 downto 0);
			
		RM_O,
		RN_O,
		RD_O,
		RT_O
			: out std_logic_vector(2 downto 0);
		INM3_O,
		INM5_O,
		INM8_O,
		INM11_O
			: out std_logic_vector(31 downto 0)
		
	);
end entity acumulador_para_DR;

Architecture Behaivorial of Acumulador_para_DR is

	Signal 	SRM,
				SRN,
				SRD,
				SRT
					:std_logic_vector(2 downto 0);
				
	Signal 	SINM3,
				SINM5,
				SINM8,
				SINM11
					: std_logic_vector(31 downto 0);
begin
	
	Acumular: Process(clk) is begin
		if rising_edge(clk) then
			if (load_ac_dr = '1') then
				SRM <= RM;
				SRN <= RN;
				SRD <= RD;
				SRT <= RT;				
				SINM3 <= INM3;
				SINM5 <= INM5;
				SINM8 <= INM8;
				SINM11 <= INM11;
				
				RM_O <= (Others => 'Z');
				RN_O <= (Others => 'Z');
				RD_O <= (Others => 'Z');
				RT_O <= (Others => 'Z');
				INM3_O <= (Others => 'Z');
				INM5_O <= (Others => 'Z');
				INM8_O <= (Others => 'Z');
				INM11_O <= (Others => 'Z');
				
			elsif (get_ac_dr = '1') then
				RM_O <= SRM;
				RN_O <= SRN;
				RD_O <= SRD;
				RT_O <= SRT;
				INM3_O <= SINM3;
				INM5_O <= SINM5;
				INM8_O <= SINM8;
				INM11_O <= SINM11;
			
			elsif (rst_ac_dr = '1') then
				SRM <= (Others => '0');
				SRN <= (Others => '0');
				SRD <= (Others => '0');
				SRT <= (Others => '0');				
				SINM3 <= (Others => '0');
				SINM5 <= (Others => '0');
				SINM8 <= (Others => '0');
				SINM11 <= (Others => '0');
			
			else 
				RM_O <= (Others => 'Z');
				RN_O <= (Others => 'Z');
				RD_O <= (Others => 'Z');
				RT_O <= (Others => 'Z');
				INM3_O <= (Others => 'Z');
				INM5_O <= (Others => 'Z');
				INM8_O <= (Others => 'Z');
				INM11_O <= (Others => 'Z');	
			end if;
		else null;
		end if;
	end process Acumular;
end architecture Behaivorial;