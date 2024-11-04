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
# Name: 				Common shell components
#
# Description: 	Recipes to invoke shell functions or scripts.
#
# Date:        	23.11.2021
#
# Author: 			Gianluca Bellocchi <gianluca.bellocchi@unimore.it>
#
# =====================================================================

# Source design knobs
SRC_DIR 											:= ${RICHIE_TOOLCHAIN_ROOT}/src
SRC_ACC 											:= ${SRC_DIR}/accelerators
SRC_PLAT 											:= ${SRC_DIR}/platforms

# Generation flow
RICHIE_GEN_DIR								:= ${RICHIE_TOOLCHAIN_ROOT}/sld-toolchain
SCRIPTS_ACC_GEN								:= ${RICHIE_GEN_DIR}/bash/acc_gen
SCRIPTS_RICHIE_GEN						:= ${RICHIE_GEN_DIR}/bash/richie_gen

# Scripts
SCRIPTS_DIR										:= ${RICHIE_TOOLCHAIN_ROOT}/scripts
SCRIPTS_ACC_VERIF							:= ${SCRIPTS_DIR}/acc_verif
SCRIPTS_CHECK_CODE						:= ${SCRIPTS_DIR}/check_code
SCRIPTS_PY_ENV								:= ${SCRIPTS_DIR}/py_env
SCRIPTS_RICHIE_EXPORT					:= ${SCRIPTS_DIR}/richie_export

# Tools
TOOLS_DIR											:= ${RICHIE_TOOLCHAIN_ROOT}/tools

# Python virtual environment
PY_VENV_NAME 									:= richie-py-env
PY_VENV_DIR										:= ${RICHIE_TOOLCHAIN_ROOT}/${PY_VENV_NAME}

# Output content
OUT_DIR 											:= ${RICHIE_TOOLCHAIN_ROOT}/output
OUT_RICHIE_GEN								:= ${OUT_DIR}/${TARGET_PLATFORM}
OUT_ACC_GEN										:= ${OUT_RICHIE_GEN}/accelerators

# Device (extracted from source)
DEV_DIR 											:= ${RICHIE_GEN_DIR}/dev
DEV_ACC_DIR 									:= ${DEV_DIR}/accelerator_dev
DEV_OV_DIR 										:= ${DEV_DIR}/platform_dev

# Templates
TEMPL 												:= ${RICHIE_GEN_DIR}/templates
TEMPL_ACC											:= ${TEMPL}/accelerators
TEMPL_RICHIE									:= ${TEMPL}/platforms

# Static modules
STATIC 												:= ${RICHIE_GEN_DIR}/static

# Verification
TARGET_ACC_VERIF							:= traffic_gen
VERIF_ACC_DIR 								:= ${RICHIE_TOOLCHAIN_ROOT}/verif/hwpe-tb

# System-level integration
RICHIE_HW_SRC									:= ${RICHIE_HW}/src
RICHIE_HW_DEPS								:= ${RICHIE_HW}/deps
RICHIE_HW_TEST								:= ${RICHIE_HW}/vsim
RICHIE_HW_ACCEL								:= ${RICHIE_HW}/accelerators/src

common_sh:
	@bash ${SCRIPTS_DIR}/common/common.sh ${HWPE_TARGET}

check_richie_env:
ifndef RICHIE_HW
	$(error RICHIE_HW is undefined)
endif
