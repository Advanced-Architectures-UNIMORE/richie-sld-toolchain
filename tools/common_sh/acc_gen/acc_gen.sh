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
# Name: 		    Accelerator generation
#
# Description:  Generate accelerator interfaces compliant with the Richie
#               infrastructure. Besides, the procedure derives the design
#               knobs to specialize the platform components.
#
# Date:        	23.11.2021
#
# Author: 		  Gianluca Bellocchi <gianluca.bellocchi@unimore.it>
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
    echo "# ======================================================= #"
    echo "# Initializating accelerator interface design environment #"
    echo "# ======================================================= #"
    echo -e ""

    make --silent acc_gen_init
}

# =====================================================================
# Title:        read_richie_config
# Description:  This shell function reads the 'acc_config.cfg' file under
#               ${CONFIG_FILE}. This file is generated by the generator
#               Python class of 'richie-toolchain.py' once it reads the platform
#               configuration specifications. 'acc_config.cfg' is meant
#               to be a setup file to pilot the generation of accelerator
#               interfaces. This procedure is transparent to the user that
#               approaches to the toolchain.
# =====================================================================

read_richie_config()
{
    # Number of accelerators
    n_acc=$(grep N_ACC ${CONFIG_FILE} | sed 's/.*=//' | tr -d '"')

    if [ $n_acc -gt 0 ]; then

        echo -e "[sh] >> Accelerator interfaces will be generated for the following accelerator datapaths:\n"

        # Accelerator targets
        for (( c=0; c<=$n_acc-1; c++ ))
        do
            acc_targets[$c]=$(grep TARGET_ACC_$c ${CONFIG_FILE} | sed 's/.*=//' | tr -d '"')
            echo -e "\t- ${acc_targets[$c]}"
        done

        # Check data correctness
        if [ ${#acc_targets[@]} -eq 0 ]; then
            echo -e "\nOops, something went wrong, no targets have been found... \n"
            exit 1
        else
            q_correctness
        fi

    else

        echo -e "[sh] >> No targets for accelerator interfaces\n"

    fi
}

# =====================================================================
# Title:        get_accelerator_design_knobs
# Description:  This shell function invokes the 'acc_gen.mk' recipes to
#               fetch the target from the accelerator library and mirror
#               it in a runtime device environment.
# =====================================================================

get_accelerator_design_knobs()
{
    echo -e ""
    echo "# =================================== #"
    echo "# Retrieving accelerator design knobs #"
    echo "# =================================== #"
    echo -e ""

    # Cleaning generated accelerators
    cd $dir_root
    make --silent acc_gen_clean

    # Retrieve accelerator specifications
    cd $dir_acc_src
    for (( c=0; c<=$n_acc-1; c++ ))
    do
        echo "[sh] >> Retrieving accelerator design knobs concerning accelerator datapath #$c -> ${acc_targets[$c]}"
        make --silent clean all ACC_DEV_DIR=$dir_accelerator_dev TARGET_ACC=${acc_targets[$c]} ACC_HW_DESIGN=$dir_richie_acc_hw
    done
}

# =====================================================================
# Title:        check_acc_out
# Description:  This shell function invokes the 'acc_gen.mk' recipes to
#               check whether current target has already undertaken the
#               generation process (thus having generated HW/SW components
#               in the output environment), or not. This check is to avoid
#               generating multiple times the same target.
# =====================================================================

check_acc_out()
{
    echo "[sh] >> Checking previous target generation "
    if [ -d ${dir_acc_out}/${acc_targets[$c]} ]; then
        echo "[sh] >> Generated item already exists"
        is_gen="true"
    else
        echo "[sh] >> Found no previously generated item"
        is_gen="false"
    fi
}

# =====================================================================
# Title:        gen_accelerator_interface
# Description:  This shell function invokes the 'acc_gen.mk' recipes to
#               generate a specialized HW/SW interface for the target
#               accelerator.
# =====================================================================

gen_accelerator_interface()
{
    # Generate targets
    cd $dir_root
    for (( c=0; c<=$n_acc-1; c++ ))
    do
        # Check if target has already been generated
        check_acc_out

        if [ "$is_gen" == "false" ]; then
            # Generate target accelerator interface
            make --silent acc_gen_datapaths_list TARGET_ACC=${acc_targets[$c]}
            make --silent acc_gen_out_env TARGET_ACC=${acc_targets[$c]}
            make --silent acc_gen_run TARGET_ACC=${acc_targets[$c]}
        fi
    done
}

# ======= #
# Program #
# ======= #

# Read Makefile arguments
readonly dir_root=$1
readonly dir_devs=$2
readonly dir_py_venv=$3
readonly dir_acc_src=$4
readonly dir_acc_out=$5
readonly dir_richie_acc_hw=$6

readonly dir_platform_dev=$dir_devs/platform_dev
readonly dir_accelerator_dev=$dir_devs/accelerator_dev

# Activate environment
source $dir_py_venv/bin/activate

# Read user-defined configuration file
CONFIG_FILE=$dir_platform_dev/acc_config.cfg

# ======================================= #
# Generate accelerator-rich configuration #
# ======================================= #

# Initialize generation
init_generation

if [ -f ${CONFIG_FILE} ]; then
    # Read platform specification
    read_richie_config

    if [ $n_acc -gt 0 ]; then

        # Fetch accelerator specifications
        get_accelerator_design_knobs

        # Generate accelerator interfaces
        gen_accelerator_interface

    fi

else
    echo "[sh] >> No accelerator configuration found in $dir_platform_dev"
fi

# Deactivate environment
deactivate
