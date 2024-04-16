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
# Name: 		    Platform generation
#
# Description:  Generate Accelerator-Rich HeSoC.
#
# Date:        	22.12.2021
#
# Author: 			Gianluca Bellocchi <gianluca.bellocchi@unimore.it>
#
# =====================================================================

#!/bin/bash

THIS_DIR=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
source $THIS_DIR/../common.sh

# ========= #
# Functions #
# ========= #

# =====================================================================
# Title:        init_generation
# Description:  Preliminary operation to let the generation process proceed
#               with all the required information about the input specifications.
# =====================================================================

init_generation()
{
    echo -e ""
    echo "# =============================================== #"
    echo "# Initializating the Richie Toolchain environment #"
    echo "# =============================================== #"
    echo -e ""

    cd $dir_root

    make --silent richie_gen_clean
    # make --silent richie_gen_init
    make --silent richie_gen_out_env
}

# =====================================================================
# Title:        get_platform_design_knobs
# Description:  This shell function invokes the 'richie_gen.mk' recipes to
#               retrieve the target platform specification and mirror
#               it in a runtime device environment.
# =====================================================================

get_platform_design_knobs()
{
    echo -e ""
    echo "# ================================ #"
    echo "# Retrieving platform design knobs #"
    echo "# ================================ #"
    echo -e ""

    # Retrieve platform design knobs
    make --silent richie_gen_platform_design_knobs
}

# =====================================================================
# Title:        gen_acc_wrappers
# Description:  This shell function invokes the 'acc_gen.mk' recipes to
#               generate accelerator wrappers compliant with the platform
#               infrastructure. Besides, the procedure derives the design
#               knobs to specialize the platform components.
# =====================================================================

gen_acc_wrappers()
{
    # Cleaning generated platform
    cd $dir_root
    make --silent acc_gen
}

# =====================================================================
# Title:        gen_richie
# Description:  This shell function invokes the 'richie_gen.mk' recipes to
#               generate the Richie HeSoC. Besides, the procedure derives
#               the design knobs to specialize the platform components.
# =====================================================================

gen_richie()
{
    # Generate target Accelerator-Rich HeSoC
    cd $dir_root
    make --silent richie_gen_run
}

# =====================================================================
# Title:        get_static_comps
# Description:  Retrieve static components.
# =====================================================================

get_static_comps()
{
    echo -e ""
    echo "# ================================== #"
    echo "# Retrieving static HW/SW components #"
    echo "# ================================== #"
    echo -e ""

    # Retrieve static components
    cd $dir_root
    make --silent richie_gen_out_static
}

# ======= #
# Program #
# ======= #

# Read Makefile arguments
readonly dir_root=$1
readonly dir_devs=$2
readonly dir_py_venv=$3
readonly dir_richie_src=$4
readonly dir_richie_out=$5

readonly dir_platform_dev=$dir_devs/platform_dev

# Activate environment
source $dir_py_venv/bin/activate

# ============================= #
# Generate Accelerator-Rich HeSoC #
# ============================= #

# Initialize generation
init_generation

# Retrieve platform specifications
get_platform_design_knobs

# Generate accelerator wrappers
gen_acc_wrappers

# Generate Accelerator-Rich HeSoC
gen_richie

# Retrieve static components
get_static_comps

# Deactivate environment
deactivate
