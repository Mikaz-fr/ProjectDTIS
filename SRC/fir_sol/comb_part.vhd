--EPFL
--DTIS PROJECT
--Michael Roy
--December 2012

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

library work;
use work.array_t.all;

entity comb_part is
	port(
		signal Reset : in  STD_LOGIC;
        signal Clk : in  STD_LOGIC;
		signal comb_a_in : in array32_t(0 to NIN-1);
		signal comb_b_in : in array32_t(0 to NIN-2);
		signal comb_out : out STD_LOGIC_VECTOR (NBITS-1 downto 0)
	);
end comb_part;


architecture Structural of comb_part is

	component adder
    Port ( A :  in STD_LOGIC_VECTOR (NBITS-1 downto 0);
           B :  in STD_LOGIC_VECTOR (NBITS-1 downto 0);
           O :  out STD_LOGIC_VECTOR (NBITS-1 downto 0)
        );
	end component;

	component reg 
    Port ( Reset : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           Load : in  STD_LOGIC;
           Din : in  STD_LOGIC_VECTOR (31 downto 0);
           Dout : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;

	signal a_web : net_mat(0 to NLEVEL_A-1); 							--There is NLEVEL_A different level of wire to reduce from entries to single result 
	signal b_web : net_mat(0 to NLEVEL_B-1); 							
  	signal temp_out, temp_mix : STD_LOGIC_VECTOR (NBITS-1 downto 0); 

begin
	--In this file we reduce each entry side (A and B) to a single result with adders. 
	--Pipelining is used to match requirements


	--*************
	--Handle A side
	--Handle shift stage
	a_1: for i in 0 to (NIN/2)-1 generate							--Generate shifts for each entry (do symmetry)
		a_2: for j in 0 to a_shift_arr(i)(0)-1 generate 			--Generate wiring for each shift of a specific entry
			a_web(0)(a_shift_arr(i)(4) + j) <= std_logic_vector(unsigned(comb_a_in(i)) sll a_shift_arr(i)(j+1));						--a0 to a4
			a_web(0)(A_WIDTH-1 - (a_shift_arr(i)(4) + j)) <= std_logic_vector(unsigned(comb_a_in(NIN-1-i)) sll a_shift_arr(i)(j+1));	--a9 to a5
		end generate;
	end generate;

	--Handle adder + pipelining stages
	a_3: for k in 0 to NLEVEL_A-2 generate							--Generate adders or pipeline for each level	
		a_4: for l in 0 to a_elem_index(k)(ELEM_ADDER)-1 generate
			a_add: adder port map(a_web(k)(2*l),a_web(k)(2*l +1),a_web(k+1)(l));
		end generate a_4;
		a_5: if k = 5 generate										--When number of wire is odd, last wire is transmitted to next level
			a_web(k+1)(a_elem_index(k)(ELEM_ADDER)) <= a_web(k)(2*a_elem_index(k)(ELEM_ADDER));
		end generate a_5;
		ap_1: for m in 0 to a_elem_index(k)(ELEM_REG)-1 generate	--Registers for pipelining
			a_reg: reg port map(Reset, Clk, '1', a_web(k)(m),a_web(k+1)(m));
		end generate;
	end generate a_3;


	--*************
	--Handle B side
	--Handle shift stage
	b_1: for i in 0 to (NIN/2)-1 generate							--Generate for each entry (do partial symmetry)
		b_2: for j in 0 to b_shift_arr(i)(0)-1 generate 			--Generate wiring for each shift of a specific entry
			b_web(0)(b_shift_arr(i)(4) + j) <= std_logic_vector(unsigned(comb_b_in(i)) sll b_shift_arr(i)(j+1));						--b0 to b4
			b_6: if i /= 4 generate 																									--no symmetry for b4
			   b_web(0)(B_WIDTH-1 - (b_shift_arr(i)(4) + j)) <= std_logic_vector(unsigned(comb_b_in(NIN-2-i)) sll b_shift_arr(i)(j+1));	--b8 to b5
		  end generate;
		end generate;
	end generate;

	--Handle direct wiring (shortcut) for early feedback
	bj_1: for i in 0 to N_DIRECT_JUMP-1 generate	
		b_web(feedb_jump_index(i)(0))(feedb_jump_index(i)(1)) <= b_web(0)(B_WIDTH-1-i);
	end generate; 

	--Handle adder + pipelining stages
	b_3: for k in 0 to NLEVEL_B-2 generate							--Generate adders or pipeline for each level
		b_4: for l in 0 to b_elem_index(k)(ELEM_ADDER)-1 generate
			 b_add: adder port map(b_web(k)(2*l),b_web(k)(2*l +1),b_web(k+1)(l));
		end generate b_4;
		b_5: if (k = 3) generate									--When number of wire is odd, last wire is transmitted to next level
			b_web(k+1)(b_elem_index(k)(ELEM_ADDER)) <= b_web(k)(2*b_elem_index(k)(ELEM_ADDER));
		end generate b_5;
		bp_1: for m in 0 to b_elem_index(k)(ELEM_REG)-1 generate	--Registers for pipelining
			b_reg: reg port map(Reset, Clk, '1', b_web(k)(m),b_web(k+1)(m));
		end generate;
	end generate b_3;


	--*************
	--Add A and B for last stages to optimize, since B is longer than A
	mix_1: adder port map(a_web(NLEVEL_A-1)(0),b_web(NLEVEL_B-1)(1),temp_mix);

	--Output
	out_1: adder port map(temp_mix,b_web(NLEVEL_B-1)(0),temp_out);
  	comb_out <= temp_out;

end Structural;

