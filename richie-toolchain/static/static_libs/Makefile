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
# Author: 			Gianluca Bellocchi <gianluca.bellocchi@unimore.it>
#
# =====================================================================

ifndef PULP_SDK_HOME
$(error PULP_SDK_HOME is not set)
endif

dirs = $(wildcard libhwpe/*) libarov-target

.PHONY: hwpe_structs soc_structs clean all
all: hwpe_structs soc_structs
	@$(foreach dir,$(dirs), cd $(PWD)/$(dir) && make header build;)

install_pulp:
	@$(foreach dir,$(dirs), cd $(PWD)/$(dir) && make $@;)

install:
	@$(foreach dir,$(dirs), cd $(PWD)/$(dir) && make $@;)

build:
	@$(foreach dir,$(dirs), cd $(PWD)/$(dir) && make $@;)

header: hwpe_structs soc_structs
	@$(foreach dir,$(dirs), cd $(PWD)/$(dir) && make $@;)

soc_structs:
	mkdir -p $(PULP_SDK_HOME)/install/include/common_structs
	cp $@/*.h $(PULP_SDK_HOME)/install/include/common_structs

hwpe_structs:
	mkdir -p $(PULP_SDK_HOME)/install/include/common_structs
	cp $@/*.h $(PULP_SDK_HOME)/install/include/common_structs

clean:
	@$(foreach dir,$(dirs), cd $(PWD)/$(dir) && make $@;)
	@$(foreach dir,$(dirs), cd $(PWD)/$(dir) && find -type d -name "build" -exec rm -rf {} + ;)

clean_sdk:
	rm -rf ${PULP_SDK_HOME}/install/include/common_structs
	rm -rf ${PULP_SDK_HOME}/install/include/libhwpe
	rm -rf ${PULP_SDK_HOME}/install/include/libarov-target
	rm -rf ${PULP_SDK_HOME}/install/include/arov-target.h
