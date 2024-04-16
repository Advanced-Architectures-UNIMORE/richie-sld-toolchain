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
# Name: 				Generation of the Accelerator-Rich HeSoC
#
# Description: 	Recipes to specialize and optimize Accelerator-Rich HeSoC.
#
# Date:        	23.11.2021
#
# Author: 			Gianluca Bellocchi <gianluca.bellocchi@unimore.it>
#
# =====================================================================

richie_gen:
	@bash ${SCRIPTS_RICHIE_GEN}/$@.sh \
		${RICHIE_TOOLCHAIN_ROOT} \
		${DEV_DIR} \
		${PY_VENV_DIR} \
		${SRC_PLAT} \
		${OUT_RICHIE_GEN}

richie_gen_run:
	@bash ${SCRIPTS_RICHIE_GEN}/$@.sh \
		${PY_VENV} \
		${OUT_RICHIE_GEN}

richie_gen_platform_design_knobs:
	@bash ${SCRIPTS_RICHIE_GEN}/$@.sh \
		${SRC_PLAT} \
		${DEV_DIR} \
		${TARGET_PLATFORM}

richie_gen_out_env:
	@bash ${SCRIPTS_RICHIE_GEN}/$@.sh \
		${TARGET_PLATFORM} \
		${DEV_DIR} \
		${OUT_RICHIE_GEN} \
		${STATIC}

richie_gen_out_static:
	@bash ${SCRIPTS_RICHIE_GEN}/$@.sh \
		${DEV_DIR} \
		${OUT_RICHIE_GEN} \
		${STATIC}

richie_gen_init:
	@bash ${SCRIPTS_RICHIE_GEN}/$@.sh \
		${PY_VENV}

richie_gen_clean: check_richie_env
	@bash ${SCRIPTS_RICHIE_GEN}/$@.sh \
		${DEV_DIR}/platform_dev \
		${PY_VENV_DIR} \
		${OUT_RICHIE_GEN}
