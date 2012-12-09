library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

library work;
use work.array_t.all;

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
    Port ( Reset : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           Load : in  STD_LOGIC;
           Din : in  STD_LOGIC_VECTOR (31 downto 0);
           Dout : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;

	component comb_part
	port(
		signal Reset : in  STD_LOGIC;
        signal Clk : in  STD_LOGIC;
		signal comb_a_in : in array32_t(0 to NIN-1);
		signal comb_b_in : in array32_t(0 to NIN-2);
		signal comb_out : out STD_LOGIC_VECTOR (NBITS-1 downto 0)
	   	);
	end component;

	signal reg_sig : array32_t(0 to NIN-1);

begin
	
	Output <= (others => '0') when Reset = '1' else reg_sig(NIN-1); --connect the output

	regi1: for i in NIN-NPIPE-1 to NIN-2 generate		--generate registers for early feedback
		regi2: reg port map(Reset,Clk,'1',reg_sig(NIN-1),reg_sig(i));	
	end generate;

	reg_sig(NIN-NPIPE-2) <= reg_sig(NIN-NPIPE-1);	--make transition

	regi3: for i in 0 to NIN-NPIPE-3 generate		--generate rest of registers and connect them together
			regi4: reg port map(Reset,Clk,'1',reg_sig(i+1),reg_sig(i));	
	end generate;

	comb: comb_part port map(Reset, Clk, Input,reg_sig(0 to NIN-2),reg_sig(NIN-1));

end Structural;

