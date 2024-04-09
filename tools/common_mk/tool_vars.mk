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
# Name: 		Makefile variables
#
# Description: 	List of Makefile variables shared by other Makefiles.
#
# Date:        	23.11.2021
#
# Author: 			Gianluca Bellocchi <gianluca.bellocchi@unimore.it>
#
# =====================================================================

GEN_ROOT							:= ${ROOT}/richie-toolchain

# Sources

SRC_DIR 							:= ${ROOT}/src
SRC_ACC 							:= ${SRC_DIR}/accelerators
SRC_OV 								:= ${SRC_DIR}/overlays

# Scripts

SCRIPTS_DIR						:= ${ROOT}/tools/common_sh
SCRIPTS_ACC_GEN				:= ${SCRIPTS_DIR}/acc_gen
SCRIPTS_ACC_VERIF			:= ${SCRIPTS_DIR}/acc_verif
SCRIPTS_OV_GEN				:= ${SCRIPTS_DIR}/ov_gen
SCRIPTS_OV_DEPLOY			:= ${SCRIPTS_DIR}/ov_deploy
SCRIPTS_PY_ENV				:= ${SCRIPTS_DIR}/py_env

# Python virtual environment

PY_VENV 							:= richie-py-env
PY_VENV_DIR						:= ${ROOT}/${PY_VENV}

# Output content

OUT_DIR 							:= ${ROOT}/output
OUT_OV_GEN						:= ${OUT_DIR}/${TARGET_OV}
OUT_ACC_GEN						:= ${OUT_OV_GEN}/wrappers

# Device (extracted from source)

DEV_DIR 							:= ${GEN_ROOT}/dev
DEV_ACC_DIR 					:= ${DEV_DIR}/acc_dev
DEV_OV_DIR 						:= ${DEV_DIR}/ov_dev

# Templates

TEMPL 								:= ${GEN_ROOT}/templates

TEMPL_ACC							:= ${TEMPL}/accelerators
TEMPL_ACC_HW_DIR			:= ${TEMPL_ACC}/hw
TEMPL_ACC_SW_DIR			:= ${TEMPL_ACC}/sw
TEMPL_ACC_HW_MNGT_DIR	:= ${TEMPL_ACC}/integr_support

TEMPL_OV							:= ${TEMPL}/platforms
TEMPL_OV_HW_DIR				:= ${TEMPL_OV}/hw

# Static modules

STATIC 								:= ${GEN_ROOT}/static

# Verification

VERIF_ACC 						:= ${GEN_ROOT}/verif/hwpe-tb

# System-level integration

OVERLAY_CFG						:= ${RICHIE_HW_EXPORT}/ov_cfg
OVERLAY_DEPS					:= ${RICHIE_HW_EXPORT}/deps
OVERLAY_TEST					:= ${RICHIE_HW_EXPORT}/test
OVERLAY_ACCEL					:= ${RICHIE_HW_EXPORT}/accelerators
OVERLAY_CLUSTER				:= ${OVERLAY_DEPS}/overlay_cluster/rtl
