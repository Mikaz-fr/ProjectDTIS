library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

library work;
use work.array_t.all;

entity comb_part is
	port(
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

	signal a_web : net_mat(0 to NLEVEL-1); --there is 8 different level of wire to pass from entries to single result from a side
	signal b_web : net_mat(0 to NLEVEL-1); --there is 8 different level of wire to pass from entries to single result from b side
  signal temp_out : STD_LOGIC_VECTOR (NBITS-1 downto 0); 

begin

	--Handle A side
	--Handle shift stage
	a_1: for i in 0 to (NIN/2)-1 generate				--generate for each entry (do symmetry)
		a_2: for j in 0 to a_shift_arr(i)(0)-1 generate 	--generate for each shift of this entry
			a_web(0)(a_shift_arr(i)(4) + j) <= std_logic_vector(unsigned(comb_a_in(i)) sll a_shift_arr(i)(j+1));	--a0 to a4
			a_web(0)(A_WIDTH-1 - (a_shift_arr(i)(4) + j)) <= std_logic_vector(unsigned(comb_a_in(NIN-1-i)) sll a_shift_arr(i)(j+1));	--a9 to a5
		end generate;
	end generate;


	a_3: for k in 0 to NLEVEL-2 generate					--generate adders for each level	
		a_4: for l in 0 to a_adder_index(k)-1 generate
			a_add: adder port map(a_web(k)(2*l),a_web(k)(2*l +1),a_web(k+1)(l));
		end generate a_4;
		a_5: if k = 3 generate		--when number of wire is odd, no need for adder
			a_web(k+1)(a_adder_index(k)) <= a_web(k)(2*a_adder_index(k));
		end generate a_5;
	end generate a_3;


	--Handle B side
	--Handle shift stage
	b_1: for i in 0 to (NIN/2)-1 generate				--generate for each entry (do symmetry)
		b_2: for j in 0 to b_shift_arr(i)(0)-1 generate 	--generate for each shift of this entry
			b_web(0)(b_shift_arr(i)(4) + j) <= std_logic_vector(unsigned(comb_b_in(i)) sll b_shift_arr(i)(j+1));	--b0 to b4
			b_6: if i /= 4 generate --no symetry for b4
			   b_web(0)(B_WIDTH-1 - (b_shift_arr(i)(4) + j)) <= std_logic_vector(unsigned(comb_b_in(NIN-2-i)) sll b_shift_arr(i)(j+1));	--b8 to b5
		  end generate;
		end generate;
	end generate;


	b_3: for k in 0 to NLEVEL-2 generate					--generate adders for each level	
		b_4: for l in 0 to b_adder_index(k)-1 generate
			 b_add: adder port map(b_web(k)(2*l),b_web(k)(2*l +1),b_web(k+1)(l));
		end generate b_4;
		b_5: if (k = 3 OR k = 0) generate		--when number of wire is odd, no need for adder
			b_web(k+1)(b_adder_index(k)) <= b_web(k)(2*b_adder_index(k));
		end generate b_5;
	end generate b_3;


	--Output
	out_1: adder port map(a_web(NLEVEL-1)(0),b_web(NLEVEL-1)(0),temp_out);
  comb_out <= temp_out;

end Structural;

