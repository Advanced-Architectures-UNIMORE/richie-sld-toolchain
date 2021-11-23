# =====================================================================
# Project:      Makefile
# Title:        ov_integr_git.mk
# Description: 	Recipes to guide Git deployment. Variables are fed by 
# 				the root Makefile.
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

# ---------------------------------- #
#  SYSTEM-LEVEL INTEGRATION (v-git)  #
# ---------------------------------- #
# # hwpe_git_remote_update:
# # 	@cd genacc/output/git-deploy/hwpe-gen-app && git push origin ov_${HWPE_TARGET}

# # hwpe_git_commit:
# # 	@cd genacc/output/git-deploy/hwpe-gen-app && git add .
# # 	@cd genacc/output/git-deploy/hwpe-gen-app && git commit -m "update on ${HWPE_TARGET}"

# # hwpe_git_branch:
# # 	@cd genacc/output/git-deploy/hwpe-gen-app && git checkout -b ov_${HWPE_TARGET}

# # init_hwpe_git:
# # 	@git clone git@iis-git.ee.ethz.ch:gianluca.bellocchi/hwpe-gen-app.git

# # git_deploy:
# # 	@bash ${SCRIPTS_GIT_DEPLOY}/git-deploy.sh ${PY_VENV} ${OUT_DIR}

hwpe_git_deploy: clean_git_deploy
	@bash ${SCRIPTS_GIT_DEPLOY}/set_filedir.sh ${OUT_DIR}

clean_git_deploy:
	@bash ${SCRIPTS_GIT_DEPLOY}/clean_git.sh ${OUT_DIR}