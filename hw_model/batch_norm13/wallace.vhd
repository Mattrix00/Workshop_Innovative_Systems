library ieee;
use ieee.std_logic_1164.all;

use work.wallace_func.all;

entity wallace is

	port(
		a_in	:	in 	std_logic_vector(12 downto 0);
		b_in 	:	in 	std_logic_vector(12	downto 0);
		result	: 	out std_logic_vector(25 downto 0)
		);
		
end entity;

architecture structure of wallace is

	component wallace_and_matrix is
		port(
			a		:	in	std_logic_vector(12 downto 0);
			b		:	in	std_logic_vector(12 downto 0);
			o		:	out	and_matrix;
			xor_msb	:	out	std_logic;
			and_msb	:	out	std_logic
		);
	end component;
	
	component half_adder is
		port(
			a	:	in	std_logic;
			b	:	in	std_logic;
			s	:	out	std_logic;
			c	:	out std_logic
		);
	end component;
	
	component full_adder is
		port(
			a	:	in	std_logic;
			b	:	in	std_logic;
			cin	:	in	std_logic;
			s	:	out	std_logic;
			c	:	out std_logic
		);
	end component;
	
	component adder is
		port(
			a	:	in 	std_logic_vector(26 downto 0);
			b 	:	in 	std_logic_vector(26 downto 0);
			res	: 	out std_logic_vector(26 downto 0)
			);
	end component;
	
	signal xor_msb	:	std_logic;
	signal and_msb	:	std_logic;
	
	signal s0	:	and_matrix;
	signal s1	:	first_level;
	signal s2	:	second_level;
	signal s3	:	third_level;
	signal s4	:	fourth_level;
	signal s5	:	fifth_level;
	signal s6	:	sixth_level;
	
	signal add_a	:	std_logic_vector(26 downto 0);
	signal add_b	:	std_logic_vector(26 downto 0);
	signal tmp_res	:	std_logic_vector(26 downto 0);
	signal tmp		:	std_logic_vector(19 downto 0);
	
begin

	-- zero stage
	
	and_matr :	wallace_and_matrix port map(a_in, b_in, s0, xor_msb, and_msb);
	
	--first stage
	ha_1_0	:	half_adder	port map(s0(0)(1),	s0(1)(0),				s1(0)(0),	s1(0)(1));
	fa_1_1	:	full_adder	port map(s0(0)(2),	s0(1)(1),	s0(2)(0),	s1(1)(0),	s1(1)(1));
	fa_1_2	:	full_adder	port map(s0(0)(3),	s0(1)(2),	s0(2)(1),	s1(2)(0),	s1(2)(1));
	fa_1_3	:	full_adder	port map(s0(0)(4),	s0(1)(3),	s0(2)(2),	s1(3)(0),	s1(3)(1));
	fa_1_4	:	full_adder	port map(s0(0)(5),	s0(1)(4),	s0(2)(3),	s1(4)(0),	s1(4)(1));
	fa_1_5	:	full_adder	port map(s0(0)(6),	s0(1)(5),	s0(2)(4),	s1(5)(0),	s1(5)(1));
	fa_1_6	:	full_adder	port map(s0(0)(7),	s0(1)(6),	s0(2)(5),	s1(6)(0),	s1(6)(1));
	fa_1_7	:	full_adder	port map(s0(0)(8),	s0(1)(7),	s0(2)(6),	s1(7)(0),	s1(7)(1));
	fa_1_8	:	full_adder	port map(s0(0)(9),	s0(1)(8),	s0(2)(7),	s1(8)(0),	s1(8)(1));
	fa_1_9	:	full_adder	port map(s0(0)(10),	s0(1)(9),	s0(2)(8),	s1(9)(0),	s1(9)(1));
	fa_1_10	:	full_adder	port map(s0(0)(11),	s0(1)(10),	s0(2)(9),	s1(10)(0),	s1(10)(1));
	fa_1_11	:	full_adder	port map(s0(0)(12),	s0(1)(11),	s0(2)(10),	s1(11)(0),	s1(11)(1));
	ha_1_12	:	half_adder	port map(s0(1)(12),	s0(2)(11),				s1(12)(0),	s1(12)(1));
	
	ha_1_13	:	half_adder	port map(s0(3)(1),	s0(4)(0),				s1(13)(0),	s1(13)(1));
	fa_1_14	:	full_adder	port map(s0(3)(2),	s0(4)(1),	s0(5)(0),	s1(14)(0),	s1(14)(1));
	fa_1_15	:	full_adder	port map(s0(3)(3),	s0(4)(2),	s0(5)(1),	s1(15)(0),	s1(15)(1));
	fa_1_16	:	full_adder	port map(s0(3)(4),	s0(4)(3),	s0(5)(2),	s1(16)(0),	s1(16)(1));
	fa_1_17	:	full_adder	port map(s0(3)(5),	s0(4)(4),	s0(5)(3),	s1(17)(0),	s1(17)(1));
	fa_1_18	:	full_adder	port map(s0(3)(6),	s0(4)(5),	s0(5)(4),	s1(18)(0),	s1(18)(1));
	fa_1_19	:	full_adder	port map(s0(3)(7),	s0(4)(6),	s0(5)(5),	s1(19)(0),	s1(19)(1));
	fa_1_20	:	full_adder	port map(s0(3)(8),	s0(4)(7),	s0(5)(6),	s1(20)(0),	s1(20)(1));
	fa_1_21	:	full_adder	port map(s0(3)(9),	s0(4)(8),	s0(5)(7),	s1(21)(0),	s1(21)(1));
	fa_1_22	:	full_adder	port map(s0(3)(10),	s0(4)(9),	s0(5)(8),	s1(22)(0),	s1(22)(1));
	fa_1_23	:	full_adder	port map(s0(3)(11),	s0(4)(10),	s0(5)(9),	s1(23)(0),	s1(23)(1));
	fa_1_24	:	full_adder	port map(s0(3)(12),	s0(4)(11),	s0(5)(10),	s1(24)(0),	s1(24)(1));
	ha_1_25	:	half_adder	port map(s0(4)(12),	s0(5)(11),				s1(25)(0),	s1(25)(1));
	
	ha_1_26	:	half_adder	port map(s0(6)(1),	s0(7)(0),				s1(26)(0),	s1(26)(1));
	fa_1_27	:	full_adder	port map(s0(6)(2),	s0(7)(1),	s0(8)(0),	s1(27)(0),	s1(27)(1));
	fa_1_28	:	full_adder	port map(s0(6)(3),	s0(7)(2),	s0(8)(1),	s1(28)(0),	s1(28)(1));
	fa_1_29	:	full_adder	port map(s0(6)(4),	s0(7)(3),	s0(8)(2),	s1(29)(0),	s1(29)(1));
	fa_1_30	:	full_adder	port map(s0(6)(5),	s0(7)(4),	s0(8)(3),	s1(30)(0),	s1(30)(1));
	fa_1_31	:	full_adder	port map(s0(6)(6),	s0(7)(5),	s0(8)(4),	s1(31)(0),	s1(31)(1));
	fa_1_32	:	full_adder	port map(s0(6)(7),	s0(7)(6),	s0(8)(5),	s1(32)(0),	s1(32)(1));
	fa_1_33	:	full_adder	port map(s0(6)(8),	s0(7)(7),	s0(8)(6),	s1(33)(0),	s1(33)(1));
	fa_1_34	:	full_adder	port map(s0(6)(9),	s0(7)(8),	s0(8)(7),	s1(34)(0),	s1(34)(1));
	fa_1_35	:	full_adder	port map(s0(6)(10),	s0(7)(9),	s0(8)(8),	s1(35)(0),	s1(35)(1));
	fa_1_36	:	full_adder	port map(s0(6)(11),	s0(7)(10),	s0(8)(9),	s1(36)(0),	s1(36)(1));
	fa_1_37	:	full_adder	port map(s0(6)(12),	s0(7)(11),	s0(8)(10),	s1(37)(0),	s1(37)(1));
	ha_1_38	:	half_adder	port map(s0(7)(12),	s0(8)(11),				s1(38)(0),	s1(38)(1));
	
	ha_1_39	:	half_adder	port map(s0(9)(1),	s0(10)(0),				s1(39)(0),	s1(39)(1));
	fa_1_40	:	full_adder	port map(s0(9)(2),	s0(10)(1),	s0(11)(0),	s1(40)(0),	s1(40)(1));
	fa_1_41	:	full_adder	port map(s0(9)(3),	s0(10)(2),	s0(11)(1),	s1(41)(0),	s1(41)(1));
	fa_1_42	:	full_adder	port map(s0(9)(4),	s0(10)(3),	s0(11)(2),	s1(42)(0),	s1(42)(1));
	fa_1_43	:	full_adder	port map(s0(9)(5),	s0(10)(4),	s0(11)(3),	s1(43)(0),	s1(43)(1));
	fa_1_44	:	full_adder	port map(s0(9)(6),	s0(10)(5),	s0(11)(4),	s1(44)(0),	s1(44)(1));
	fa_1_45	:	full_adder	port map(s0(9)(7),	s0(10)(6),	s0(11)(5),	s1(45)(0),	s1(45)(1));
	fa_1_46	:	full_adder	port map(s0(9)(8),	s0(10)(7),	s0(11)(6),	s1(46)(0),	s1(46)(1));
	fa_1_47	:	full_adder	port map(s0(9)(9),	s0(10)(8),	s0(11)(7),	s1(47)(0),	s1(47)(1));
	fa_1_48	:	full_adder	port map(s0(9)(10),	s0(10)(9),	s0(11)(8),	s1(48)(0),	s1(48)(1));
	fa_1_49	:	full_adder	port map(s0(9)(11),	s0(10)(10),	s0(11)(9),	s1(49)(0),	s1(49)(1));
	fa_1_50	:	full_adder	port map(s0(9)(12),	s0(10)(11),	s0(11)(10),	s1(50)(0),	s1(50)(1));
	ha_1_51	:	half_adder	port map(s0(10)(12),s0(11)(11),				s1(51)(0),	s1(51)(1));
	
	--second stage
	
	ha_2_0	:	half_adder	port map(s1(1)(0),	s1(0)(1),				s2(0)(0),	s2(0)(1));
	fa_2_1	:	full_adder	port map(s1(2)(0),	s1(1)(1),	s0(3)(0),	s2(1)(0),	s2(1)(1));
	fa_2_2	:	full_adder	port map(s1(3)(0),	s1(2)(1),	s1(13)(0),	s2(2)(0),	s2(2)(1));
	fa_2_3	:	full_adder	port map(s1(4)(0),	s1(3)(1),	s1(14)(0),	s2(3)(0),	s2(3)(1));
	fa_2_4	:	full_adder	port map(s1(5)(0),	s1(4)(1),	s1(15)(0),	s2(4)(0),	s2(4)(1));
	fa_2_5	:	full_adder	port map(s1(6)(0),	s1(5)(1),	s1(16)(0),	s2(5)(0),	s2(5)(1));
	fa_2_6	:	full_adder	port map(s1(7)(0),	s1(6)(1),	s1(17)(0),	s2(6)(0),	s2(6)(1));
	fa_2_7	:	full_adder	port map(s1(8)(0),	s1(7)(1),	s1(18)(0),	s2(7)(0),	s2(7)(1));
	fa_2_8	:	full_adder	port map(s1(9)(0),	s1(8)(1),	s1(19)(0),	s2(8)(0),	s2(8)(1));
	fa_2_9	:	full_adder	port map(s1(10)(0),	s1(9)(1),	s1(20)(0),	s2(9)(0),	s2(9)(1));
	fa_2_10	:	full_adder	port map(s1(11)(0),	s1(10)(1),	s1(21)(0),	s2(10)(0),	s2(10)(1));
	fa_2_11	:	full_adder	port map(s1(12)(0),	s1(11)(1),	s1(22)(0),	s2(11)(0),	s2(11)(1));
	fa_2_12	:	full_adder	port map(s0(2)(12),	s1(12)(1),	s1(23)(0),	s2(12)(0),	s2(12)(1));
	
	ha_2_13	:	half_adder	port map(s1(14)(1),	s0(6)(0),				s2(13)(0),	s2(13)(1));
	ha_2_14	:	half_adder	port map(s1(15)(1),	s1(26)(0),				s2(14)(0),	s2(14)(1));
	fa_2_15	:	full_adder	port map(s1(16)(1),	s1(27)(0),	s1(26)(1),	s2(15)(0),	s2(15)(1));
	fa_2_16	:	full_adder	port map(s1(17)(1),	s1(28)(0),	s1(27)(1),	s2(16)(0),	s2(16)(1));
	fa_2_17	:	full_adder	port map(s1(18)(1),	s1(29)(0),	s1(28)(1),	s2(17)(0),	s2(17)(1));
	fa_2_18	:	full_adder	port map(s1(19)(1),	s1(30)(0),	s1(29)(1),	s2(18)(0),	s2(18)(1));
	fa_2_19	:	full_adder	port map(s1(20)(1),	s1(31)(0),	s1(30)(1),	s2(19)(0),	s2(19)(1));
	fa_2_20	:	full_adder	port map(s1(21)(1),	s1(32)(0),	s1(31)(1),	s2(20)(0),	s2(20)(1));
	fa_2_21	:	full_adder	port map(s1(22)(1),	s1(33)(0),	s1(32)(1),	s2(21)(0),	s2(21)(1));
	fa_2_22	:	full_adder	port map(s1(23)(1),	s1(34)(0),	s1(33)(1),	s2(22)(0),	s2(22)(1));
	fa_2_23	:	full_adder	port map(s1(24)(1),	s1(35)(0),	s1(34)(1),	s2(23)(0),	s2(23)(1));
	fa_2_24	:	full_adder	port map(s1(25)(1),	s1(36)(0),	s1(35)(1),	s2(24)(0),	s2(24)(1));
	ha_2_25	:	half_adder	port map(s1(37)(0),	s1(36)(1),				s2(25)(0),	s2(25)(1));
	ha_2_26	:	half_adder	port map(s1(38)(0),	s1(37)(1),				s2(26)(0),	s2(26)(1));
	ha_2_27	:	half_adder	port map(s0(8)(12),	s1(38)(1),				s2(27)(0),	s2(27)(1));
	
	ha_2_28	:	half_adder	port map(s1(40)(0),	s1(39)(1),				s2(28)(0),	s2(28)(1));
	fa_2_29	:	full_adder	port map(s1(41)(0),	s1(40)(1),	s0(12)(0),	s2(29)(0),	s2(29)(1));
	fa_2_30	:	full_adder	port map(s1(42)(0),	s1(41)(1),	s0(12)(1),	s2(30)(0),	s2(30)(1));
	fa_2_31	:	full_adder	port map(s1(43)(0),	s1(42)(1),	s0(12)(2),	s2(31)(0),	s2(31)(1));
	fa_2_32	:	full_adder	port map(s1(44)(0),	s1(43)(1),	s0(12)(3),	s2(32)(0),	s2(32)(1));
	fa_2_33	:	full_adder	port map(s1(45)(0),	s1(44)(1),	s0(12)(4),	s2(33)(0),	s2(33)(1));
	fa_2_34	:	full_adder	port map(s1(46)(0),	s1(45)(1),	s0(12)(5),	s2(34)(0),	s2(34)(1));
	fa_2_35	:	full_adder	port map(s1(47)(0),	s1(46)(1),	s0(12)(6),	s2(35)(0),	s2(35)(1));
	fa_2_36	:	full_adder	port map(s1(48)(0),	s1(47)(1),	s0(12)(7),	s2(36)(0),	s2(36)(1));
	fa_2_37	:	full_adder	port map(s1(49)(0),	s1(48)(1),	s0(12)(8),	s2(37)(0),	s2(37)(1));
	fa_2_38	:	full_adder	port map(s1(50)(0),	s1(49)(1),	s0(12)(9),	s2(38)(0),	s2(38)(1));
	fa_2_39	:	full_adder	port map(s1(51)(0),	s1(50)(1),	s0(12)(10),	s2(39)(0),	s2(39)(1));
	fa_2_40	:	full_adder	port map(s0(11)(12),s1(51)(1),	s0(12)(11),	s2(40)(0),	s2(40)(1));
	
	-- third stage
	
	ha_3_0	:	half_adder	port map(s2(1)(0),	s2(0)(1),				s3(0)(0),	s3(0)(1));
	ha_3_1	:	half_adder	port map(s2(2)(0),	s2(1)(1),				s3(1)(0),	s3(1)(1));
	fa_3_2	:	full_adder	port map(s2(3)(0),	s2(2)(1),	s1(13)(1),	s3(2)(0),	s3(2)(1));
	fa_3_3	:	full_adder	port map(s2(4)(0),	s2(3)(1),	s2(13)(0),	s3(3)(0),	s3(3)(1));
	fa_3_4	:	full_adder	port map(s2(5)(0),	s2(4)(1),	s2(14)(0),	s3(4)(0),	s3(4)(1));
	fa_3_5	:	full_adder	port map(s2(6)(0),	s2(5)(1),	s2(15)(0),	s3(5)(0),	s3(5)(1));
	fa_3_6	:	full_adder	port map(s2(7)(0),	s2(6)(1),	s2(16)(0),	s3(6)(0),	s3(6)(1));
	fa_3_7	:	full_adder	port map(s2(8)(0),	s2(7)(1),	s2(17)(0),	s3(7)(0),	s3(7)(1));
	fa_3_8	:	full_adder	port map(s2(9)(0),	s2(8)(1),	s2(18)(0),	s3(8)(0),	s3(8)(1));
	fa_3_9	:	full_adder	port map(s2(10)(0),	s2(9)(1),	s2(19)(0),	s3(9)(0),	s3(9)(1));
	fa_3_10	:	full_adder	port map(s2(11)(0),	s2(10)(1),	s2(20)(0),	s3(10)(0),	s3(10)(1));
	fa_3_11	:	full_adder	port map(s2(12)(0),	s2(11)(1),	s2(21)(0),	s3(11)(0),	s3(11)(1));
	fa_3_12	:	full_adder	port map(s1(24)(0),	s2(12)(1),	s2(22)(0),	s3(12)(0),	s3(12)(1));
	ha_3_13	:	half_adder	port map(s1(25)(0),	s2(23)(0),				s3(13)(0),	s3(13)(1));
	ha_3_14	:	half_adder	port map(s0(5)(12),	s2(24)(0),				s3(14)(0),	s3(14)(1));
	
	ha_3_15	:	half_adder	port map(s2(15)(1),	s0(9)(0),				s3(15)(0),	s3(15)(1));
	ha_3_16	:	half_adder	port map(s2(16)(1),	s1(39)(0),				s3(16)(0),	s3(16)(1));
	ha_3_17	:	half_adder	port map(s2(17)(1),	s2(28)(0),				s3(17)(0),	s3(17)(1));
	fa_3_18	:	full_adder	port map(s2(18)(1),	s2(29)(0),	s2(28)(1),	s3(18)(0),	s3(18)(1));
	fa_3_19	:	full_adder	port map(s2(19)(1),	s2(30)(0),	s2(29)(1),	s3(19)(0),	s3(19)(1));
	fa_3_20	:	full_adder	port map(s2(20)(1),	s2(31)(0),	s2(30)(1),	s3(20)(0),	s3(20)(1));
	fa_3_21	:	full_adder	port map(s2(21)(1),	s2(32)(0),	s2(31)(1),	s3(21)(0),	s3(21)(1));
	fa_3_22	:	full_adder	port map(s2(22)(1),	s2(33)(0),	s2(32)(1),	s3(22)(0),	s3(22)(1));
	fa_3_23	:	full_adder	port map(s2(23)(1),	s2(34)(0),	s2(33)(1),	s3(23)(0),	s3(23)(1));
	fa_3_24	:	full_adder	port map(s2(24)(1),	s2(35)(0),	s2(34)(1),	s3(24)(0),	s3(24)(1));
	fa_3_25	:	full_adder	port map(s2(25)(1),	s2(36)(0),	s2(35)(1),	s3(25)(0),	s3(25)(1));
	fa_3_26	:	full_adder	port map(s2(26)(1),	s2(37)(0),	s2(36)(1),	s3(26)(0),	s3(26)(1));
	fa_3_27	:	full_adder	port map(s2(27)(1),	s2(38)(0),	s2(37)(1),	s3(27)(0),	s3(27)(1));
	ha_3_28	:	half_adder	port map(s2(39)(0),	s2(38)(1),				s3(28)(0),	s3(28)(1));
	ha_3_29	:	half_adder	port map(s2(40)(0),	s2(39)(1),				s3(29)(0),	s3(29)(1));
	ha_3_30	:	half_adder	port map(s0(12)(12),s2(40)(1),				s3(30)(0),	s3(30)(1));
	
	-- fourth stage
	
	ha_4_0	:	half_adder	port map(s3(1)(0),	s3(0)(1),				s4(0)(0),	s4(0)(1));
	ha_4_1	:	half_adder	port map(s3(2)(0),	s3(1)(1),				s4(1)(0),	s4(1)(1));
	ha_4_2	:	half_adder	port map(s3(3)(0),	s3(2)(1),				s4(2)(0),	s4(2)(1));
	fa_4_3	:	full_adder	port map(s3(4)(0),	s3(3)(1),	s2(13)(1),	s4(3)(0),	s4(3)(1));
	fa_4_4	:	full_adder	port map(s3(5)(0),	s3(4)(1),	s3(14)(1),	s4(4)(0),	s4(4)(1));
	fa_4_5	:	full_adder	port map(s3(6)(0),	s3(5)(1),	s3(15)(0),	s4(5)(0),	s4(5)(1));
	fa_4_6	:	full_adder	port map(s3(7)(0),	s3(6)(1),	s3(16)(0),	s4(6)(0),	s4(6)(1));
	fa_4_7	:	full_adder	port map(s3(8)(0),	s3(7)(1),	s3(17)(0),	s4(7)(0),	s4(7)(1));
	fa_4_8	:	full_adder	port map(s3(9)(0),	s3(8)(1),	s3(18)(0),	s4(8)(0),	s4(8)(1));
	fa_4_9	:	full_adder	port map(s3(10)(0),	s3(9)(1),	s3(19)(0),	s4(9)(0),	s4(9)(1));
	fa_4_10	:	full_adder	port map(s3(11)(0),	s3(10)(1),	s3(20)(0),	s4(10)(0),	s4(10)(1));
	fa_4_11	:	full_adder	port map(s3(12)(0),	s3(11)(1),	s3(21)(0),	s4(11)(0),	s4(11)(1));
	fa_4_12	:	full_adder	port map(s3(13)(0),	s3(12)(1),	s3(22)(0),	s4(12)(0),	s4(12)(1));
	fa_4_13	:	full_adder	port map(s3(14)(0),	s3(13)(1),	s3(23)(0),	s4(13)(0),	s4(13)(1));
	fa_4_14	:	full_adder	port map(s2(25)(0),	s3(14)(1),	s3(24)(0),	s4(14)(0),	s4(14)(1));
	ha_4_15	:	half_adder	port map(s2(26)(0),	s3(25)(0),				s4(15)(0),	s4(15)(1));
	ha_4_16	:	half_adder	port map(s2(27)(0),	s3(26)(0),				s4(16)(0),	s4(16)(1));
	
	-- fifth stage
	
	ha_5_0	:	half_adder	port map(s4(1)(0),	s4(0)(1),				s5(0)(0),	s5(0)(1));
	ha_5_1	:	half_adder	port map(s4(2)(0),	s4(1)(1),				s5(1)(0),	s5(1)(1));
	ha_5_2	:	half_adder	port map(s4(3)(0),	s4(2)(1),				s5(2)(0),	s5(2)(1));
	ha_5_3	:	half_adder	port map(s4(4)(0),	s4(3)(1),				s5(3)(0),	s5(3)(1));
	ha_5_4	:	half_adder	port map(s4(5)(0),	s4(4)(1),				s5(4)(0),	s5(4)(1));
	fa_5_5	:	full_adder	port map(s4(6)(0),	s4(5)(1),	s3(15)(1),	s5(5)(0),	s5(5)(1));
	fa_5_6	:	full_adder	port map(s4(7)(0),	s4(6)(1),	s3(16)(1),	s5(6)(0),	s5(6)(1));
	fa_5_7	:	full_adder	port map(s4(8)(0),	s4(7)(1),	s3(17)(1),	s5(7)(0),	s5(7)(1));
	fa_5_8	:	full_adder	port map(s4(9)(0),	s4(8)(1),	s3(18)(1),	s5(8)(0),	s5(8)(1));
	fa_5_9	:	full_adder	port map(s4(10)(0),	s4(9)(1),	s3(19)(1),	s5(9)(0),	s5(9)(1));
	fa_5_10	:	full_adder	port map(s4(11)(0),	s4(10)(1),	s3(20)(1),	s5(10)(0),	s5(10)(1));
	fa_5_11	:	full_adder	port map(s4(12)(0),	s4(11)(1),	s3(21)(1),	s5(11)(0),	s5(11)(1));
	fa_5_12	:	full_adder	port map(s4(13)(0),	s4(12)(1),	s3(22)(1),	s5(12)(0),	s5(12)(1));
	fa_5_13	:	full_adder	port map(s4(14)(0),	s4(13)(1),	s3(23)(1),	s5(13)(0),	s5(13)(1));
	fa_5_14	:	full_adder	port map(s4(15)(0),	s4(14)(1),	s3(24)(1),	s5(14)(0),	s5(14)(1));
	fa_5_15	:	full_adder	port map(s4(16)(0),	s4(15)(1),	s3(25)(1),	s5(15)(0),	s5(15)(1));
	fa_5_16	:	full_adder	port map(s3(27)(0),	s4(16)(1),	s3(26)(1),	s5(16)(0),	s5(16)(1));
	ha_5_17	:	half_adder	port map(s3(28)(0),	s3(27)(1),				s5(17)(0),	s5(17)(1));
	ha_5_18	:	half_adder	port map(s3(29)(0),	s3(28)(1),				s5(18)(0),	s5(18)(1));
	ha_5_19	:	half_adder	port map(s3(30)(0),	s3(29)(1),				s5(19)(0),	s5(19)(1));
	
	-- sixth stage
	
	ha_6_0	:	half_adder	port map(s5(1)(0),	s5(0)(1),				s6(0)(0),	s6(0)(1));
	ha_6_1	:	half_adder	port map(s5(2)(0),	s5(1)(1),				s6(1)(0),	s6(1)(1));
	ha_6_2	:	half_adder	port map(s5(3)(0),	s5(2)(1),				s6(2)(0),	s6(2)(1));
	ha_6_3	:	half_adder	port map(s5(4)(0),	s5(3)(1),				s6(3)(0),	s6(3)(1));
	ha_6_4	:	half_adder	port map(s5(5)(0),	s5(4)(1),				s6(4)(0),	s6(4)(1));
	ha_6_5	:	half_adder	port map(s5(6)(0),	s5(5)(1),				s6(5)(0),	s6(5)(1));
	fa_6_6	:	full_adder	port map(s5(7)(0),	s5(6)(1),	xor_msb,	s6(6)(0),	s6(6)(1));
	fa_6_7	:	full_adder	port map(s5(8)(0),	s5(7)(1),	and_msb,	s6(7)(0),	s6(7)(1));
	ha_6_8	:	half_adder	port map(s5(9)(0),	s5(8)(1),				s6(8)(0),	s6(8)(1));
	ha_6_9	:	half_adder	port map(s5(10)(0),	s5(9)(1),				s6(9)(0),	s6(9)(1));
	ha_6_10	:	half_adder	port map(s5(11)(0),	s5(10)(1),				s6(10)(0),	s6(10)(1));
	ha_6_11	:	half_adder	port map(s5(12)(0),	s5(11)(1),				s6(11)(0),	s6(11)(1));
	ha_6_12	:	half_adder	port map(s5(13)(0),	s5(12)(1),				s6(12)(0),	s6(12)(1));
	ha_6_13	:	half_adder	port map(s5(14)(0),	s5(13)(1),				s6(13)(0),	s6(13)(1));
	ha_6_14	:	half_adder	port map(s5(15)(0),	s5(14)(1),				s6(14)(0),	s6(14)(1));
	ha_6_15	:	half_adder	port map(s5(16)(0),	s5(15)(1),				s6(15)(0),	s6(15)(1));
	ha_6_16	:	half_adder	port map(s5(17)(0),	s5(16)(1),				s6(16)(0),	s6(16)(1));
	ha_6_17	:	half_adder	port map(s5(18)(0),	s5(17)(1),				s6(17)(0),	s6(17)(1));
	ha_6_18	:	half_adder	port map(s5(19)(0),	s5(18)(1),				s6(18)(0),	s6(18)(1));
	ha_6_19	:	half_adder	port map(s3(30)(1),	s5(19)(1),				s6(19)(0),	s6(19)(1));
	
	-- final stage
	
	add_a	<=	s6(19)(0)&s6(19)(0)&s6(18)(0)&s6(17)(0)&s6(16)(0)&s6(15)(0)&s6(14)(0)&s6(13)(0)&s6(12)(0)&s6(11)(0)&s6(10)(0)&s6(9)(0)&s6(8)(0)&s6(7)(0)&s6(6)(0)&s6(5)(0)&s6(4)(0)&s6(3)(0)&s6(2)(0)&s6(1)(0)&s6(0)(0)&s5(0)(0)&s4(0)(0)&s3(0)(0)&s2(0)(0)&s1(0)(0)&s0(0)(0);
	tmp		<=	s6(19)(1)&s6(18)(1)&s6(17)(1)&s6(16)(1)&s6(15)(1)&s6(14)(1)&s6(13)(1)&s6(12)(1)&s6(11)(1)&s6(10)(1)&s6(9)(1)&s6(8)(1)&s6(7)(1)&s6(6)(1)&s6(5)(1)&s6(4)(1)&s6(3)(1)&s6(2)(1)&s6(1)(1)&s6(0)(1);
	add_b(26 downto 7)	<=	 tmp;
	add_b(6 downto 0)	<= (others => '0');
	
	sum	:	adder port map(add_a, add_b, tmp_res);
	
	result <= xor_msb&tmp_res(24 downto 0);
	
end architecture structure;