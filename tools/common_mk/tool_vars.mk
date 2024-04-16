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
# Name: 				Makefile variables
#
# Description: 	List of Makefile variables shared by other Makefiles.
#
# Date:        	23.11.2021
#
# Author: 			Gianluca Bellocchi <gianluca.bellocchi@unimore.it>
#
# =====================================================================

# Sources

SRC_DIR 								:= ${RICHIE_TOOLCHAIN_ROOT}/src
SRC_ACC 								:= ${SRC_DIR}/accelerators
SRC_PLAT 								:= ${SRC_DIR}/platforms

# Scripts

SCRIPTS_DIR							:= ${RICHIE_TOOLCHAIN_ROOT}/tools/common_sh
SCRIPTS_ACC_GEN					:= ${SCRIPTS_DIR}/acc_gen
SCRIPTS_ACC_VERIF				:= ${SCRIPTS_DIR}/acc_verif
SCRIPTS_RICHIE_GEN			:= ${SCRIPTS_DIR}/richie_gen
SCRIPTS_RICHIE_EXPORT		:= ${SCRIPTS_DIR}/richie_export
SCRIPTS_PY_ENV					:= ${SCRIPTS_DIR}/py_env

# Python virtual environment

PY_VENV 								:= richie-py-env
PY_VENV_DIR							:= ${RICHIE_TOOLCHAIN_ROOT}/${PY_VENV}

# Output content

OUT_DIR 								:= ${RICHIE_TOOLCHAIN_ROOT}/output
OUT_RICHIE_GEN					:= ${OUT_DIR}/${TARGET_PLATFORM}
OUT_ACC_GEN							:= ${OUT_RICHIE_GEN}/wrappers

# Device (extracted from source)

DEV_DIR 								:= ${RICHIE_TOOLCHAIN_ROOT}/richie-toolchain/dev
DEV_ACC_DIR 						:= ${DEV_DIR}/accelerator_dev
DEV_OV_DIR 							:= ${DEV_DIR}/platform_dev

# Templates

TEMPL 									:= ${RICHIE_TOOLCHAIN_ROOT}/richie-toolchain/templates

TEMPL_ACC								:= ${TEMPL}/accelerators
TEMPL_ACC_HW_DIR				:= ${TEMPL_ACC}/hw
TEMPL_ACC_SW_DIR				:= ${TEMPL_ACC}/sw
TEMPL_ACC_HW_MNGT_DIR		:= ${TEMPL_ACC}/integr_support

TEMPL_OV								:= ${TEMPL}/platforms
TEMPL_OV_HW_DIR					:= ${TEMPL_OV}/hw

# Static modules

STATIC 									:= ${RICHIE_TOOLCHAIN_ROOT}/richie-toolchain/static

# Verification

VERIF_ACC 							:= ${RICHIE_TOOLCHAIN_ROOT}/richie-toolchain/verif/hwpe-tb

# System-level integration

RICHIE_HW_SRC						:= ${RICHIE_HW}/src
RICHIE_HW_DEPS					:= ${RICHIE_HW}/deps
RICHIE_HW_TEST					:= ${RICHIE_HW}/vsim
RICHIE_HW_ACCEL					:= ${RICHIE_HW}/accelerators
