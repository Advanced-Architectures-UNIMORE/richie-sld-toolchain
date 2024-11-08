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
# Name: 		    Retrieve static components
#
# Description: 	Retrieve static components, thus that are not generated.
#
# Date:        	23.11.2021
#
# Author: 		  Gianluca Bellocchi <gianluca.bellocchi@unimore.it>
#
# =====================================================================

#!/bin/bash

# Read Makefile arguments
readonly dir_dev_richie=$1
readonly dir_out_richie=$2
readonly dir_static=$3

THIS_DIR=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
source $THIS_DIR/../common.sh

if [ -d "$dir_out_richie" ]; then

    # ============================================================================= #
    # Retrieve static hardware files. The term 'static' is used
    # to denote files that are not targets of the rendering phase, but are either
    # defined within the repository, or cloned as external sources.
    # ============================================================================= #

    echo -e "[sh] >> Retrieving static HeSoC components"

    # Copy static system IPs
    dst=$dir_out_richie/hesoc/rtl
    if [ -d "$dst" ]; then
        cp -rf $dir_static/static_rtl/apb $dst
    else
        error_exit "[sh] >> Directory not found -> $dst"
    fi

    # ============================================================================= #
    # Retrieve static software files. The term 'static' is used
    # to denote files that are not targets of the rendering phase, but are either
    # defined within the repository, or cloned as external sources.
    # ============================================================================= #

    echo -e "[sh] >> Retrieving static SW test components"

    # Copy TB generator for compilation support files for software TB
    dst=$dir_out_richie/test/sw
    if [ -d "$dst" ]; then
        cp -rf $dir_static/static_tb/richie/Makefile $dst
        cp -rf $dir_static/static_tb/richie/inc/* $dst/inc
    else
        error_exit "[sh] >> Directory not found -> $dst"
    fi

    echo -e "[sh] >> Retrieving static SW libs components"

    # Copy compilation Makefiles for libhwpe and librichie-target
    dst=$dir_out_richie/libs
    if [ -d "$dst" ]; then
        cp -rf $dir_static/static_libs/Makefile $dst
        cp -rf $dir_static/static_libs/librichie-target/Makefile $dst/librichie-target
        for d in $dst/libhwpe/hwpe_*; do cp -f $dir_static/static_libs/libhwpe/Makefile $d; done
    else
        error_exit "[sh] >> Directory not found -> $dst"
    fi

fi
