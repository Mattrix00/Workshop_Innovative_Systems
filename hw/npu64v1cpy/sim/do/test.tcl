file delete -force -- work

vlib work
vmap work

# compile src
set dir "../src"
# package
vcom -93 -work work ${dir}/pkg/globals.pkg.vhd

set f [open ${dir}/hier.txt r]
foreach src [split [read $f] "\n"] {
	if { $src ne "" } {
	    puts $src
	    vcom -93 -work work -novopt -source -rangecheck -check_synthesis +cover=ft ${dir}/${src}}
}

# testbench
set dir "./tb"
vlog -sv -work work ${dir}/pkg/globals.pkg.sv
vlog -sv -work work ${dir}/cfg.sv
vlog -sv -work work ${dir}/test.sv

# simulate
vsim -novopt work.test

# wave

add wave *
add wave sim:/fsm_inst/*
add wave sim:/dp_inst/*
add wave sim:/dp_inst/npu_inst/*

radix -h

# suppress metavalue detection @ first iteration
set NumericStdNoWarnings 1 

# run
run -all

