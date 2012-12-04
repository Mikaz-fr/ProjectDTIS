onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /iir_sol_wrapper/Reset
add wave -noupdate /iir_sol_wrapper/Clk
add wave -noupdate -radix unsigned /iir_sol_wrapper/Input
add wave -noupdate -radix unsigned /iir_sol_wrapper/Output
add wave -noupdate -radix unsigned -childformat {{/iir_sol_wrapper/del(0) -radix unsigned} {/iir_sol_wrapper/del(1) -radix unsigned} {/iir_sol_wrapper/del(2) -radix unsigned} {/iir_sol_wrapper/del(3) -radix unsigned} {/iir_sol_wrapper/del(4) -radix unsigned} {/iir_sol_wrapper/del(5) -radix unsigned} {/iir_sol_wrapper/del(6) -radix unsigned} {/iir_sol_wrapper/del(7) -radix unsigned} {/iir_sol_wrapper/del(8) -radix unsigned} {/iir_sol_wrapper/del(9) -radix unsigned}} -expand -subitemconfig {/iir_sol_wrapper/del(0) {-radix unsigned} /iir_sol_wrapper/del(1) {-radix unsigned} /iir_sol_wrapper/del(2) {-radix unsigned} /iir_sol_wrapper/del(3) {-radix unsigned} /iir_sol_wrapper/del(4) {-radix unsigned} /iir_sol_wrapper/del(5) {-radix unsigned} /iir_sol_wrapper/del(6) {-radix unsigned} /iir_sol_wrapper/del(7) {-radix unsigned} /iir_sol_wrapper/del(8) {-radix unsigned} /iir_sol_wrapper/del(9) {-radix unsigned}} /iir_sol_wrapper/del
add wave -noupdate -radix unsigned -childformat {{/iir_sol_wrapper/outs(31) -radix unsigned} {/iir_sol_wrapper/outs(30) -radix unsigned} {/iir_sol_wrapper/outs(29) -radix unsigned} {/iir_sol_wrapper/outs(28) -radix unsigned} {/iir_sol_wrapper/outs(27) -radix unsigned} {/iir_sol_wrapper/outs(26) -radix unsigned} {/iir_sol_wrapper/outs(25) -radix unsigned} {/iir_sol_wrapper/outs(24) -radix unsigned} {/iir_sol_wrapper/outs(23) -radix unsigned} {/iir_sol_wrapper/outs(22) -radix unsigned} {/iir_sol_wrapper/outs(21) -radix unsigned} {/iir_sol_wrapper/outs(20) -radix unsigned} {/iir_sol_wrapper/outs(19) -radix unsigned} {/iir_sol_wrapper/outs(18) -radix unsigned} {/iir_sol_wrapper/outs(17) -radix unsigned} {/iir_sol_wrapper/outs(16) -radix unsigned} {/iir_sol_wrapper/outs(15) -radix unsigned} {/iir_sol_wrapper/outs(14) -radix unsigned} {/iir_sol_wrapper/outs(13) -radix unsigned} {/iir_sol_wrapper/outs(12) -radix unsigned} {/iir_sol_wrapper/outs(11) -radix unsigned} {/iir_sol_wrapper/outs(10) -radix unsigned} {/iir_sol_wrapper/outs(9) -radix unsigned} {/iir_sol_wrapper/outs(8) -radix unsigned} {/iir_sol_wrapper/outs(7) -radix unsigned} {/iir_sol_wrapper/outs(6) -radix unsigned} {/iir_sol_wrapper/outs(5) -radix unsigned} {/iir_sol_wrapper/outs(4) -radix unsigned} {/iir_sol_wrapper/outs(3) -radix unsigned} {/iir_sol_wrapper/outs(2) -radix unsigned} {/iir_sol_wrapper/outs(1) -radix unsigned} {/iir_sol_wrapper/outs(0) -radix unsigned}} -subitemconfig {/iir_sol_wrapper/outs(31) {-radix unsigned} /iir_sol_wrapper/outs(30) {-radix unsigned} /iir_sol_wrapper/outs(29) {-radix unsigned} /iir_sol_wrapper/outs(28) {-radix unsigned} /iir_sol_wrapper/outs(27) {-radix unsigned} /iir_sol_wrapper/outs(26) {-radix unsigned} /iir_sol_wrapper/outs(25) {-radix unsigned} /iir_sol_wrapper/outs(24) {-radix unsigned} /iir_sol_wrapper/outs(23) {-radix unsigned} /iir_sol_wrapper/outs(22) {-radix unsigned} /iir_sol_wrapper/outs(21) {-radix unsigned} /iir_sol_wrapper/outs(20) {-radix unsigned} /iir_sol_wrapper/outs(19) {-radix unsigned} /iir_sol_wrapper/outs(18) {-radix unsigned} /iir_sol_wrapper/outs(17) {-radix unsigned} /iir_sol_wrapper/outs(16) {-radix unsigned} /iir_sol_wrapper/outs(15) {-radix unsigned} /iir_sol_wrapper/outs(14) {-radix unsigned} /iir_sol_wrapper/outs(13) {-radix unsigned} /iir_sol_wrapper/outs(12) {-radix unsigned} /iir_sol_wrapper/outs(11) {-radix unsigned} /iir_sol_wrapper/outs(10) {-radix unsigned} /iir_sol_wrapper/outs(9) {-radix unsigned} /iir_sol_wrapper/outs(8) {-radix unsigned} /iir_sol_wrapper/outs(7) {-radix unsigned} /iir_sol_wrapper/outs(6) {-radix unsigned} /iir_sol_wrapper/outs(5) {-radix unsigned} /iir_sol_wrapper/outs(4) {-radix unsigned} /iir_sol_wrapper/outs(3) {-radix unsigned} /iir_sol_wrapper/outs(2) {-radix unsigned} /iir_sol_wrapper/outs(1) {-radix unsigned} /iir_sol_wrapper/outs(0) {-radix unsigned}} /iir_sol_wrapper/outs
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {511 ns} 0}
configure wave -namecolwidth 213
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {1059 ns}
