# =====================================================================
# Project:      Makefile
# Title:        Makefile
# Description: 	Root Makefile. 
#
#				It reads recipes from sub-mk files to:
#
#					>> Set up the tool environment;
#					>> Generate accelerator HW/SW components;
#					>> Guide system-level integration.
#
# $Date:        23.11.2021
#
# =====================================================================
#
# Copyright (C) 2021 University of Modena and Reggio Emilia.
#
# Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.
#
# =====================================================================

ROOT 					:= $(patsubst %/,%, $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
REPO 					:= genacc

# Choose target on those available in the application library (e.g. mmul_parallel)

HWPE_TARGET				:= conv_mdc

-include tools/common_mk/*.mk

.PHONY: all clean

all: acc_gen ov_gen

init: py_env

clean: py_env_clean acc_gen_clean acc_deploy_clean ov_gen_clean