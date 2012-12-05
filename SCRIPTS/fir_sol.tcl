# A clean start is always good. 
# do not use -all, that one will delete all std cell libraries
remove_design -designs 

# analyze the design

#*******************************************
#TODO: add extra source files here

analyze -f vhdl ./SRC/components/adder.vhd
#analyze -f vhdl ./SRC/components/mul.vhd
analyze -f vhdl ./SRC/components/reg.vhd
analyze -f vhdl ./SRC/components/array_t.vhd
analyze -f vhdl ./SRC/fir_sol/comb_part.vhd

#*******************************************

analyze -f vhdl ./SRC/fir_sol/iir_sol.vhd
analyze -f vhdl ./SRC/fir_sol/iir_sol_wrapper.vhd

# elaborate the design 
elaborate iir_sol_wrapper

# set delay constraints
create_clock "Clk" -name "global_clk" -period 4.3

# now let's just compile and see what comes up 
compile


# get some useful report about area and timing   
report_timing  
report_area
