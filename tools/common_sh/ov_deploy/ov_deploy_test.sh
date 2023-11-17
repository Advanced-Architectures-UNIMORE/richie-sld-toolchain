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
# Name: 		Environment test
#
# Description:  Check environment to prevent unwanted errors.
#
# Date:        	23.11.2021
#
# Author: 			Gianluca Bellocchi <gianluca.bellocchi@unimore.it>
#
# =====================================================================

#!/bin/bash

echo -e "[sh] >> Checking overlay environment.\n"

THIS_DIR=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
source $THIS_DIR/../common.sh

readonly OVERLAY_CFG=$1
readonly OVERLAY_DEPS=$2
readonly OVERLAY_TEST=$3

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

# ------------------------------------------ #
#  Check user-defined environment variables  #
# ------------------------------------------ #

echo -e "|------------------------|"
echo -e "| Environment variables. |"
echo -e "|------------------------|\n"

check_env_var HERO_HOME_DIR $HERO_HOME_DIR
check_env_var HERO_OV_HW_EXPORT $HERO_OV_HW_EXPORT

echo -e ""

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

# ----------------------------- #
#  Check if OVERLAY_CFG exists  #
# ----------------------------- #

echo -e "|--------------------------------|"
echo -e "| OVERLAY - SOURCE CONFIGURATION |"
echo -e "|--------------------------------|\n"

if [ -d "$OVERLAY_CFG" ]; then
	# Take action if it exists. #
	echo -e "[sh] >> A ov_cfg/ directory has been found -> $OVERLAY_CFG"
	echo -e "[sh] >> This location should comprise SystemVerilog source files to parametrize the accelerator-rich overlay system."
	echo -e "\n[sh] >> Is it a correct path? [ans=1,2,3]"

	select yn in "yes" "no" "help"; do
		case $yn in
			yes ) 	echo -e ""
					break;;
			no ) 	error_exit "[sh] >> Erroneous path for system-level integration! Aborting.";;
			help ) 	echo -e "\n[sh] >> Content of $OVERLAY_CFG:\n"
					ls -1 $OVERLAY_CFG
					echo -e "\n[sh] >> Is it a correct path?";;
		esac
	done
else
	# Take action if it does not exist. #
	error_exit "[sh] >> No src/ directory has been found. Be sure to properly setup your $HERO_OV_HW_EXPORT environment."
fi

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

# ------------------------------ #
#  Check if OVERLAY_DEPS exists  #
# ------------------------------ #

echo -e "|----------------------------|"
echo -e "| OVERLAY - RTL DEPENDENCIES |"
echo -e "|----------------------------|\n"

if [ -d "$OVERLAY_DEPS" ]; then
	# Take action if it exists. #
	echo -e "[sh] >> A deps/ directory has been found -> $OVERLAY_DEPS"
	echo -e "[sh] >> This location should comprise SystemVerilog dependencies. Basically, the overlay IPs (RISC-V core, DMA, HWPE accelerators, etc.)."
	echo -e "\n[sh] >> Is it a correct path? [ans=1,2,3]"

	select yn in "yes" "no" "help"; do
		case $yn in
			yes ) 	echo -e ""
					break;;
			no ) 	error_exit "[sh] >> Erroneous path for system-level integration! Aborting.";;
			help ) 	echo -e "\n[sh] >> Content of $OVERLAY_DEPS:\n"
					ls -1 $OVERLAY_DEPS
					echo -e "\n[sh] >> Is it a correct path?";;
		esac
	done
else
	# Take action if it does not exist. #
	error_exit "[sh] >> No deps/ directory has been found. Be sure to properly setup your $HERO_OV_HW_EXPORT environment."
fi

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

# ------------------------------ #
#  Check if OVERLAY_TEST exists  #
# ------------------------------ #

echo -e "|--------------------------|"
echo -e "| OVERLAY - RTL TEST SUITE |"
echo -e "|--------------------------|\n"

if [ -d "$OVERLAY_TEST" ]; then
	# Take action if it exists. #
	echo -e "[sh] >> A test/ directory has been found -> $OVERLAY_TEST"
	echo -e "[sh] >> This location comprises a SystemVerilog testbench to simulate the hardware behavior."
	echo -e "\n[sh] >> Is it a correct path? [ans=1,2,3]"

	select yn in "yes" "no" "help"; do
		case $yn in
			yes ) 	echo -e ""
					break;;
			no ) 	error_exit "[sh] >> Erroneous path for system-level integration! Aborting.";;
			help ) 	echo -e "\n[sh] >> Content of $OVERLAY_TEST:\n"
					ls -1 $OVERLAY_TEST
					echo -e "\n[sh] >> Is it a correct path?";;
		esac
	done
else
	# Take action if it does not exist. #
	error_exit "[sh] >> No test/ directory has been found. Be sure to properly setup your $HERO_OV_HW_EXPORT environment."
fi

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

echo -e "[sh] >> Completed checking the overlay hardware environment."

# ----------------------------- #
#  Completed environment check  #
# ----------------------------- #
