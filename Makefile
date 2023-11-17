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
# Project:     	GenOv
#
# Name: 		Makefile
#
# Description: 	Recipes are defined under tools/common_mk, so as to accomplish:
#
#					>> Set up of the tool environment;
#					>> Generation of the accelerator interfaces;
#					>> Specialization and generation of the accelerator-rich SoC.
#
# Date:        	23.11.2021
#
# Author: 		Gianluca Bellocchi <gianluca.bellocchi@unimore.it>
#
# =====================================================================

ROOT := $(patsubst %/,%, $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
REPO := genov

TARGET_OV := agile_1cl_16tg

-include tools/common_mk/*.mk

.PHONY: all clean

all: ov_gen

init: ov_gen_init

clean: ov_gen_clean acc_gen_clean
