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
# Name: 		Platform output environment
#
# Description: 	Create output environment for generated Accelerator-Rich HeSoC.
#
# Date:        	23.11.2021
#
# Author: 			Gianluca Bellocchi <gianluca.bellocchi@unimore.it>
#
# =====================================================================

#!/bin/bash

# Read Makefile arguments
readonly target_ov=$1
readonly dir_dev_ov=$2
readonly dir_out_ov=$3
readonly dir_static=$4

THIS_DIR=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
source $THIS_DIR/../common.sh

if [ ! -d "$dir_out_ov" ]; then
    echo -e "[sh] >> Creating directory for target overlay configuration <$target_ov>"

    mkdir -p $dir_out_ov

    echo -e "\n\t- Location -> $dir_out_ov\n"

    # ========================================= #
    # Create directories for generated hardware #
    # ========================================= #

    mkdir -p $dir_out_ov/ip

    mkdir -p $dir_out_ov/soc
    mkdir -p $dir_out_ov/soc/packages
    mkdir -p $dir_out_ov/soc/rtl
    mkdir -p $dir_out_ov/soc/rtl/out-of-context

    mkdir -p $dir_out_ov/cluster
    mkdir -p $dir_out_ov/cluster/packages
    mkdir -p $dir_out_ov/cluster/rtl

    # ========================================= #
    # Create directories for software libraries #
    # ========================================= #

    mkdir -p $dir_out_ov/libs

    # LibHWPE
    mkdir -p $dir_out_ov/libs/libhwpe

    # LibAROV
    mkdir -p $dir_out_ov/libs/libarov-target

    # Default structs
    mkdir -p $dir_out_ov/libs/hwpe_structs
    mkdir -p $dir_out_ov/libs/soc_structs

    # ========================================== #
    # Create directories for test and validation #
    # ========================================== #

    mkdir -p $dir_out_ov/test

    # Simulation
    mkdir -p $dir_out_ov/test/waves

    # Software runtime
    mkdir -p $dir_out_ov/test/sw
    mkdir -p $dir_out_ov/test/sw/inc
    mkdir -p $dir_out_ov/test/sw/inc/wrappers

fi
