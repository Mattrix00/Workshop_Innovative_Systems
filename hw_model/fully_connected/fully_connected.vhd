library ieee;
use ieee.std_logic_1164.all;
use work.fixed_pkg.all; 

package IFMAP_OFMAP_type is

	--constant IFMAP_size : natural := 400;
	--constant OFMAP_size : natural := 120;
	constant PE_number : natural := 20;
	constant qi : natural := 8;
	constant qf : natural := 8;
	
	type IFMAP_type is array(0 to PE_number-1) of sfixed(qi-1 downto -qf);
	
end package IFMAP_OFMAP_type;

library ieee;
use ieee.std_logic_1164.all;
use work.fixed_pkg.all; 

use work.IFMAP_OFMAP_type.all;

entity fully_connected is

  --generic(
    --IFMAP_size : integer;
    --OFMAP_size : integer
    --);
  
	port(	
		CLK, RST_N : in std_logic;
		IFMAP, WEIGHTS : in IFMAP_type;
		OFMAP : out IFMAP_type
    );
	
end entity;

architecture behavior of fully_connected is
	
	component pe
		generic ( 	
			qi : natural := 8; 
			qf : natural := 8 
		);
		port (	
			ck, rstn : in 	std_logic; 	
			im, k  	: in  sfixed( qi-1 downto -qf );
			psum	 	: out sfixed( qi-1 downto -qf )
		);
	end component;
	
begin

	MAC_1_to_20 : for i in 0 to 19 generate 
		mac : pe generic map ( qi => qi, 
							   qf => qf 
							 ) 
				 port map ( ck => CLK, 
				            rstn => RST_N,
							im => IFMAP(i),
							k => WEIGHTS(i), 
							psum => OFMAP(i)
							);
	end generate MAC_1_to_20;

end behavior;