library ieee;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;
	
entity tb_subpage_controller is

end tb_subpage_controller;

architecture test of tb_subpage_controller is

	component subpage_controller is
		port(
			en_clk	: in	std_logic;
			clk		: in 	std_logic;
			inc		: in 	std_logic;
			rst_l 	: in 	std_logic;
			uph_dnl	: inout	std_logic;
			d_out 	: out 	std_logic_vector(4 downto 0)
		);
	end component;


	signal	tb_en_clk		:	std_logic;
	signal	tb_clk			:	std_logic;
	signal	tb_inc			:  	std_logic;
	signal	tb_rst_l		:  	std_logic;
	signal	tb_uph_dnl		:  	std_logic;
	signal	tb_d_out 		:  	std_logic_vector(4 downto 0);

begin

	dut : subpage_controller
		port map(
			en_clk	=>	tb_en_clk,
			clk		=>	tb_clk,
			inc		=>	tb_inc,
			rst_l	=>	tb_rst_l,
			uph_dnl	=>	tb_uph_dnl,
			d_out	=>	tb_d_out
		);
	
	process -- clock generation at 500mhz.
	begin
		tb_clk <= '1';
		wait for 1 ns;
		tb_clk <= '0';
		wait for 1 ns;
	end process;
	
	process -- reset generation 
	begin
		tb_rst_l <= '0';
		wait for 2 ns;
		tb_rst_l <= '1';
		wait;
	end process;
	
	process 
	begin
		
		tb_en_clk	<= '1';
		tb_inc		<= '1';
		wait for 10 ns;
		tb_inc		<= '0';
		wait for 10 ns;
		tb_inc		<= '1';
	
		wait;
	end process;
	
end test;