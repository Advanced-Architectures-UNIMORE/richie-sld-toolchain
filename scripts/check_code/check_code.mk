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
# Name: 				Environment setup
#
# Description: 	Recipes to run code check scripts.
#
# Date:        	23.11.2021
#
# Author: 			Gianluca Bellocchi <gianluca.bellocchi@unimore.it>
#
# =====================================================================

check_python: common_sh
	@bash ${SCRIPTS_CHECK_CODE}/$@.sh \
		${RICHIE_TOOLCHAIN_ROOT} \
		${PY_VENV_DIR} \
		${SRC_PLAT}

check_systemverilog:
	@bash ${SCRIPTS_CHECK_CODE}/$@.sh \
		${RICHIE_TOOLCHAIN_ROOT} \
		${TOOLS_DIR} \
		${OUT_RICHIE_GEN}

check_shell: common_sh
	@bash ${SCRIPTS_CHECK_CODE}/$@.sh \
		${RICHIE_TOOLCHAIN_ROOT} \
		${TOOLS_DIR}
