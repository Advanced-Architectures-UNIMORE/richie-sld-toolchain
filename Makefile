# =====================================================================
#
# Copyright (C) 2021 University of Modena and Reggio Emilia
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# =====================================================================
#
# Project:     	Richie Toolchain
#
# Name: 				Makefile
#
# Description: 	Recipes are defined under tools/common_mk, so as to accomplish:
#
#									>> Set up of the tool environment;
#									>> Generation of the accelerator interfaces;
#									>> Specialization and generation of the Accelerator-Rich HeSoC.
#
# Date:        	23.11.2021
#
# Author: 			Gianluca Bellocchi <gianluca.bellocchi@unimore.it>
#
# =====================================================================

RICHIE_TOOLCHAIN_ROOT := $(patsubst %/,%, $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
REPO := richie-toolchain

TARGET_PLATFORM := richie_example

MODULES := common acc_verif check_code py_env richie_export
$(foreach leaf,$(MODULES),$(eval include $(RICHIE_TOOLCHAIN_ROOT)/scripts/$(leaf)/$(leaf).mk))
-include richie-toolchain/bash/generation.mk

.PHONY: all clean export

all: richie_gen

export: richie_export

init: richie_gen_init

clean: richie_gen_clean acc_gen_clean
