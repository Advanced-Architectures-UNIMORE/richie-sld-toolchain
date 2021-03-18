########################################################
## Gianluca Bellocchi <gianluca.bellocchi@unimore.it> ##
########################################################

#!/usr/bin/env python3

# Packages
import numpy as np
import sys
import struct
import shutil
import getpass
import os

# Design specification package
from engine_dev.specs.hwpe_specs import hwpe_specs

# HW packages
from templates.hw.hwpe_wrapper import hwpe_wrapper

# HW-management packages
from templates.hw_management.hw_management import hw_management

# SW packages
from templates.sw.sw import firmware_baremetal
from templates.sw.sw import firmware_offloading

# Generator class
class hwpe_gen:
    def __init__(self, specs):
        self.specs = specs
    
    def gen_dev(self, dev, filename, dest_dir):
        n = filename
        with open(n, "w") as f:
            f.write(dev)
            try:
                source = n
                destination = dest_dir
                shutil.move(source, destination)
            except:
                val = getpass.getpass("There already exist old HWPE versions. Would you like to clean your environment? (y/n) ")
                while((val != "y") and (val != "n")):
                    val = input("There already exist old HWPE versions. Would you like to clean your environment? (y/n) ")
                if (val=="y"):
                    os.system('make clean >/dev/null 2>&1')
                    source = n
                    destination = dest_dir
                    shutil.move(source, destination)


# -------------------------------------- #
# -------------  HARDWARE  ------------- #
# -------------------------------------- #

# Read hwpe specs
specs = hwpe_specs()

# Create hwpe wrapper
hwpe_wrapper = hwpe_wrapper(specs)

# Create device generator
gen = hwpe_gen(specs)

# Static components (hw, sw, ..)
static_comps = 'static'

# Create output environment
hwpe_pulp_integration = specs.dest_dir + '/hw/pulp_integration'
hwpe_outdir = specs.dest_dir + '/hw/hwpe-' + specs.hwpe_target + '-wrapper'
hwpe_rtl = hwpe_outdir + '/rtl'
hwpe_engine_rtl = hwpe_rtl + '/hwpe-engine'
hwpe_streamer_rtl = hwpe_rtl + '/hwpe-stream'
hwpe_ctrl_rtl = hwpe_rtl + '/hwpe-ctrl'

os.mkdir(hwpe_pulp_integration)
os.mkdir(hwpe_outdir)
os.mkdir(hwpe_rtl)
os.mkdir(hwpe_rtl + '/wrap')
os.mkdir(hwpe_engine_rtl)

# Copy static components
source = static_comps + '/static_rtl/hwpe-stream/rtl'
destination = hwpe_streamer_rtl
shutil.copytree(source, destination)

source = static_comps + '/static_rtl/hwpe-ctrl-fpga/rtl'
destination = hwpe_ctrl_rtl
shutil.copytree(source, destination)

# Create repo for datapth
dirname = hwpe_engine_rtl + '/engine_dev'
source = 'engine_dev/rtl'
destination = dirname
shutil.copytree(source, destination)

# Generate hwpe package for pulp system
dev = hwpe_wrapper.pulp_hwpe_pkg(specs)
filename = 'pulp_cluster_hwpe_pkg.sv'
dest_dir = hwpe_pulp_integration
gen.gen_dev(dev, filename, dest_dir)

# Generate pulp hwpe wrapper
dev = hwpe_wrapper.pulp_hwpe_wrap(specs)
filename = 'pulp_hwpe_wrap.sv'
dest_dir = hwpe_pulp_integration
gen.gen_dev(dev, filename, dest_dir)

# Generate hwpe top wrapper
dev = hwpe_wrapper.top_wrapper(specs)
filename = specs.hwpe_target + '_' + 'top_wrapper.sv'
dest_dir = hwpe_rtl + '/wrap'
gen.gen_dev(dev, filename, dest_dir)

# Generate hwpe top
dev = hwpe_wrapper.top(specs)
filename = specs.hwpe_target + '_' + 'top.sv'
dest_dir = hwpe_engine_rtl
gen.gen_dev(dev, filename, dest_dir)

# Generate hwpe engine wrapper
dev = hwpe_wrapper.engine(specs)
filename = specs.hwpe_target + '_' + 'engine.sv'
dest_dir = hwpe_engine_rtl
gen.gen_dev(dev, filename, dest_dir)

# Generate hwpe streamer wrapper
dev = hwpe_wrapper.streamer(specs)
filename = specs.hwpe_target + '_' + 'streamer.sv'
dest_dir = hwpe_engine_rtl
gen.gen_dev(dev, filename, dest_dir)

# Generate hwpe ctrl wrapper
dev = hwpe_wrapper.ctrl(specs)
filename = specs.hwpe_target + '_' + 'ctrl.sv'
dest_dir = hwpe_engine_rtl
gen.gen_dev(dev, filename, dest_dir)

# # Generate hwpe fsm
dev = hwpe_wrapper.fsm(specs)
filename = specs.hwpe_target + '_' + 'fsm.sv'
dest_dir = hwpe_engine_rtl
gen.gen_dev(dev, filename, dest_dir)

# Generate hwpe package
dev = hwpe_wrapper.package(specs)
filename = specs.hwpe_target + '_' + 'package.sv'
dest_dir = hwpe_engine_rtl
gen.gen_dev(dev, filename, dest_dir)

# ------------------------------------------------ #
# -------------  HARDWARE MANAGEMENT ------------- #
# ------------------------------------------------ #

# Create hw management tool
hw_management = hw_management(specs)

# Generate bender
dev = hw_management.bender(specs)
filename = 'Bender.yml'
dest_dir = hwpe_outdir
gen.gen_dev(dev, filename, dest_dir)

# Generate VSIM wave file
dev = hw_management.vsim_wave(specs)
filename = 'pulp_tb.wave.do'
dest_dir = hwpe_pulp_integration
gen.gen_dev(dev, filename, dest_dir)

# -------------------------------------------------- #
# -------------  FIRMWARE (BAREMETAL)  ------------- #
# -------------------------------------------------- #

# Create RISC-V firmware (baremetal)
sw_riscv = firmware_baremetal(specs)

# Create output environment
sw_outdir = specs.dest_dir + '/sw/hwpe-' + specs.hwpe_target + '-riscv'
sw_inc = sw_outdir + '/inc'
sw_hero_lib = sw_inc + '/hero_lib'
sw_test_lib = sw_inc + '/test_lib'
sw_common = sw_inc + '/common'
sw_hwpe_lib = sw_inc + '/hwpe_lib'
sw_stim = sw_inc + '/stim'
sw_tb = sw_inc + '/sw_tb'

os.mkdir(sw_outdir)
os.mkdir(sw_inc)
os.mkdir(sw_hwpe_lib)

# Copy static components
source = static_comps + '/static_baremetal/Makefile'
destination = sw_outdir
shutil.copy(source, destination)

source = static_comps + '/static_baremetal/inc/hero_lib/'
destination = sw_hero_lib
shutil.copytree(source, destination)

source = static_comps + '/static_baremetal/inc/test_lib/'
destination = sw_test_lib
shutil.copytree(source, destination)

source = static_comps + '/static_baremetal/inc/common/'
destination = sw_common
shutil.copytree(source, destination)

# Create repo for stimuli
dirname = sw_stim
source = 'engine_dev/sw/baremetal_test/stim'
destination = dirname
shutil.copytree(source, destination)

# Create repo for sw-testbench
dirname = sw_tb
source = 'engine_dev/sw/baremetal_test/sw_tb'
destination = dirname
shutil.copytree(source, destination)

# Generate archi-hwpe 
# Memory-mapped hardware accelerator registers
dev = sw_riscv.archi_hwpe(specs)
filename = 'archi_hwpe.h'
dest_dir = sw_hwpe_lib
gen.gen_dev(dev, filename, dest_dir)

# Generate hal-hwpe 
# Hardware Abstraction Layer with functions that permit 
# to create an inetaction between the RISC-V processor
# and the hardware accelerator
dev = sw_riscv.hal_hwpe(specs)
filename = 'hal_hwpe.h'
dest_dir = sw_hwpe_lib
gen.gen_dev(dev, filename, dest_dir)

# Generate test-hwpe 
# Software testbench of the hwpe functionality that can be
# run in baremetal on the rv-fc commprised in the pulp system.
# This tb can be used as a starting point for additional platform testing.
dev = sw_riscv.test_hwpe(specs)
filename = 'test_hwpe.c'
dest_dir = sw_outdir
gen.gen_dev(dev, filename, dest_dir)

# --------------------------------------------------- #
# -------------  FIRMWARE (OFFLOADING)  ------------- #
# --------------------------------------------------- #

# # Create HOST firmware (OpenMP offloading)
# sw_host  = firmware_offloading(specs)
