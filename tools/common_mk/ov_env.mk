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
# Project:      Richie Toolchain
#
# Name: 		Environment testing
#
# Description: 	Recipes to test the environment.
#
# Date:        	23.11.2021
#
# Author: 			Gianluca Bellocchi <gianluca.bellocchi@unimore.it>
#
# =====================================================================

test_ov_env: check_ov_env
ifndef ENV_IS_CHECKED
	@bash ${SCRIPTS_OV_DEPLOY}/secure_paths.sh ${OVERLAY_SRC} ${OVERLAY_DEPS} ${OVERLAY_TEST}
endif

check_ov_env:
ifndef RICHIE_HW_EXPORT
	$(error RICHIE_HW_EXPORT is undefined)
endif
