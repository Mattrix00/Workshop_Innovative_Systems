library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

use work.globals.all;

entity pev2_2 is 
	port(
		ck 			: in 	std_logic; 
		rst 			: in 	std_logic;
		en				: in 	std_logic; 
		ld_h			: in 	std_logic;
		ld_v			: in 	std_logic; 
		rld_v			: in 	std_logic; 
		wr_pipe		: in 	std_logic; 
		weight 		: in	std_logic_vector(N_WEIGHT-1 downto 0);
		i_data_h		: in	signed(N-1 downto 0);
		i_data_v		: in 	signed(N-1 downto 0);
		i_data_acc	: in 	signed(N-1+BG downto 0);
		o_data_h		: out signed(N-1 downto 0);
		o_data_v		: out signed(N-1 downto 0);
		o_data_res	: out signed(N-1+BG downto 0)
		);
end entity;

architecture beh of pev2_2 is

signal int_q_reg_in 	: signed(N-1 downto 0);
signal int_q_reg_h 	: signed(N-1 downto 0);
signal int_q_reg_v 	: signed(N-1 downto 0);
signal int_sgnext		: signed(N-1+BG downto 0); 
signal int_q_acc 		: signed(N-1+BG downto 0);
signal int_d_acc 		: signed(N-1+BG downto 0);

signal int_q_weight 	: std_logic; 
signal int_q_en		: std_logic; 
signal int_acc_en 	: std_logic; 

signal int_ld_h		: std_logic;
signal int_ld_v		: std_logic; 

begin

	int_sgnext(int_sgnext'high downto int_q_reg_in'high) <= ( others => int_q_reg_in(int_q_reg_in'high) );
	int_sgnext(int_q_reg_in'high downto 0) <= int_q_reg_in;

	int_ld_h		<= en and ld_h;
	int_ld_v		<= en and ld_v; 
	int_acc_en	<= int_q_en or wr_pipe;  

	o_data_h	   <= int_q_reg_h;
	o_data_v	   <= int_q_reg_v;
	o_data_res  <= int_q_acc; 

	-- i/o pipelining 
	input_reg_h:
	process(ck, rst, en)
	begin
		if rst = '1' then
			int_q_reg_h 	<= (others=>'0');
		elsif rising_edge(ck) and en = '1' then 
			if rld_v = '1' then 
				int_q_reg_h <= int_q_reg_v; 
			elsif int_ld_h = '1' then
				int_q_reg_h <= i_data_h;
			else 
				int_q_reg_h <= i_data_v;
			end if; 
		end if;
	end process;

	input_reg_v:
	process(ck, rst, int_ld_v)
	begin
		if rst = '1' then
			int_q_reg_v 	<= (others=>'0');
		elsif rising_edge(ck) and int_ld_v = '1' then 
			int_q_reg_v <= i_data_v;	
		end if;
	end process;

	input_reg_adder:
	process(ck, rst, weight)
	begin
		if rst = '1' then
			int_q_reg_in 	<= (others=>'0');
		elsif rising_edge(ck) and weight(weight'high) = '1' then 
				int_q_reg_in <= int_q_reg_h;	
		end if;
	end process;

	ff:
	process(ck, rst, en)
	begin
		if rst = '1' then
			int_q_weight 	<= '0';
			int_q_en			<= '0';
		elsif rising_edge(ck) and en = '1' then 
			int_q_weight   <= weight(weight'low);
			int_q_en			<= weight(weight'high);
		end if;
	end process;

	output_data:
	process(ck, rst, int_acc_en)
	begin
		if rst = '1' then
			int_q_acc 		<= (others=>'0'); 
		elsif rising_edge(ck) and int_acc_en = '1' then
			if wr_pipe = '1' then	
				int_q_acc 	<= i_data_acc;		
			else
				int_q_acc 	<= int_d_acc;
			end if;
		end if;
	end process;

	-- add
	adder_sub_proc:
	process(int_sgnext, int_q_acc, int_q_weight)
	begin 
		if int_q_weight = '1' then 
			int_d_acc <= int_sgnext - int_q_acc;
		else
			int_d_acc <= int_sgnext + int_q_acc;		 
		end if; 
	end process;



end architecture;