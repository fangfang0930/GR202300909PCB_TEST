transcript on
vmap altera_ver D:/cpldworks/7820H182_111020_1/7820H182_111020_1/sim/verilog_libs/altera_ver
vmap lpm_ver D:/cpldworks/7820H182_111020_1/7820H182_111020_1/sim/verilog_libs/lpm_ver
vmap sgate_ver D:/cpldworks/7820H182_111020_1/7820H182_111020_1/sim/verilog_libs/sgate_ver
vmap altera_mf_ver D:/cpldworks/7820H182_111020_1/7820H182_111020_1/sim/verilog_libs/altera_mf_ver
vmap altera_lnsim_ver D:/cpldworks/7820H182_111020_1/7820H182_111020_1/sim/verilog_libs/altera_lnsim_ver
vmap maxii_ver D:/cpldworks/7820H182_111020_1/7820H182_111020_1/sim/verilog_libs/maxii_ver
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/cpldworks/7820H182_111020_1/7820H182_111020_1 {D:/cpldworks/7820H182_111020_1/7820H182_111020_1/ad.v}
vlog -vlog01compat -work work +incdir+D:/cpldworks/7820H182_111020_1/7820H182_111020_1 {D:/cpldworks/7820H182_111020_1/7820H182_111020_1/rcvr.v}
vlog -vlog01compat -work work +incdir+D:/cpldworks/7820H182_111020_1/7820H182_111020_1 {D:/cpldworks/7820H182_111020_1/7820H182_111020_1/down_deal.v}
vlog -vlog01compat -work work +incdir+D:/cpldworks/7820H182_111020_1/7820H182_111020_1 {D:/cpldworks/7820H182_111020_1/7820H182_111020_1/PWM.v}
vlog -vlog01compat -work work +incdir+D:/cpldworks/7820H182_111020_1/7820H182_111020_1 {D:/cpldworks/7820H182_111020_1/7820H182_111020_1/pwm_down.v}
vlog -vlog01compat -work work +incdir+D:/cpldworks/7820H182_111020_1/7820H182_111020_1 {D:/cpldworks/7820H182_111020_1/7820H182_111020_1/UNIT_FINAL.v}
vlog -vlog01compat -work work +incdir+D:/cpldworks/7820H182_111020_1/7820H182_111020_1 {D:/cpldworks/7820H182_111020_1/7820H182_111020_1/pwm_up.v}
vlog -vlog01compat -work work +incdir+D:/cpldworks/7820H182_111020_1/7820H182_111020_1 {D:/cpldworks/7820H182_111020_1/7820H182_111020_1/sign_deal.v}
vlog -vlog01compat -work work +incdir+D:/cpldworks/7820H182_111020_1/7820H182_111020_1 {D:/cpldworks/7820H182_111020_1/7820H182_111020_1/up_sign.v}
vlog -vlog01compat -work work +incdir+D:/cpldworks/7820H182_111020_1/7820H182_111020_1 {D:/cpldworks/7820H182_111020_1/7820H182_111020_1/send.v}

vlog -vlog01compat -work work +incdir+D:/cpldworks/7820H182_111020_1/7820H182_111020_1 {D:/cpldworks/7820H182_111020_1/7820H182_111020_1/tb_pwm.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L maxii_ver -L rtl_work -L work -voptargs="+acc"  tb_pwm

add wave *
view structure
view signals
run 1 us
