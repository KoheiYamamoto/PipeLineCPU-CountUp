transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/KoheiYamamoto/Desktop/KoheiYamamoto-FPGA/P-CPU-Fin(n=127) {C:/Users/KoheiYamamoto/Desktop/KoheiYamamoto-FPGA/P-CPU-Fin(n=127)/count16rle.v}
vlog -vlog01compat -work work +incdir+C:/Users/KoheiYamamoto/Desktop/KoheiYamamoto-FPGA/P-CPU-Fin(n=127) {C:/Users/KoheiYamamoto/Desktop/KoheiYamamoto-FPGA/P-CPU-Fin(n=127)/cpu.v}
vlog -vlog01compat -work work +incdir+C:/Users/KoheiYamamoto/Desktop/KoheiYamamoto-FPGA/P-CPU-Fin(n=127) {C:/Users/KoheiYamamoto/Desktop/KoheiYamamoto-FPGA/P-CPU-Fin(n=127)/regfile.v}
vlog -vlog01compat -work work +incdir+C:/Users/KoheiYamamoto/Desktop/KoheiYamamoto-FPGA/P-CPU-Fin(n=127) {C:/Users/KoheiYamamoto/Desktop/KoheiYamamoto-FPGA/P-CPU-Fin(n=127)/sm.v}
vlog -vlog01compat -work work +incdir+C:/Users/KoheiYamamoto/Desktop/KoheiYamamoto-FPGA/P-CPU-Fin(n=127) {C:/Users/KoheiYamamoto/Desktop/KoheiYamamoto-FPGA/P-CPU-Fin(n=127)/reg16.v}
vlog -vlog01compat -work work +incdir+C:/Users/KoheiYamamoto/Desktop/KoheiYamamoto-FPGA/P-CPU-Fin(n=127) {C:/Users/KoheiYamamoto/Desktop/KoheiYamamoto-FPGA/P-CPU-Fin(n=127)/muxreg16.v}
vlog -vlog01compat -work work +incdir+C:/Users/KoheiYamamoto/Desktop/KoheiYamamoto-FPGA/P-CPU-Fin(n=127) {C:/Users/KoheiYamamoto/Desktop/KoheiYamamoto-FPGA/P-CPU-Fin(n=127)/cputop.v}
vlog -vlog01compat -work work +incdir+C:/Users/KoheiYamamoto/Desktop/KoheiYamamoto-FPGA/P-CPU-Fin(n=127) {C:/Users/KoheiYamamoto/Desktop/KoheiYamamoto-FPGA/P-CPU-Fin(n=127)/alu.v}
vlog -vlog01compat -work work +incdir+C:/Users/KoheiYamamoto/Desktop/KoheiYamamoto-FPGA/P-CPU-Fin(n=127) {C:/Users/KoheiYamamoto/Desktop/KoheiYamamoto-FPGA/P-CPU-Fin(n=127)/imem.v}
vlog -vlog01compat -work work +incdir+C:/Users/KoheiYamamoto/Desktop/KoheiYamamoto-FPGA/P-CPU-Fin(n=127) {C:/Users/KoheiYamamoto/Desktop/KoheiYamamoto-FPGA/P-CPU-Fin(n=127)/dmem.v}

vlog -vlog01compat -work work +incdir+C:/Users/KoheiYamamoto/Desktop/KoheiYamamoto-FPGA/P-CPU-Fin(n=127) {C:/Users/KoheiYamamoto/Desktop/KoheiYamamoto-FPGA/P-CPU-Fin(n=127)/cpu2_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  cpu_tb

add wave *
view structure
view signals
run -all
