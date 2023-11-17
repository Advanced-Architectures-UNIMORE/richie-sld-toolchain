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
# Project:      GenOv
#
# Name: 		Accelerator library
#
# Description: 	Recipes to extract accelerator specification files and
#				the generation of the HW/SW accelerator interfaces.
# 				These aid the integration of acceleration kernels inside
#				the target accelerator-rich SoC.
#
# Date:        	24.11.2021
#
# Author: 		Gianluca Bellocchi <gianluca.bellocchi@unimore.it>
#
# =====================================================================

ROOT 				:= $(patsubst %/,%, $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))

.PHONY: all clean

all: lib_info
	@echo "[sh] >> Building runtime accelerator device environment"
	@cp -rf ${TARGET_ACC} ${ACC_DEV_DIR}/${TARGET_ACC}
lib_info:
	@echo -e "[sh] >> Runtime accelerator device environment:\n"
	@echo -e "\t- Location -> ${ACC_DEV_DIR}"
	@echo -e "\t- Target device -> ${TARGET_ACC}\n"
clean:
	@echo "[sh] >> Cleaning runtime accelerator device environment"
	@rm -rf ${ACC_DEV_DIR}/${TARGET_ACC}

