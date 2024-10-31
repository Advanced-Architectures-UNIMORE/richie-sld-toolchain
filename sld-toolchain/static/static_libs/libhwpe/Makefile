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

dirs = host pulp
dirs_pulp = pulp

build:
	@$(foreach dir,$(dirs), cd $(PWD)/$(dir) &&  make $@;)

header:
	@$(foreach dir,$(dirs_pulp), cd $(PWD)/$(dir) &&  make $@;)

all: header build

.PHONY: install clean
install:
	@$(foreach dir,$(dirs), cd $(PWD)/$(dir) &&  make $@;)

install_pulp:
	cd pulp && make install;

clean:
	@$(foreach dir,$(dirs), cd $(PWD)/$(dir) &&  make $@;)
