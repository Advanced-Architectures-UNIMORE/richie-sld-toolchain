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
# Name: 				Platform library
#
# Description: 	Recipes to extract platform specification files to
#								specialize and optimize the target Accelerator-Rich HeSoC.
#
# Date:        	24.11.2021
#
# Author: 			Gianluca Bellocchi <gianluca.bellocchi@unimore.it>
#
# =====================================================================

.PHONY: all clean
all: lib_info
	@echo "[sh] >> Building runtime platforms device environment"
	@cp -rf ${TARGET_PLATFORM} ${DEV_DIR}/platform_dev

lib_info:
	@echo -e "[sh] >> Runtime platform device environment:\n"
	@echo -e "\t- Location -> ${DEV_DIR}/platform_dev\n"

clean:
	@echo "[sh] >> Cleaning runtime platforms device environment"
	@rm -rf ${DEV_DIR}/platform_dev

