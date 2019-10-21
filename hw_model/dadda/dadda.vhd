library ieee;
use ieee.std_logic_1164.all;

use work.dadda_func.all;

entity dadda is

	port(
		a	:	in 	std_logic_vector(7 	downto 0);
		b 	:	in 	std_logic_vector(7 	downto 0);
		res	: 	out std_logic_vector(15 downto 0)
		);
		
end entity;

architecture structure of dadda is

	component dadda_and_matrix is
		port(
			a		:	in	std_logic_vector(7 downto 0);
			b		:	in	std_logic_vector(7 downto 0);
			o		:	out	and_matrix;
			xor_msb	:	out	std_logic;
			and_msb	:	out	std_logic
		);
	end component;
	
	component dadda_first_level is
		port(
			i		:	in	and_matrix;
			o		:	out	first_level
		);	
	end component;
	
	component dadda_second_level is
		port(
			i		:	in	and_matrix;
			i_f		:	in	first_level;
			xor_msb	:	in	std_logic;
			and_msb	:	in	std_logic;
			o		:	out	second_level
		);
	end component;
	
	component dadda_third_level is
		port(
			i		:	in	and_matrix;
			i_f		:	in	first_level;
			i_s		:	in	second_level;
			o		:	out	third_level
		);
	end component;
	
	component dadda_fourth_level is
		port(
			i		:	in	and_matrix;
			i_s		:	in	second_level;
			i_t		:	in 	third_level;
			o		:	out	fourth_level
		);
	end component;
	
	component adder is
		port(
			a	:	in 	std_logic_vector(15 downto 0);
			b 	:	in 	std_logic_vector(15 downto 0);
			res	: 	out std_logic_vector(15 downto 0)
			);
	end component;
	
	signal	xor_msb			:	std_logic;
	signal	and_msb			:	std_logic;
	signal	o_and_matrix	:	and_matrix;
	signal	oam				:	and_matrix;
	
	signal	o_first_level	:	first_level; 
	
	signal	o_second_level	:	second_level;
	
	signal	o_third_level	:	third_level;
	
	signal	o_fourth_level	:	fourth_level;
	signal	ofl				:	fourth_level;
	
	signal sum_a			:	std_logic_vector(15 downto 0);
	signal sum_b			:	std_logic_vector(15 downto 0);
	signal result			:	std_logic_vector(15 downto 0);
	
begin
	
	ofl		<=	o_fourth_level; 
	oam		<=	o_and_matrix;
	sum_a	<= 	oam(7)(7)&oam(7)(7)&ofl(11)(1)&ofl(10)(1)&ofl(9)(1)&ofl(7)(1)&ofl(6)(1)&ofl(5)(1)&ofl(4)(1)&ofl(3)(1)&ofl(2)(1)&ofl(1)(1)&ofl(0)(1)&oam(0)(2)&oam(1)(0)&oam(0)(0);
	sum_b	<= 	ofl(8)(1)&ofl(8)(1)&ofl(8)(0)&ofl(11)(0)&ofl(10)(0)&ofl(9)(0)&ofl(7)(0)&ofl(6)(0)&ofl(5)(0)&ofl(4)(0)&ofl(3)(0)&ofl(2)(0)&ofl(1)(0)&ofl(0)(0)&oam(0)(1)&'0';
	
	res		<=	xor_msb&result(14 downto 0);
	
	and_matr	:	dadda_and_matrix
		port map(
			a		=>	a,
			b		=>	b,
			o		=>	o_and_matrix,
			xor_msb	=>	xor_msb,
			and_msb	=>	and_msb
		);

	lv_1		:	dadda_first_level
		port map(
			i		=>	o_and_matrix,
			o		=>	o_first_level
		);

	lv_2		:	dadda_second_level
		port map(
			i		=>	o_and_matrix,
			i_f		=>	o_first_level,
			xor_msb	=>	xor_msb,
			and_msb	=>	and_msb,
			o		=>	o_second_level
		);

	lv_3		:	dadda_third_level
		port map(
			i		=>	o_and_matrix,
			i_f		=>	o_first_level,
			i_s		=>	o_second_level,
			o		=>	o_third_level
		);
	
	lv_4		:	dadda_fourth_level
		port map(
			i		=>	o_and_matrix,
			i_s		=>	o_second_level,
			i_t		=>	o_third_level,
			o		=>	o_fourth_level
		);
		
	sum			:	adder
		port map(
			a	=>	sum_a,
			b 	=>	sum_b,
			res	=>	result
		);

end architecture structure;