onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /top_tb/clk
add wave -noupdate /top_tb/SW0
add wave -noupdate /top_tb/SW1
add wave -noupdate /top_tb/SW2
add wave -noupdate /top_tb/SW3
add wave -noupdate /top_tb/SW4
add wave -noupdate /top_tb/SW5
add wave -noupdate /top_tb/SW6
add wave -noupdate /top_tb/SW7
add wave -noupdate /top_tb/SW8
add wave -noupdate /top_tb/SW9
add wave -noupdate /top_tb/Key0
add wave -noupdate /top_tb/Key1
add wave -noupdate /top_tb/Key2
add wave -noupdate /top_tb/Key3
add wave -noupdate /top_tb/HEX0
add wave -noupdate /top_tb/HEX1
add wave -noupdate /top_tb/HEX2
add wave -noupdate /top_tb/HEX3
add wave -noupdate /top_tb/HEX4
add wave -noupdate /top_tb/HEX5
add wave -noupdate /top_tb/LEDR0
add wave -noupdate /top_tb/LEDR1
add wave -noupdate /top_tb/LEDR2
add wave -noupdate /top_tb/LEDR3
add wave -noupdate /top_tb/LEDR5
add wave -noupdate /top_tb/LEDR6
add wave -noupdate /top_tb/LEDR7
add wave -noupdate /top_tb/LEDR8
add wave -noupdate /top_tb/LEDR9
add wave -noupdate /top_tb/GPIO9
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {199999184 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
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
configure wave -timelineunits ps
update
WaveRestoreZoom {199999050 ps} {200000050 ps}
