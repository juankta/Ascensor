onerror {exit -code 1}
vlib work
vlog -work work alarma.vo
vlog -work work Waveform4.vwf.vt
vsim -novopt -c -t 1ps -L cycloneiii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.alarma_vlg_vec_tst -voptargs="+acc"
vcd file -direction alarma.msim.vcd
vcd add -internal alarma_vlg_vec_tst/*
vcd add -internal alarma_vlg_vec_tst/i1/*
run -all
quit -f
