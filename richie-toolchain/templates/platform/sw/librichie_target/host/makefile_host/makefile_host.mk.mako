<%
'''
    =====================================================================

    Copyright (C) 2022 University of Modena and Reggio Emilia

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

    =====================================================================

    Project:        Richie Toolchain

    Title:          Host Makefile.

    Description:    This class collects the templates which comply with
                    a subsystem of the Accelerator-Rich HeSoC.

                    About the generation flow:

                    - The class object is imported and instantiated by
                    the generation scripts under:

                        ==> 'richie-toolchain/richie-toolchain/generate_*.py'

                    - The object is then passed to a generator, which
                    accomplishes the rendering phase. Generators are
                    defined under:

                        ==> 'richie-toolchain/richie-toolchain/python/generator.py'

    Date:           22.11.2022

    Author:         Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''
%>

# =====================================================================
#
# Copyright (C) 2018 ETH Zurich and University of Bologna
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
# Title:           		Makefile
#
# Description:     		Host Makefile.
#
# Richie integration: Gianluca Bellocchi <gianluca.bellocchi@unimore.it>
#
# ===================================================================== */

<%
  # Accelerator interface dependencies
  accelerator_id = extra_param_0
%>

MAKEFLAGS=--warn-undefined-variables

CC       := $(CROSS_COMPILE)gcc
AR       := $(CROSS_COMPILE)ar
OBJCDUMP := $(CROSS_COMPILE)objdump

SRC_DIR  := .
INC_DIR  := ../inc
LIB_DIR  := ../lib

SOURCES  := $(SRC_DIR)/richie-target.c
CFLAGS   := -Wall -O3 -g -I. -I$(HERO_PULP_INC_DIR)
CFLAGS_SO:= $(CFLAGS) -shared -fPIC

SO       := $(LIB_DIR)/librichie-target.so
A        := $(LIB_DIR)/librichie-target.a

all: build

build:
	$(MAKE) $(A)
	$(MAKE) $(SO)

$(SO): $(SOURCES)
	mkdir -p $(LIB_DIR)
	$(foreach l,$(SOURCES),$(CC) $(CFLAGS_SO) -I$(INC_DIR) -c $(l);)
	$(CC) $(CFLAGS_SO) -o $@ $(addsuffix .o,$(basename $(notdir $(SOURCES))))
	-rm -rf $(addsuffix .o,$(basename $(notdir $(SOURCES))))

$(A): $(SOURCES)
	mkdir -p $(LIB_DIR)
	$(foreach l,$(SOURCES),$(CC) $(CFLAGS) -I$(INC_DIR) -c $(l);)
	$(AR) rvs -o $@ $(addsuffix .o,$(basename $(notdir $(SOURCES))))
	-rm -rf $(addsuffix .o,$(basename $(notdir $(SOURCES))))

.PHONY: clean install

clean:
	-rm -rf $(LIB_DIR) $(SO) $(A)
	-rm -rf $(addsuffix .o,$(basename $(notdir $(SOURCES))))

install:
ifndef HERO_TARGET_HOST
	$(error HERO_TARGET_HOST is not set)
endif
	ssh -t $(HERO_TARGET_HOST) 'mkdir -p $(HWPE_TARGET_PATH_LIB)'
	scp $(LIB_DIR)/* $(HERO_TARGET_HOST):$(HWPE_TARGET_PATH_LIB)
