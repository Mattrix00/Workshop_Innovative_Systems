library ieee;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;

entity fc_fsm is

	port(
		reset		:	in	std_logic;
		clk			:	in	std_logic;
		start		:	in	std_logic;
		done		:	in	std_logic;

		en_pipe_h	: 	out	std_logic;
		
		en_sp_0_h	: 	out	std_logic;
		en_sp_1_h	: 	out	std_logic;
		en_sp_2_h	: 	out	std_logic;
		en_sp_3_h	: 	out	std_logic;
		en_sp_4_h	: 	out	std_logic;
		
		rst_reg_l	:	out	std_logic
	);
		
end fc_fsm;

architecture behavior of fc_fsm is

	type 	state is (idle,ld_act,ld_w,wait_0,wait_1,ld_c,ld_ab_c);
	
	signal 	ps, ns : state;
	
begin

	process(ps,start,done)
	begin
		case ps	is
		
			when idle  =>
				if start = '1' then
					ns <= ld_act;
				else
					ns <= idle;
				end if;
				
			when ld_act  =>
				ns	<=	ld_w;
				
			when ld_w  =>
				ns <= wait_0;
				
			when wait_0  =>
				ns <= wait_1;
				
			when wait_1  =>
				ns	<=	ld_c;
				
			when ld_c  =>
				ns <= ld_ab_c;

			when ld_ab_c =>
				if done = '1' then
					ns <= idle;
				else
					ns <= ld_ab_c;
				end if;
			
			when others => 
				ns <= idle;
			
		end case;
	end process;

	process(clk, reset)
	begin
		if reset = '0' then 
			ps <= idle;
		elsif(clk'event	and	clk	= '1') then 
			ps <= ns;
		end if;
	end process;

	process(ps)
	begin
		--init
		en_pipe_h	<=	'0';
		
		en_sp_0_h	<=	'0';
		en_sp_1_h	<=	'0';
		en_sp_2_h	<=	'0';
		en_sp_3_h	<=	'0';
		en_sp_4_h	<=	'0';
		
		rst_reg_l	<=	'1';
		
		
		
		case ps is
			
			when idle =>
				rst_reg_l 	<= '0';
				
				
			when ld_act =>
				en_sp_0_h	<=	'1';
				en_sp_1_h	<=	'1';
				en_sp_2_h	<=	'1';
				en_sp_3_h	<=	'1';
				en_sp_4_h	<=	'1';
				
			when ld_w =>
				en_pipe_h	<=	'1';
				
			when wait_0 =>
				en_pipe_h	<=	'1';
				
			when wait_1 =>
				en_pipe_h	<=	'1';
				
			when ld_c =>
				en_pipe_h	<=	'1';
			
			when ld_ab_c =>
				en_pipe_h	<=	'1';
			
			when others => 
				rst_reg_l 		<= '0';

		end case;
	end process;
	
end behavior;