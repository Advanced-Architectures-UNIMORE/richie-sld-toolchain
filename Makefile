# =====================================================================
# Project:      Makefile
# Title:        Makefile
# Description: 	Root Makefile. 
#
#				Recipes are read from sub-mk-files to:
#
#					>> Set up the tool environment;
#					>> Generate accelerator HW/SW components;
#					>> Generate overlay HW/SW components;
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

ROOT 			:= $(patsubst %/,%, $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
REPO 			:= genov

# =====================================================================
# Description:  Choose a target overlay configuration to be generated.
#
# Source: 		Specification files are kept under genov/src/overlays.
#
# Extensions	To add new versions, create a new configuration, insert
#				among the sources and target it using this Makefile. 
#				Configuration examples have been included to guide the 
#				user through this.
# =====================================================================

TARGET_OV		:= agile_1cl_16tg

# =====================================================================
# Description:  Basic recipes and inclusion of sub-mk-files.
# =====================================================================

-include tools/common_mk/*.mk

.PHONY: all clean

all: ov_gen

init: ov_gen_init

clean: ov_gen_clean acc_gen_clean