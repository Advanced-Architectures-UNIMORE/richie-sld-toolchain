# =====================================================================
#
# Copyright (C) 2021 ETH Zurich, University of Modena and Reggio Emilia
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
# Project:      Richie Toolchain
#
# Name: 		Platform library
#
# Description: 	Recipes to extract platform specification files to
#				specialize and optimize the target Accelerator-Rich HeSoC.
#
# Date:        	24.11.2021
#
# Author: 		Gianluca Bellocchi <gianluca.bellocchi@unimore.it>
#
# =====================================================================

ROOT 				:= $(patsubst %/,%, $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))

.PHONY: all clean
all: lib_info
	@echo "[sh] >> Building runtime overlay device environment"
	@cp -rf ${TARGET_OV} ${DEV_DIR}/ov_dev
lib_info:
	@echo -e "[sh] >> Runtime overlay device environment:\n"
	@echo -e "\t- Location -> ${DEV_DIR}/ov_dev\n"
clean:
	@echo "[sh] >> Cleaning runtime overlay device environment"
	@rm -rf ${DEV_DIR}/ov_dev

