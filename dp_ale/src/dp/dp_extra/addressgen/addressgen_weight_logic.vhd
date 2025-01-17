library ieee;
use ieee.std_logic_1164.all;
use work.dp_pkg.all;

entity addressgen_weight_logic is

    port (
        en_offs_i    : in  std_logic;   --!mem_rd_weight
        idx_cnt_en_i : in  idx_cnt_en_t;
        idx_cnt_tc_i : in  idx_cnt_tc_t;
        cmd_o        : out addressgen_weight_cmd_t

        );

end entity;

architecture gate of addressgen_weight_logic is
begin

    cmd_o.en_offs  <= en_offs_i;
    cmd_o.en_base  <= idx_cnt_tc_i.block_x and idx_cnt_en_i.block_x;
    cmd_o.clr_offs <= idx_cnt_en_i.block_y;
    cmd_o.clr_base <= '0';
    
end architecture;
