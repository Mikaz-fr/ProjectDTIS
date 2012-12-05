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

	constant NIN: natural := 10;		--number of inputs
	constant NBITS: natural := 32;	-- input size
	constant A_WIDTH: natural := 24;
	constant B_WIDTH: natural := 23;
	constant NLEVEL : natural := 8; 	--Pipeline included
	constant ELEM_ADDER : natrual := 0;
	constant ELEM_REG : natrual := 1;
	TYPE net_mat is array (natural range <>) of array32_t(0 to A_WIDTH-1);	--matrix of wire, each entry has maximum 3 entries and there is NIN entries
	TYPE vect5 is array (0 to 4) of natural;	--number of element, then shifts numbers
	TYPE vect2 is array (0 to 1) of natural
	TYPE matrix_vect is array (natural range <>) of vect5;
	constant a_shift_arr: matrix_vect(0 to (NIN/2)-1) := (
		(2,1,0,0,0),
		(3,4,3,0,2),
		(2,6,5,0,5),
		(2,8,7,0,7),
		(3,11,10,0,9)
		);
	constant b_shift_arr: matrix_vect(0 to (NIN/2)-1) := (
		(2,2,0,0,0),
		(2,5,4,0,2),
		(3,6,3,2,4),
		(3,8,6,0,7),
		(3,10,9,2,10)
		);
	constant a_elem_index: vect2(0 to NLEVEL-2) := (
		(12, 0),
		(6, 0),
		(0, 6),
		(3, 0),
		(1, 0),
		(0, 2),
		(1, 0)
	   );		

	constant b_elem_index: vect2(0 to NLEVEL-2) := (
		(11, 0),
		(6, 0),
		(0, 6),
		(3, 0),
		(1, 0),
		(0, 2),
		(1, 0)
	   );
END array_t;
