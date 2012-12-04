library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

library work;
use work.array_t.all;
use work.reg.all;

entity iir_sol is
	Port ( 
		Reset : in  STD_LOGIC;
        Clk : in  STD_LOGIC;
        Input : in array32_t(0 to NIN-1);
        Output : out  STD_LOGIC_VECTOR (NBITS-1 downto 0)
	);
end iir_sol;


architecture Structural of iir_sol is
	   
	component reg
    Port ( Reset : STD_LOGIC;
           Clk : STD_LOGIC;
           Load : STD_LOGIC;
           Din : STD_LOGIC_VECTOR (NBITS-1 downto 0);
           Dout : STD_LOGIC_VECTOR (NBITS-1 downto 0));
	end component;

	component comb_part
	port(
		signal comb_a_in : array32_t(0 to NIN-1);
		signal comb_b_in : array32_t(0 to NIN-2);
		signal comb_out : STD_LOGIC_VECTOR (NBITS-1 downto 0)
	   	);
	end component

	signal reg_sig : array32_t(0 to NIN-1);

begin

	Output <= reg_sig(NIN-1); --connect the outpu

	register: for i in 0 to NIN-2 generate		--generate registers and connect them together
		reg port map(Reset,Clk,'1',reg_sig(i+1),reg_sig(i));	
	end generate;

	comb_part port map(Input,reg_sig[0 to comb_b_in'length -1],reg_sig(NIN-1));

end Structural;

