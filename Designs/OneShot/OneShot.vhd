library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity OneShot is
	port(
		Trigger : in  std_logic;
		Clock   : in  std_logic;
		Pulse   : out std_logic
	);
end entity OneShot;

architecture Behaivorial of OneShot is
	signal QA : std_logic := '0';
	signal QB : std_logic := '0';
begin
	Pulse <= QB;
	
	process(Trigger, QB) is
	begin
		if (QB = '1') then
			QA <= '0';
		elsif (rising_edge(Trigger)) then
			QA <= '1';
		end if;
	end process;

		Process(clock) is
			Variable contar : integer:=0;
		begin
			if rising_edge(clock) then
				if contar = 2 then
					QB <= QA;
					contar := 0;
				else
					QB <= QB;
					contar := contar + 1;
				end if;
			end if;
		end process;
--	process(Clock) is
--	begin
--		if (rising_edge(Clock)) then
--			QB <= QA;
--		end if;
--	end process;
end architecture Behaivorial;





