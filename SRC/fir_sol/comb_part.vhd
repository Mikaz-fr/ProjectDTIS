library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

library work;
use work.array_t.all;

entity comb_part is
	port(
		signal comb_a_in : array32_t(0 to NIN-1);
		signal comb_b_in : array32_t(0 to NIN-2);
		signal comb_out : STD_LOGIC_VECTOR (NBITS-1 downto 0)
	);
end comb_part;


architecture Structural of comb_part is

	component adder
    Port ( A : in  STD_LOGIC_VECTOR (NBITS-1 downto 0);
           B : in  STD_LOGIC_VECTOR (NBITS-1 downto 0);
           O : out  STD_LOGIC_VECTOR (NBITS-1 downto 0)
        );
	end component;

	signal a_web : net_mat(0 to NLEVEL-1); --there is 8 different level of wire to pass from entries to single result from a side
	variable a_ind_div2 : natural := A_WIDTH;
	signal b_web : net_mat(0 to NLEVEL-1); --there is 8 different level of wire to pass from entries to single result from b side
	variable b_ind_desc : natural := B_WIDTH;
	variable b_ind_asc : natural := 0;
	variable b_ind_div2 : natural := B_WIDTH;

begin

	--Handle A side
	--Handle shift stage
	a_1: for i in 0 to (NIN/2)-1 generate				--generate for each entry (do symmetry)
		a_2: for j in 0 to a_shift_arr(i)(0) generate 	--generate for each shift of this entry
			a_web(0)(a_shift_arr(i)(4) + j) <= std_logic_vector(unsigned(comb_a_in(i)) sll a_shift_arr(i)(j+1));	--a0 to a4
			a_web(0)(A_WIDTH - (a_shift_arr(i)(4) + j)) <= std_logic_vector(unsigned(comb_a_in(NIN-1-i)) sll a_shift_arr(i)(j+1));	--a9 to a5
		end generate;
	end generate;


	a_3: for k in 1 to NLEVEL-2 generate					--generate adders for each level	
		a_4: for l in 0 to (a_ind_div2/2)-1 generate
			addder port map(a_web(k)(2*l),a_web(k)(2*l +1),a_web(k+1)(l));
		end generate;
		if (a_ind_div2 mod 2) then		--when number of wire is odd, no need for adder
			a_web(k+1)(a_ind_div2) <= a_web(k)(a_ind_div2/2);
		end if;
		a_ind_div2 := (a_ind_div2 /2);		--divide by two (rounddown)
	end generate;


	--Handle B side
	--Handle shift stage
	b_1: for i in 0 to (NIN/2)-1 generate				--generate for each entry (do symmetry)
		b_2: for j in 0 to b_shift_arr(i)(0) generate 	--generate for each shift of this entry
			b_web(0)(b_shift_arr(i)(4) + j) <= comb_b_in(i) sll b_shift_arr(i)(j+1);	--b0 to b4
			if i /= 4 then	--no symetry for b4
				b_web(0)(B_WIDTH - (b_shift_arr(i)(4) + j)) <= comb_b_in(NIN-1-i) sll b_shift_arr(i)(j+1);	--b9 to b5
			end if;
		end generate;
	end generate;

	b_3: for k in 1 to NLEVEL-2 generate					--generate adders for each level	
		b_4: for l in 0 to (b_ind_div2/2)-1 generate
			addder port map(b_web(k)(2*l),b_web(k)(2*l +1),b_web(k+1)(l));
		end generate;
		if (b_ind_div2 mod 2) then		--when number of wire is odd, no need for adder
			b_web(k+1)(b_ind_div2) <= b_web(k)(b_ind_div2/2);
		end if;
		b_ind_div2 := (b_ind_div2 /2);		--divide by two (rounddown)
	end generate;


	--Output
	adder port map(a_web(NLEVEL-1)(0),b_web(NLEVEL-1)(0),comb_out);


end Structural;

