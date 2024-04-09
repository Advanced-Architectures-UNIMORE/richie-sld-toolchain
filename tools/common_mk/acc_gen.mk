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
# Name: 		Accelerator generation
#
# Description: 	Recipes to guide the generation of the accelerator interface.
#
# Date:        	23.11.2021
#
# Author: 			Gianluca Bellocchi <gianluca.bellocchi@unimore.it>
#
# =====================================================================

acc_gen:
	@bash ${SCRIPTS_ACC_GEN}/$@.sh \
		${ROOT} \
		${DEV_DIR} \
		${PY_VENV_DIR} \
		${SRC_ACC} \
		${OUT_ACC_GEN} \
		${OVERLAY_ACCEL}

acc_gen_run:
	@bash ${SCRIPTS_ACC_GEN}/$@.sh \
		${TARGET_ACC} \
		${PY_VENV} \
		${OUT_ACC_GEN}

acc_gen_out_env:
	@bash ${SCRIPTS_ACC_GEN}/$@.sh \
		${TARGET_ACC} \
		${DEV_DIR}/acc_dev \
		${OUT_ACC_GEN} \
		${STATIC}

acc_gen_init:
	@bash ${SCRIPTS_ACC_GEN}/$@.sh \
		${PY_VENV}

acc_gen_kernel_list:
	@bash ${SCRIPTS_ACC_GEN}/$@.sh \
		${DEV_DIR}/acc_dev \
		${TARGET_ACC}


acc_gen_clean: check_ov_env
	@bash ${SCRIPTS_ACC_GEN}/$@.sh \
		${DEV_DIR}/acc_dev \
		${PY_VENV_DIR} \
		${TEMPL_ACC} \
		${OUT_ACC_GEN}
