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
# Name: 		Generation of the Accelerator-Rich HeSoC
#
# Description: 	Recipes to specialize and optimize Accelerator-Rich HeSoC.
#
# Date:        	23.11.2021
#
# Author: 			Gianluca Bellocchi <gianluca.bellocchi@unimore.it>
#
# =====================================================================

ov_gen:
	@bash ${SCRIPTS_OV_GEN}/$@.sh \
		${ROOT} \
		${DEV_DIR} \
		${PY_VENV_DIR} \
		${SRC_OV} \
		${OUT_OV_GEN}
ov_gen_run:
	@bash ${SCRIPTS_OV_GEN}/$@.sh \
		${TARGET_OV} \
		${PY_VENV} \
		${OUT_OV_GEN}

ov_gen_fetch_specs:
	@bash ${SCRIPTS_OV_GEN}/$@.sh \
		${SRC_OV} \
		${DEV_DIR} \
		${TARGET_OV}

ov_gen_out_env:
	@bash ${SCRIPTS_OV_GEN}/$@.sh \
		${TARGET_OV} \
		${DEV_DIR} \
		${OUT_OV_GEN} \
		${STATIC}

ov_gen_out_static:
	@bash ${SCRIPTS_OV_GEN}/$@.sh \
		${TARGET_OV} \
		${DEV_DIR} \
		${OUT_OV_GEN} \
		${STATIC}

ov_gen_init:
	@bash ${SCRIPTS_OV_GEN}/$@.sh \
		${PY_VENV}

ov_gen_clean: check_ov_env
	@bash ${SCRIPTS_OV_GEN}/$@.sh \
		${DEV_DIR}/ov_dev \
		${PY_VENV_DIR} \
		${OUT_OV_GEN}
