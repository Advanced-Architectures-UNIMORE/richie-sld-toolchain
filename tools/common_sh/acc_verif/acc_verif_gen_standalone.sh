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
# Name: 		Generate accelerator test
#
# Description:  Generate standalone verification environment.
#
# Date:        	23.11.2021
#
# Author: 		Gianluca Bellocchi <gianluca.bellocchi@unimore.it>
#
# =====================================================================

#!/bin/bash

readonly dir_out=$1
readonly dir_verif=$2

# Get source components (see Makefile recipe deps)
echo -e "[sh] >> Retrieving generated TB components to validate accelerator wrapper"

# update hw tb
cp -rf $dir_out/hw/hwpe_standalone_tb/tb_hwpe.sv $dir_verif/hw/rtl/

# update sw tb
cp -rf $dir_out/sw/hwpe_standalone_tb/* $dir_verif/sw/
