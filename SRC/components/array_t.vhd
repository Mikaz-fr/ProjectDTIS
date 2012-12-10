--EPFL
--DTIS PROJECT
--Michael Roy
--December 2012

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;


PACKAGE array_t IS
	TYPE array32_t IS array (natural range <>) of std_logic_vector(31 downto 0);
	TYPE array_int_t IS array (natural range <>) of integer;
	constant fir_const: array32_t(0 to 9) := (
		x"00000003",
		x"00000019",
		x"00000060",
		x"00000180",
		x"00000C01",
		x"00000C01",
		x"00000180",
		x"00000060",
		x"00000019",
		x"00000003"
	);


	--Here are all the defined use in other files (useful to easily tweak configuration)


	constant NIN: natural := 10;					--Number of inputs (A side)
	constant NBITS: natural := 32;					--Input width
	constant A_WIDTH: natural := 24;				--Width of A size after expansion for shifting
	constant B_WIDTH: natural := 23;				--Same for B side
	constant NLEVEL_A : natural := 9; 				--Number of levels needed to sum in a tree all inputs from A side (pipeline included)
	constant NLEVEL_B : natural := 11; 				--Same for B side
	constant ELEM_ADDER : natural := 0;				--Alias to have more understandable names
	constant ELEM_REG : natural := 1;
	constant NPIPE : natural := 3;					--Number of pipelining
	constant N_DIRECT_JUMP : natural := 7;			--Feedback need to be send to lower level in order to avoid delay induced by pipelines
	TYPE net_mat is array (natural range <>) of array32_t(0 to A_WIDTH-1);	--Matrix of wire for adding tree, each entry is expanded in maximum 3 shifts, and there is NIN entries
	TYPE vect5 is array (0 to 4) of natural;		
	TYPE vect2 is array (0 to 1) of natural;
	TYPE matrix_vect2 is array (natural range <>) of vect2;
	TYPE matrix_vect5 is array (natural range <>) of vect5;
	constant a_shift_arr: matrix_vect5(0 to (NIN/2)-1) := (
		(2,1,0,0,0),			--Number of shifts, shifts values (2 or 3) and index in wire matrix
		(3,4,3,0,2),
		(2,6,5,0,5),
		(2,8,7,0,7),
		(3,11,10,0,9)
		);
	constant b_shift_arr: matrix_vect5(0 to (NIN/2)-1) := (
		(2,2,0,0,0),
		(2,5,4,0,2),
		(3,6,3,2,4),
		(3,8,6,0,7),
		(3,10,9,2,10)
		);
	constant a_elem_index: matrix_vect2(0 to NLEVEL_A-2) := (		--Index of adding tree: number of adders and number of registers
		(12, 0),
		(0, 12),	--Pipeline
		(6, 0),
		(3, 0),
		(0, 3),		--Pipeline
		(1, 0),
		(1, 0),
		(0, 1)		--Pipeline
	   );		

	constant b_elem_index: matrix_vect2(0 to NLEVEL_B-2) := (
		(8, 0),
		(4, 0),
		(0, 4),		--Pipeline
		(3, 0),
		(2, 0),
		(0, 2),		--Pipeline
		(2, 0),
		(1, 0),
		(0, 1),		--Pipeline
		(1, 0)
	   );

	constant feedb_jump_index: matrix_vect2(0 to N_DIRECT_JUMP-1) := (		--Index for feedback shortcut (to balance delay induced by pipelines)
		(9, 1),
		(10, 1),
		(6, 2),
		(6, 3),
		(3, 4),
		(3, 5),
		(3, 6)
		);
END array_t;
