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
# Name: 				Platform export to Richie HW subsytem
#
# Description: 	Recipes to guide the export of the generated Accelerator-Rich HeSoC.
#
# Date:        	23.11.2021
#
# Author: 			Gianluca Bellocchi <gianluca.bellocchi@unimore.it>
#
# =====================================================================

richie_export: richie_export_cfg

richie_export_cfg:
	@bash ${SCRIPTS_RICHIE_EXPORT}/$@.sh ${OUT_RICHIE_GEN} ${RICHIE_HW_SRC} ${TARGET_PLATFORM}

richie_export_test: common_sh
	@bash ${SCRIPTS_RICHIE_EXPORT}/$@.sh ${RICHIE_HW_SRC} ${RICHIE_HW_DEPS} ${RICHIE_HW_TEST}
