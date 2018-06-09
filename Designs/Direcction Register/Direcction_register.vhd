Library IEEE;
Use IEEE.std_logic_1164.all;

Entity Direcction_register is
	port(
		clk, 
		load_dr,
		rst_dr: in std_logic;
		Instruccion_in: in std_logic_vector(15 downto 0);
		RM, RN, RD, RT: out std_logic_vector(2 downto 0);
		inm3: out std_logic_vector(2 downto 0);
		inm5: out std_logic_vector(4 downto 0);
		inm8: out std_logic_vector(7 downto 0);
		inm11: out std_logic_vector(10 downto 0);
		Instruccion_out: out std_logic_vector(15 downto 0)
	);
end entity Direcction_register;

Architecture Behaivorial of Direcction_register is
	Signal guardar : std_logic_vector(15 downto 0);
	
	Signal	SRM,
				SRN,
				SRD,
				SRT: std_logic_vector(2 downto 0);
				
	Signal INM03: 	std_logic_vector(2 downto 0);
	Signal INM05: 	std_logic_vector(4 downto 0);
	Signal INM08: 	std_logic_vector(7 downto 0);
	Signal INM011: std_logic_vector(10 downto 0);
	
begin
	Instruccion:Process(Instruccion_in, clk) is begin
		if (rising_edge(clk)) then
			guardar <= instruccion_in;
			if load_dr = '1' then
				if (guardar(15 downto 6) = "0100000101") then  -- ADC(REGISTER)
					SRM <= guardar(5 downto 3);
					SRN <= guardar(2 downto 0);
					SRD <= guardar(2 downto 0);
					SRT <=(others=> 'Z');
					INM03 <= (Others => 'Z');
					INM05 <= (Others => 'Z');
					INM08 <= (Others => 'Z');
					INM011 <= (Others => 'Z');
					
				elsif(guardar(15 downto 9) = "0001110") then  -- ADD(INMEDIATE)
					SRM <= (others=>'Z');
					SRN <= instruccion_in( 5 downto 3);
					SRD <= instruccion_in( 2 downto 0);
					SRT <=(others=> 'Z');
					INM03<= instruccion_in(8 downto 6);
					INM05 <= (Others => 'Z');
					INM08 <= (Others => 'Z');
					INM011 <= (Others => 'Z');
				
				elsif (guardar(15 downto 10) = "000110") then -- ADD(REGISTER)
					SRM <= instruccion_in(8 downto 6);
					SRN <= instruccion_in( 5 downto 3);
					SRD <= instruccion_in( 2 downto 0);
					SRT <=(others=> 'Z');
					INM03 <= (Others => 'Z');
					INM05 <= (Others => 'Z');
					INM08 <= (Others => 'Z');
					INM011 <= (Others => 'Z');
					
				elsif (guardar(15 downto 6) = "0100000000") then -- AND(REGISTER)
						SRM <= instruccion_in( 5 downto 3);
						SRN <= instruccion_in( 2 downto 0);
						SRD <= instruccion_in( 2 downto 0);
						SRT <=(others=> 'Z');
						INM03 <= (Others => 'Z');
						INM05 <= (Others => 'Z');
						INM08 <= (Others => 'Z');
						INM011 <= (Others => 'Z');
				
				elsif (guardar(15 downto 11) = "00010") then -- ASR(INMEDIATE)
					SRM <= instruccion_in( 5 downto 3);
					SRN <= (others=> 'Z');
					SRD <= instruccion_in( 2 downto 0);
					SRT <=(others=> 'Z');
					INM03 <= (Others => 'Z');
					INM05 <= instruccion_in(10 downto 6);
					INM08 <= (Others => 'Z');
					INM011 <= (Others => 'Z');
					
				elsif(guardar(15 downto 10) = "010000") then  -- ASR(REGISTER)
					SRM <= instruccion_in( 5 downto 3);
					SRN <= instruccion_in( 2 downto 0);
					SRD <= instruccion_in( 2 downto 0);
					SRT <=(others=> 'Z');
					INM03 <= (Others => 'Z');
					INM05 <= (Others => 'Z');
					INM08 <= (Others => 'Z');
					INM011 <= (Others => 'Z');
					
				elsif (guardar(15 downto 6) = "0100001110") then -- BIC(REGISTER)
					SRM <= instruccion_in( 5 downto 3);
					SRN <= instruccion_in( 2 downto 0);
					SRD <= instruccion_in( 2 downto 0);
					SRT <=(others=> 'Z');
					INM03 <= (Others => 'Z');
					INM05 <= (Others => 'Z');
					INM08 <= (Others => 'Z');
					INM011 <= (Others => 'Z');
					
				elsif (guardar(15 downto 6) = "0100000001") then -- EOR(REGISTER)
					SRM <= instruccion_in( 5 downto 3);
					SRN <= instruccion_in( 2 downto 0);
					SRD <= instruccion_in( 2 downto 0);
					SRT <=(others=> 'Z');
					INM03 <= (Others => 'Z');
					INM05 <= (Others => 'Z');
					INM08 <= (Others => 'Z');
					INM011 <= (Others => 'Z');
					
				elsif(guardar(15 downto 11)="00000") then -- LSL(INMEDIATE)
					SRM <= instruccion_in( 5 downto 3);
					SRN <=(others=> 'Z');
					SRD <= instruccion_in( 2 downto 0);
					SRT <=(others=> 'Z');
					INM03 <= (Others => 'Z');
					INM05 <= instruccion_in(10 downto 6);
					INM08 <= (Others => 'Z');
					INM011 <= (Others => 'Z');
				
				elsif(guardar(15 downto 6)="0100000010") then	-- LSL(REGISTER)	
					SRM <= instruccion_in( 5 downto 3);
					SRN <= instruccion_in( 2 downto 0);
					SRD <= instruccion_in( 2 downto 0);
					SRT <=(others=> 'Z');
					INM03 <= (Others => 'Z');
					INM05 <= (Others => 'Z');
					INM08 <= (Others => 'Z');
					INM011 <= (Others => 'Z');
						
				elsif(guardar(15 downto 11)="00001") then -- LSR(INMEDIATE)	
					SRM <= instruccion_in( 5 downto 3);
					SRN <= (others=> 'Z');
					SRD <= instruccion_in( 2 downto 0);
					SRT <=(others=> 'Z');
					INM03 <= (Others => 'Z');
					INM05 <= iNStruccion_in(10 downto 6);
					INM08 <= (Others => 'Z');
					INM011 <= (Others => 'Z');
						
				elsif(guardar(15 downto 6)="010000001") then-- LSR(REGISTER)
					SRM <= instruccion_in( 5 downto 3);
					SRN <= instruccion_in( 2 downto 0);
					SRD <= instruccion_in( 2 downto 0);
					SRT <=(others=> 'Z');
					INM03 <= (Others => 'Z');
					INM05 <= (Others => 'Z');
					INM08 <= (Others => 'Z');
					INM011 <= (Others => 'Z');
						
				elsif(guardar(15 downto 6)="0100001101") then -- MUL
					SRM <= instruccion_in( 2 downto 0);
					SRN <= instruccion_in( 5 downto 3);
					SRD <= instruccion_in( 2 downto 0);
					SRT <=(others=> 'Z');
					INM03 <= (Others => 'Z');
					INM05 <= (Others => 'Z');
					INM08 <= (Others => 'Z');
					INM011 <= (Others => 'Z');
						
				elsif(guardar(15 downto 6)="0100001111") then -- MVN(REGISTER)					
					SRM <= instruccion_in( 5 downto 3);
					SRN <= (others=> 'Z');
					SRD <= instruccion_in( 2 downto 0);
					SRT <=(others=> 'Z');
					INM03 <= (Others => 'Z');
					INM05 <= (Others => 'Z');
					INM08 <= (Others => 'Z');
					INM011 <= (Others => 'Z');
				
				elsif(guardar(15 downto 0)="10111100000000") then	-- NOP
					SRM <= (others=> 'Z');
					SRN <= (others=> 'Z');
					SRD <= (others=> 'Z');
					SRT <=(others=> 'Z');
					INM03 <= (Others => 'Z');
					INM05 <= (Others => 'Z');
					INM08 <= (Others => 'Z');
					INM011 <= (Others => 'Z');

				elsif(guardar(15 downto 6)="0100001100") then-- ORR(REGISTER)
					
					SRM <= instruccion_in( 5 downto 3);
					SRN <= instruccion_in( 2 downto 0);
					SRD <= instruccion_in( 2 downto 0);
					SRT <=(others=> 'Z');
					INM03 <= (Others => 'Z');
					INM05 <= (Others => 'Z');
					INM08 <= (Others => 'Z');
					INM011 <= (Others => 'Z');

				elsif(guardar(15 downto 6)="1011101000") then-- REV
					SRM <= instruccion_in( 5 downto 3);
					SRN <= (others=> 'Z');
					SRD <= instruccion_in( 2 downto 0);
					SRT <=(others=> 'Z');
					INM03 <= (Others => 'Z');
					INM05 <= (Others => 'Z');
					INM08 <= (Others => 'Z');
					INM011 <= (Others => 'Z');

				elsif(guardar(15 downto 6)="101101001") then-- REV16
					SRM <= instruccion_in( 5 downto 3);
					SRN <= (others=> 'Z');
					SRD <= instruccion_in( 2 downto 0);
					SRT <=(others=> 'Z');
					INM03 <= (Others => 'Z');
					INM05 <= (Others => 'Z');
					INM08 <= (Others => 'Z');
					INM011 <= (Others => 'Z');

				elsif(guardar(15 downto 6)="1011101011") Then-- REVSH
				
					SRM <= instruccion_in( 5 downto 3);
					SRN <= (others=> 'Z');
					SRD <= instruccion_in( 2 downto 0);
					SRT <=(others=> 'Z');
					INM03 <= (Others => 'Z');
					INM05 <= (Others => 'Z');
					INM08 <= (Others => 'Z');
					INM011 <= (Others => 'Z');
						
				elsif(guardar(15 downto 6)="0100000111") Then-- ROR(REGISTER)
					
					SRM <= instruccion_in( 5 downto 3);
					SRN <= instruccion_in( 2 downto 0);
					SRD <= instruccion_in( 2 downto 0);
					SRT <=(others=> 'Z');
					INM03 <= (Others => 'Z');
					INM05 <= (Others => 'Z');
					INM08 <= (Others => 'Z');
					INM011 <= (Others => 'Z');

				elsif(guardar(15 downto 6)="0100001001") Then-- RSB(INMEDIATE)
					
					SRM <= (others=> 'Z');
					SRN <= instruccion_in( 5 downto 3);
					SRD <= instruccion_in( 2 downto 0);
					SRT <=(others=> 'Z');
					INM03 <= (Others => 'Z');
					INM05 <= (Others => 'Z');
					INM08 <= (Others => 'Z');
					INM011 <= (Others => 'Z');

				elsif(guardar(15 downto 6)="0100000110") Then-- SBC(REGISTER)
					
					SRM <= instruccion_in( 5 downto 3);
					SRN <= instruccion_in( 2 downto 0);
					SRD <= instruccion_in( 2 downto 0);
					SRT <=(others=> 'Z');
					INM03 <= (Others => 'Z');
					INM05 <= (Others => 'Z');
					INM08 <= (Others => 'Z');
					INM011 <= (Others => 'Z');

				elsif(guardar(15 downto 9)="0001111") Then-- SUB(INMEDIATE)
					
					SRM <= (others=> 'Z');
					SRN <= instruccion_in( 5 downto 3);
					SRD <= instruccion_in( 2 downto 0);
					SRT <=(others=> 'Z');
					INM03 <=instruccion_in( 8 downto 6);
					INM05 <= (Others => 'Z');
					INM08 <= (Others => 'Z');
					INM011 <= (Others => 'Z');
					
				elsif(guardar(15 downto 9)="0001101") Then-- SUB(REGISTER)
					
					SRM <=instruccion_in( 8 downto 6);
					SRN <= instruccion_in( 5 downto 3);
					SRD <= instruccion_in( 2 downto 0);
					SRT <=(others=> 'Z');
					INM03 <= (Others => 'Z');
					INM05 <= (Others => 'Z');
					INM08 <= (Others => 'Z');
					INM011 <= (Others => 'Z');
						
				elsif(guardar(15 downto 6)="1011001001") Then-- SXTB			
					SRM <=instruccion_in( 5 downto 3);
					SRN <= (others=> 'Z');
					SRD <= instruccion_in( 2 downto 0);
					SRT <=(others=> 'Z');
					INM03 <= (Others => 'Z');
					INM05 <= (Others => 'Z');
					INM08 <= (Others => 'Z');
					INM011 <= (Others => 'Z');

				elsif(guardar(15 downto 6)="1011001000") Then-- SXTH				
					SRM <=instruccion_in( 5 downto 3);
					SRN <= (others=> 'Z');
					SRD <= instruccion_in( 2 downto 0);
					SRT <=(others=> 'Z');
					INM03 <= (Others => 'Z');
					INM05 <= (Others => 'Z');
					INM08 <= (Others => 'Z');
					INM011 <= (Others => 'Z');

				elsif(guardar(15 downto 6)="0100001000") Then-- TST(REGISTER)		
					SRM <=instruccion_in( 5 downto 3);
					SRN <= instruccion_in( 2 downto 0);
					SRD <= (others=> 'Z');
					SRT <=(others=> 'Z');
					INM03 <= (Others => 'Z');
					INM05 <= (Others => 'Z');
					INM08 <= (Others => 'Z');
					INM011 <= (Others => 'Z');
					
				elsif(guardar(15 downto 6)="1011001011") Then-- UXTB
					
					SRM <=instruccion_in( 5 downto 3);
					SRN <= (others=> 'Z');
					SRD <= instruccion_in( 2 downto 0);
					SRT <=(others=> 'Z');
					INM03 <= (Others => 'Z');
					INM05 <= (Others => 'Z');
					INM08 <= (Others => 'Z');
					INM011 <= (Others => 'Z');

				elsif(guardar(15 downto 6)="1011001010") Then-- UXTH		
					SRM <=instruccion_in( 5 downto 3);
					SRN <= (others=> 'Z');
					SRD <= instruccion_in( 2 downto 0);
					SRT <=(others=> 'Z');
					INM03 <= (Others => 'Z');
					INM05 <= (Others => 'Z');
					INM08 <= (Others => 'Z');
					INM011 <= (Others => 'Z');

				elsif(guardar(15 downto 6)="0100001011") Then-- CMN
					SRM <=instruccion_in( 5 downto 3);
					SRN <= (others=> 'Z');
					SRD <= instruccion_in( 2 downto 0);
					SRT <=(others=> 'Z');
					INM03 <= (Others => 'Z');
					INM05 <= (Others => 'Z');
					INM08 <= (Others => 'Z');
					INM011 <= (Others => 'Z');
					
				elsif(guardar(15 downto 11)="00101") Then -- CMP(INMEDIATE)			
					SRM <=(others=> 'Z');
					SRN <= instruccion_in( 10 downto 8);
					SRD <= (others=> 'Z');
					SRT <=(others=> 'Z');
					INM03 <= (Others => 'Z');
					INM05 <= (Others => 'Z');
					INM08 <= instruccion_in(7 downto 0);
					INM011 <= (Others => 'Z');
					
				elsif(guardar(15 downto 6)="0100001010") Then-- CMP(REGISTER)
					
					SRM <=instruccion_in( 5 downto 3);
					SRN <= instruccion_in( 2 downto 0);
					SRD <= (others=> 'Z');
					SRT <=(others=> 'Z');
					INM03 <= (Others => 'Z');
					INM05 <= (Others => 'Z');
					INM08 <= (Others => 'Z');
					INM011 <= (Others => 'Z');
					
				elsif(guardar(15 downto 6)="1101") Then-- B		
					SRM <=(others=> 'Z');
					SRN <= (others=> 'Z');
					SRD <= (others=> 'Z');
					SRT <= (others=> 'Z');
					INM03 <= (Others => 'Z');
					INM05 <= (Others => 'Z');
					INM08 <= instruccion_in(7 downto 0);
					INM011 <= (Others => 'Z');
				else null;	
				end if;
				
			elsif rst_dr = '1' then
				SRM <=(others=> '0');
				SRN <= (others=> '0');
				SRD <= (others=> '0');
				SRT <= (others=> '0');
				INM03 <= (Others => '0');
				INM05 <= (Others => '0');
				INM08 <= (Others => '0');
				INM011 <= (Others => '0');
				
			else
				RM <= SRM;
				RN <= SRN;
				RD <= SRD;
				RT <= SRT;
				inm3 <= INM03;
				inm5 <= INM05;
				inm8 <= INM08;
				inm11 <= INM011;
			end if;
		else null;
		end if;
		Instruccion_out <= instruccion_in;
	end process Instruccion;
end architecture Behaivorial;