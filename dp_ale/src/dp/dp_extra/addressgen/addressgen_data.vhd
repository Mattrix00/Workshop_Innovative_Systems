library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.mem_pkg.all;
use work.dp_pkg.all;

    --! @ brief row-major ordered memory layout (TILING)

    --! 1.      addr_block_x_int is the base value required to correctly handle the
    --!         overlap of sliding windows UNROLLING-FACTOR 2 -> even/odd

    --! 2.      addr_block_y_int is the base value required to correctly handle the
    --!         overlap of input blocks in multi-dim convolution

    --! 3.      addr_nif_int is the base value required to keep constant stride during mac_op
    --!         sliding window computations on multiple blocks for different channels

    --! 4.      addr_word_int is the block offset referenced during mac_op


entity addressgen is
    generic (N : natural := ADDR_WIDTH_INT);

    port(
        clk      : in  std_logic;
        rst_n    : in  std_logic;
        cmd_i    : in  addressgen_cmd_t;
        stride_i : in  addressgen_stride_t;
        addr_o   : out addressgen_q_t

        );

end entity;

architecture beh of addressgen is
    
    signal addr_block_x_even_int : unsigned(N-1 downto 0);
    signal addr_block_x_odd_int  : unsigned(N-1 downto 0);
    signal addr_block_y_int      : unsigned(N-1 downto 0);
    signal addr_word_int         : unsigned(N-1 downto 0);
    signal addr_nif_int          : unsigned(N-1 downto 0);
begin



    --! block_x_even
    process(clk, rst_n)
    begin

        if(rst_n = '0') then

            addr_block_x_even_int <= (others => '0');
            
        elsif rising_edge(clk) then
            
            if (cmd_i.clr_block_x_even = '1') then
                
                addr_block_x_even_int <= (others => '0');

            elsif (cmd_i.en_block_x_even = '1') then

                addr_block_x_even_int <= addr_block_x_even_int + unsigned(stride_i.block_x);
                
            end if;
            
        end if;
        
    end process;




    --! block_x_odd
    process(clk, rst_n)
    begin

        if(rst_n = '0') then

            addr_block_x_odd_int <= (others => '0');
            
        elsif rising_edge(clk) then
            
            if (cmd_i.clr_block_x_odd = '1') then
                
                addr_block_x_odd_int <= (others => '0');
                
            elsif (cmd_i.en_block_x_odd = '1') then
                
                addr_block_x_odd_int <= addr_block_x_odd_int + unsigned(stride_i.block_x);
                
            end if;
            
        end if;

    end process;




    --! block_y
    process(clk, rst_n)
    begin

        if(rst_n = '0') then

            addr_block_y_int <= (others => '0');
            
        elsif rising_edge(clk) then
            
            if (cmd_i.clr_block_y = '1') then
                
                addr_block_y_int <= (others => '0');
                
            elsif (cmd_i.en_block_y = '1') then
                
                addr_block_y_int <= addr_block_y_int + unsigned(stride_i.block_y);
                
            end if;
            
        end if;

    end process;




    --! nif offset
    process(clk, rst_n)
    begin

        if(rst_n = '0') then

            addr_nif_int <= (others => '0');
            
        elsif rising_edge(clk) then
            
            if (cmd_i.clr_nif = '1') then
                
                addr_nif_int <= (others => '0');

            elsif (cmd_i.en_nif = '1') then
                
                addr_nif_int <= addr_nif_int + unsigned(stride_i.nif);
                
            end if;
            
        end if;

    end process;




    --! word offset
    process(clk, rst_n)
    begin

        if(rst_n = '0') then

            addr_word_int <= (others => '0');
            
        elsif rising_edge(clk) then
            
            if (cmd_i.clr_word = '1') then
                
                addr_word_int <= (others => '0');

            elsif (cmd_i.en_word = '1') then
                
                addr_word_int <= addr_word_int + unsigned(stride_i.word);
                
            end if;
            
        end if;

    end process;

    addr_o.even <= std_logic_vector(addr_block_y_int + addr_block_x_even_int + addr_nif_int + addr_word_int);
    addr_o.odd  <= std_logic_vector(addr_block_y_int + addr_block_x_odd_int + addr_nif_int + addr_word_int);





end architecture;

