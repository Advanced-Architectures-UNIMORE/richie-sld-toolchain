## Author: Gianluca Bellocchi
## Email: gianluca.bellocchi@unimore.it

ROOT 					:= $(patsubst %/,%, $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))

# Accelerator library
HWPE_TARGET				:= MMUL_BASELINE

# Templates
TEMPLATES 				:= ./templates
HW_DIR					:= ${TEMPLATES}/hw
HW_MNGT_DIR				:= ${TEMPLATES}/hw_management
SW_DIR					:= ${TEMPLATES}/sw

# Engine
ENG_DEV 				:= ./engine_dev/
ENG_DEV_RTL 			:= ${ENG_DEV}/rtl

# Static modules
STATIC 					:= ./static

STATIC_RTL_DIR 			:= ${STATIC}/static_rtl
STATIC_STREAM			:= ${STATIC_RTL_DIR}/hwpe-stream/rtl
STATIC_CTRL 			:= ${STATIC_RTL_DIR}/hwpe-ctrl-fpga/rtl

# Output content
OUT_DIR 				:= ./output
OUT_HW_DIR 				:= ${OUT_DIR}/hw
OUT_PULP_INTEGR			:= ${OUT_HW_DIR}/pulp_integration
OUT_SW_DIR 				:= ${OUT_DIR}/sw

# Exporting
PULP_SRC				:= ${ROOT}/../src
HW_TEST					:= ${ROOT}/../test
HW_DEPS					:= ${ROOT}/../deps
HWPE_REPO				:= hwpe-repo
PULP_CLUSTER			:= ${HW_DEPS}/pulp_cluster/rtl

RM_F 					:= @rm -f
RM_DF 					:= @rm -rf

.PHONY: all export gen engine_dev static_rtl acc_lib clean
all: pulp-integr

repo-hw:
	@echo "Exporting hardware wrapper and Bender to HWPE repo."
	@cp -rf ${OUT_HW_DIR}/hwpe-${HWPE_TARGET}-wrapper ${HW_DEPS}/${HWPE_REPO}/

repo-sw:
	@echo "Exporting software runtime calls to HWPE repo."
	@cp -rf ${OUT_SW_DIR} ${HW_DEPS}/hwpe-${HWPE_TARGET}-wrapper/

overlay_deps: pulp-integr
	@echo "Exporting 'hwpe-${HWPE_TARGET}-wrapper' to the Overlay ecosystem."
	@cp -rf ${OUT_HW_DIR}/hwpe-${HWPE_TARGET}-wrapper ${HW_DEPS}/hwpe-${HWPE_TARGET}-wrapper
	@cp -rf ${OUT_SW_DIR} ${HW_DEPS}/hwpe-${HWPE_TARGET}-wrapper/

pulp-integr: gen
	@echo "Exporting HWPE package for PULP cluster."
	@cp ${OUT_PULP_INTEGR}/pulp_cluster_hwpe_pkg.sv ${PULP_SRC}/
	@echo "Exporting PULP HWPE wrapper."
	@cp ${OUT_PULP_INTEGR}/pulp_hwpe_wrap.sv ${PULP_CLUSTER}/
	@echo "Exporting Modelsim wave script."
	@cp ${OUT_PULP_INTEGR}/pulp_tb.wave.do ${HW_TEST}/

gen: engine_dev static_rtl 
	@echo "HWPE wrapper generation."
	@python3 gen.py

engine_dev: acc_lib
	@ls ${ENG_DEV_RTL} >> ${HW_MNGT_DIR}/rtl_list/engine_list.log

static_rtl:
	@ls -R ${STATIC_STREAM} | grep '\.sv' >> ${HW_MNGT_DIR}/rtl_list/stream_list.log
	@ls -R ${STATIC_CTRL} | grep '\.sv' >> ${HW_MNGT_DIR}/rtl_list/ctrl_list.log 

acc_lib:
	@cd acc_lib && make -s clean all TARGET=${HWPE_TARGET}

clean:
	@${RM_DF} ${ENG_DEV}/*
	@${RM_DF} ${OUT_HW_DIR}/*
	@${RM_DF} ${OUT_SW_DIR}/*
	@${RM_DF} ${HW_DEPS}/hwpe-${HWPE_TARGET}-wrapper
	@${RM_F}  ${OUT_HW_MNGT_DIR}/*.yml
	@${RM_F}  ${HW_MNGT_DIR}/rtl_list/*.log
	@${RM_F}  ${PULP_SRC}/pulp_cluster_hwpe_pkg.sv
	@${RM_F}  ${PULP_CLUSTER}/pulp_hwpe_wrap.sv
	@find . -type d -name '__pycache__' -exec rm -rf {} +
	
