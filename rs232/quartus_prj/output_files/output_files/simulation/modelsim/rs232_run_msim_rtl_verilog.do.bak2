transcript on
if ![file isdirectory verilog_libs] {
	file mkdir verilog_libs
}

vlib verilog_libs/altera_ver
vmap altera_ver ./verilog_libs/altera_ver
vlog -vlog01compat -work altera_ver {d:/program files/altera/quartus/eda/sim_lib/altera_primitives.v}

vlib verilog_libs/lpm_ver
vmap lpm_ver ./verilog_libs/lpm_ver
vlog -vlog01compat -work lpm_ver {d:/program files/altera/quartus/eda/sim_lib/220model.v}

vlib verilog_libs/sgate_ver
vmap sgate_ver ./verilog_libs/sgate_ver
vlog -vlog01compat -work sgate_ver {d:/program files/altera/quartus/eda/sim_lib/sgate.v}

vlib verilog_libs/altera_mf_ver
vmap altera_mf_ver ./verilog_libs/altera_mf_ver
vlog -vlog01compat -work altera_mf_ver {d:/program files/altera/quartus/eda/sim_lib/altera_mf.v}

vlib verilog_libs/altera_lnsim_ver
vmap altera_lnsim_ver ./verilog_libs/altera_lnsim_ver
vlog -sv -work altera_lnsim_ver {d:/program files/altera/quartus/eda/sim_lib/altera_lnsim.sv}

vlib verilog_libs/maxii_ver
vmap maxii_ver ./verilog_libs/maxii_ver
vlog -vlog01compat -work maxii_ver {d:/program files/altera/quartus/eda/sim_lib/maxii_atoms.v}

if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/temp/hff/rs232/rtl {D:/temp/hff/rs232/rtl/uart_tx.v}
vlog -vlog01compat -work work +incdir+D:/temp/hff/rs232/rtl {D:/temp/hff/rs232/rtl/uart_rx.v}
vlog -vlog01compat -work work +incdir+D:/temp/hff/rs232/rtl {D:/temp/hff/rs232/rtl/rs232.v}

vlog -vlog01compat -work work +incdir+D:/temp/hff/rs232/quartus_prj/output_files/output_files/../../../sim {D:/temp/hff/rs232/quartus_prj/output_files/output_files/../../../sim/tb_rs232.v}
vlog -vlog01compat -work work +incdir+D:/temp/hff/rs232/quartus_prj/output_files/output_files/../../../sim {D:/temp/hff/rs232/quartus_prj/output_files/output_files/../../../sim/tb_uart_rx.v}
vlog -vlog01compat -work work +incdir+D:/temp/hff/rs232/quartus_prj/output_files/output_files/../../../sim {D:/temp/hff/rs232/quartus_prj/output_files/output_files/../../../sim/tb_uart_tx.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L maxii_ver -L rtl_work -L work -voptargs="+acc"  tb_rs232

add wave *
view structure
view signals
run -all
