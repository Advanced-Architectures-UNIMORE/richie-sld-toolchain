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
# Description: 	Recipes to set up Python Venv.
#
# Date:        	23.11.2021
#
# Author: 			Gianluca Bellocchi <gianluca.bellocchi@unimore.it>
#
# =====================================================================

py_env: py_env_init

py_env_update_reqs: common_sh
	@bash ${SCRIPTS_PY_ENV}/$@.sh ${PY_VENV_DIR}

py_env_init: common_sh
	@bash ${SCRIPTS_PY_ENV}/$@.sh ${PY_VENV}

py_env_test: common_sh
	@bash ${SCRIPTS_PY_ENV}/$@.sh ${PY_VENV_DIR}

py_env_clean: py_env_test
	@rm -rf ${PY_VENV}
