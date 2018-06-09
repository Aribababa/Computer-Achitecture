Library IEEE;
	Use IEEE.std_logic_1164.all;
	
Entity OneShot_32bits is
	port(
		clk: in std_logic;
		trigger: in std_logic_vector(15 downto 0);
		Pulse: out std_logic_vector(15 downto 0)
	);
end entity OneShot_32bits;

Architecture Behaivorial of OneShot_32bits is

	component OneShot is
		port(
			Trigger : in  std_logic;
			Clock   : in  std_logic;
			Pulse   : out std_logic
		);
	end component OneShot;

begin
	Generar: for i in 0 to 15 generate
		OneShot_n: OneShot port map(
			Trigger => trigger(i),
			Clock => clk,
			Pulse => pulse(i) 
		);
	end generate Generar;
	
end architecture Behaivorial;