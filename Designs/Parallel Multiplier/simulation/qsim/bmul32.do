onerror {quit -f}
vlib work
vlog -work work bmul32.vo
vlog -work work bmul32.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.bmul32_vlg_vec_tst
vcd file -direction bmul32.msim.vcd
vcd add -internal bmul32_vlg_vec_tst/*
vcd add -internal bmul32_vlg_vec_tst/i1/*
add wave /*
run -all
