# =====================================================================
# Project:      Scripts - Generation environment
# Title:        acc_gen_out_env.sh
# Description:  Create output environment for generated accelerator wrapper.
#
# $Date:        23.11.2021
#
# =====================================================================
#
# Copyright (C) 2021 University of Modena and Reggio Emilia.
#
# Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.
#
# =====================================================================

#!/bin/bash

# Read Makefile arguments
readonly target_acc=$1
readonly dir_dev_acc=$2
readonly dir_out_acc=$3
readonly dir_static=$4

readonly dir_dev_target_acc=$dir_dev_acc/$target_acc
readonly dir_out_target_acc=$dir_out_acc/$target_acc

THIS_DIR=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
source $THIS_DIR/../common.sh

if [ ! -d "$dir_out_acc" ]; then
    echo -e "[sh] >> Creating directory for accelerator wrappers"

    mkdir $dir_out_acc
fi

if [ ! -d "$dir_out_target_acc" ]; then
    echo -e "[sh] >> Creating directory for target <$target_acc>"

    mkdir $dir_out_target_acc

    echo -e "\n\t- Location -> $dir_out_target_acc\n"

    # ========================================= #
    # Create directories for generated hardware #
    # ========================================= #

    mkdir $dir_out_target_acc/wrap
    mkdir $dir_out_target_acc/rtl
    mkdir $dir_out_target_acc/rtl/acc_kernel

    # ========================================== #
    # Create directories for test and validation #
    # ========================================== #

    # Standalone test
    dir_test_standalone=$dir_out_target_acc/test

    mkdir $dir_test_standalone
    mkdir $dir_test_standalone/hw
    mkdir $dir_test_standalone/sw
    mkdir $dir_test_standalone/sw/inc
    mkdir $dir_test_standalone/sw/inc/hwpe_lib
    mkdir $dir_test_standalone/sw/inc/stim

    # System test
    dir_test_system=$dir_out_target_acc/../../test
    dir_test_wrapper_lib=$dir_test_system/sw/inc/wrappers

    if [ -d "$dir_test_wrapper_lib" ]; then
        mkdir $dir_test_wrapper_lib/$target_acc
        mkdir $dir_test_wrapper_lib/$target_acc/hwpe_lib
    else
        error_exit "[sh] >> Directory not found -> $dir_test_system"
    fi

    # ============================================================================= #
    # Retrieve RTL of acceleration kernel 
    #
    # - Description -
    # This piece of hardware is compliant with the hardware-mapped application that has 
    # to be integrated in the overlay. It is necessary for it to be described as RTL, but 
    # to derive the latter the proposed design methodology is flexible. To this end, the 
    # user can exploit both HLS-compiled and hand-crafted HDL modules.
    # ============================================================================= #

    echo -e "[sh] >> Retrieving RTL of <$target_acc> kernel"

    dest=$dir_out_target_acc/rtl/acc_kernel
    if [ -d "$dest" ]; then
        cp -rf $dir_dev_target_acc/rtl/* $dest
    else
        error_exit "[sh] >> Directory not found -> $dest"
    fi

    # ============================================================================= #
    # Retrieve reference software-mapped application and stimuli/golden results generator
    #
    # - Description -
    # The 'ref_sw' is an user-defined software-mapped version of the application kernel
    # that the user expects to deploy as an hardware accelerator inside the overlay.
    # This is used to generate input stimuli and ouput golden results to validate the 
    # generated hardware acceleration wrapper. Generate stimuli and golden results will
    # be automatically moved in a "stim" sub-directory. More information is to be found
    # in the documentation pertaining to verification (in 'doc/how-to/verif.md').
    # ============================================================================= #

    # Copy TB generator for input stimuli and golden results (standalone test)
    dest=$dir_test_standalone/sw/inc 
    if [ -d "$dest" ]; then
        
        src=$dir_dev_target_acc/sw/ref_sw
        if [ -d "$src" ]; then
            echo -e "[sh] >> Retrieving stimuli and golden results generator (standalone test)"
            cp -R $src $dest
        else
            echo "[sh] >> Generator for stimuli and golden results not found (standalone test)"
        fi
        
        src=$dir_dev_target_acc/sw/stim
        if [ -d "$src" ]; then
            if [ ! -z "$(ls -A $src)" ]; then
                cp -R $src/ $dest
            fi
        else
            echo "[sh] >> Stimuli and golden results not found (standalone test)"
        fi

    else
        error_exit "[sh] >> Directory not found -> $dest"
    fi

    # Copy TB generator for input stimuli and golden results (system test)
    dest=$dir_test_wrapper_lib/$target_acc 
    if [ -d "$dest" ]; then
        
        src=$dir_dev_target_acc/sw/ref_sw
        if [ -d "$src" ]; then
            echo -e "[sh] >> Retrieving stimuli and golden results generator (system test)"
            cp -R $src $dest
        else
            echo "[sh] >> Generator for stimuli and golden results not found (system test)"
        fi
        
        src=$dir_dev_target_acc/sw/stim
        if [ -d "$src" ]; then
            if [ ! -z "$(ls -A $src)" ]; then
                cp -R $src/ $dest
            fi
        else
            echo "[sh] >> Stimuli and golden results not found (system test)"
        fi

    else
        error_exit "[sh] >> Directory not found -> $dest"
    fi

    # ============================================================================= #
    # Retrieve static software components 
    #
    # - Description -
    # Move static software files to their target positions. The term 'static' is used 
    # to denote files that are not targets of the rendering phase, but are either 
    # defined within the repository, or cloned as external sources. 
    # ============================================================================= #

    echo -e "[sh] >> Retrieving static software components"

    # Copy TB generator for compilation support files for software TB
    dest=$dir_test_standalone/sw
    if [ -d "$dest" ]; then
        cp -rf $dir_static/static_tb/wrapper/* $dest
    else
        error_exit "[sh] >> Directory not found -> $dest"
    fi
    
fi