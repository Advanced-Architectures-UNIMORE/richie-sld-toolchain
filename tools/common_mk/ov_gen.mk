# =====================================================================
# Project:      Makefile
# Title:        ov_gen.mk
# Description: 	Recipes to guide generation of  accelerator-rich 
#				overlay. Variables are fed by the root Makefile.
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