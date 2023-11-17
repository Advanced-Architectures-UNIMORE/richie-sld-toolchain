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
# Project:      GenOv
#
# Name: 		Platform generation
#
# Description:  Generate accelerator-rich SoC.
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
    echo "# ========================================= #"
    echo "# Initializating overlay design environment #"
    echo "# ========================================= #"
    echo -e ""

    cd $dir_root

    make --silent ov_gen_clean
    # make --silent ov_gen_init
    make --silent ov_gen_out_env
}

# =====================================================================
# Title:        fetch_ov_specs
# Description:  This shell function invokes the 'ov_gen.mk' recipes to
#               fetch the target from the overlay library and mirror
#               it in a runtime device environment. The latter is meant
#               to hold a high-level description of the output acc-rich
#               SoC together with the acceleration kernel targets.
#               Mirroring also permits avoiding breaking the accelerator
#               and overlay libraries.
# =====================================================================

fetch_ov_specs()
{
    echo -e ""
    echo "# ================================ #"
    echo "# Retrieving SoC design parameters #"
    echo "# ================================ #"
    echo -e ""

    # Fetch accelerator specifications
    make --silent ov_gen_fetch_specs
}

# =====================================================================
# Title:        gen_acc_wrappers
# Description:  This shell function invokes the 'acc_gen.mk' recipes to
#               generate accelerator wrappers compliant with the overlay
#               infrastructure. Furthermore, the procedure derives design
#               parameters to optimize the generated accelerator-rich overlay
#               on the basis of the application needs.
# =====================================================================

gen_acc_wrappers()
{
    # Cleaning generated overlay
    cd $dir_root
    make --silent acc_gen
}

# =====================================================================
# Title:        gen_overlay
# Description:  This shell function invokes the 'ov_gen.mk' recipes to
#               generate accelerator wrappers compliant with the overlay
#               infrastructure. Furthermore, the procedure derives design
#               parameters to optimize the generated accelerator-rich overlay
#               on the basis of the application needs.
# =====================================================================

gen_overlay()
{
    # Generate target accelerator-rich SoC
    cd $dir_root
    make --silent ov_gen_run
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
    make --silent ov_gen_out_static
}

# ======= #
# Program #
# ======= #

# Read Makefile arguments
readonly dir_root=$1
readonly dir_devs=$2
readonly dir_py_venv=$3
readonly dir_ov_src=$4
readonly dir_ov_out=$5

readonly dir_ov_dev=$dir_devs/ov_dev

# Activate environment
source $dir_py_venv/bin/activate

# ============================= #
# Generate accelerator-rich SoC #
# ============================= #

# Initialize generation
init_generation

# Retrieve platform specifications
fetch_ov_specs

# Generate accelerator wrappers
gen_acc_wrappers

# Generate accelerator-rich SoC
gen_overlay

# Retrieve static components
get_static_comps

# Deactivate environment
deactivate
