library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--// multiplier-adder

entity prod_sum is
  port(
    ck      : in  std_logic;
    rst     : in  std_logic;
    en      : in  std_logic;
    i_gamma : in  signed(7 downto 0);   --//Q2.6
    i_beta  : in  signed(7 downto 0);   --//Q2.6
    i_data  : in  signed(7 downto 0);   --//Q6.2
    o_data  : out signed(15 downto 0)   --//Q8.8
    );
end entity;

architecture beh of prod_sum is

  signal ps_en    : std_logic;
  signal int_beta : signed(15 downto 0);
  signal int_prod : signed(15 downto 0);

begin

  --// align data from Q2.6 to Q8.8
  int_beta <= (to_signed(to_integer(i_beta), int_beta'length)) sll 2;

  process(ck, rst)
  begin
    if rst = '1' then
      ps_en <= '0';
    elsif rising_edge(ck) then
      ps_en <= en;
    end if;
  end process;

  process(ck, rst)
  begin
    if rst = '1' then
      int_prod <= (others => '0');
    elsif rising_edge(ck) then
      if en = '1' then
        int_prod <= i_data * i_gamma;
      end if;
    end if;
  end process;

  process(ck, rst)
  begin
    if rst = '1' then
      o_data <= (others => '0');
    elsif rising_edge(ck) then
      if ps_en = '1' then
        o_data <= int_prod + int_beta;
      end if;
    end if;
  end process;

end architecture;