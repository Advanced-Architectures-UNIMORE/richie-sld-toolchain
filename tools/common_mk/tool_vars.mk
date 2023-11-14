# =====================================================================
# Project:      Makefile
# Title:        tool_vars.mk
# Description: 	Makefile variables shared by all recipes.
#
# $Date:        23.11.2021
#
# =====================================================================
#
# Copyright (C) 2021 University of Modena and Reggio Emilia.
#
# Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.
#
# =====================================================================

GEN_ROOT					:= ${ROOT}/genov

# Sources

SRC_DIR 					:= ${ROOT}/src
SRC_ACC 					:= ${SRC_DIR}/accelerators
SRC_OV 						:= ${SRC_DIR}/overlays

# Tools

TOOLS_DIR					:= ${ROOT}/tools

# Scripts

SCRIPTS_DIR					:= ${TOOLS_DIR}/common_sh
SCRIPTS_ACC_GEN				:= ${SCRIPTS_DIR}/acc_gen
SCRIPTS_ACC_VERIF			:= ${SCRIPTS_DIR}/acc_verif
SCRIPTS_OV_GEN				:= ${SCRIPTS_DIR}/ov_gen
SCRIPTS_OV_DEPLOY			:= ${SCRIPTS_DIR}/ov_deploy
SCRIPTS_PY_ENV				:= ${SCRIPTS_DIR}/py_env

# Python virtual environment

PY_VENV 					:= local_py_env
PY_VENV_DIR					:= ${ROOT}/${PY_VENV}

# Output content

OUT_DIR 					:= ${ROOT}/output
OUT_OV_GEN					:= ${OUT_DIR}/${TARGET_OV}
OUT_ACC_GEN					:= ${OUT_OV_GEN}/wrappers

OUT_ACC_GEN_DEPLOY			:= ${OUT_ACC_GEN}/acc_deploy # to be removed

# Device (extracted from source)

DEV_DIR 					:= ${GEN_ROOT}/dev
DEV_ACC_DIR 				:= ${DEV_DIR}/acc_dev
DEV_OV_DIR 					:= ${DEV_DIR}/ov_dev

# Templates

TEMPL 						:= ${GEN_ROOT}/templates

TEMPL_ACC					:= ${TEMPL}/acc_templ
TEMPL_ACC_HW_DIR			:= ${TEMPL_ACC}/hw
TEMPL_ACC_SW_DIR			:= ${TEMPL_ACC}/sw
TEMPL_ACC_HW_MNGT_DIR		:= ${TEMPL_ACC}/integr_support

TEMPL_OV					:= ${TEMPL}/ov_templ
TEMPL_OV_HW_DIR				:= ${TEMPL_OV}/hw

# Static modules

STATIC 						:= ${GEN_ROOT}/static

# Verification

VERIF 						:= ${GEN_ROOT}/verif
VERIF_ACC 					:= ${VERIF}/hwpe-tb

# System-level integration

OVERLAY_HW_REPO				:= ${HERO_OV_HW_EXPORT}
OVERLAY_CFG					:= ${HERO_OV_HW_EXPORT}/ov_cfg
OVERLAY_DEPS				:= ${HERO_OV_HW_EXPORT}/deps
OVERLAY_TEST				:= ${HERO_OV_HW_EXPORT}/test
OVERLAY_CLUSTER				:= ${OVERLAY_DEPS}/overlay_cluster/rtl