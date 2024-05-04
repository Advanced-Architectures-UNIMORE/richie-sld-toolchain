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
# Name: 		    Environment test
#
# Description:  Check environment to prevent unwanted errors.
#
# Date:        	23.11.2021
#
# Author: 		  Gianluca Bellocchi <gianluca.bellocchi@unimore.it>
#
# =====================================================================

#!/bin/bash

echo -e "[sh] >> Checking the Richie environment.\n"

THIS_DIR=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
source $THIS_DIR/../common/common.sh

readonly RICHIE_HW_SRC=$1
readonly RICHIE_HW_DEPS=$2
readonly RICHIE_HW_TEST=$3

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

# ------------------------------------------ #
#  Check user-defined environment variables  #
# ------------------------------------------ #

echo -e "|------------------------|"
echo -e "| Environment variables. |"
echo -e "|------------------------|\n"

check_env_var RICHIE_HOME_DIR $RICHIE_HOME_DIR
check_env_var RICHIE_HW $RICHIE_HW

echo -e ""

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

# ------------------------------- #
#  Check if RICHIE_HW_SRC exists  #
# ------------------------------- #

echo -e "|-----------------------------------|"
echo -e "| RICHIE - SOURCE PLATFORM VARIANTS |"
echo -e "|-----------------------------------|\n"

if [ -d "$RICHIE_HW_SRC" ]; then
	# Take action if it exists. #
	echo -e "[sh] >> A src/ directory has been found -> $RICHIE_HW_SRC"
	echo -e "[sh] >> This location should comprise the toolchain-generated source files to specialize the Richie platform."
	echo -e "\n[sh] >> Is it a correct path? [ans=1,2,3]"

	select yn in "yes" "no" "help"; do
		case $yn in
			yes ) 	echo -e ""
					break;;
			no ) 	error_exit "[sh] >> Erroneous path! Aborting.";;
			help ) 	echo -e "\n[sh] >> Content of $RICHIE_HW_SRC:\n"
					ls -1 $RICHIE_HW_SRC
					echo -e "\n[sh] >> Is it a correct path?";;
		esac
	done
else
	# Take action if it does not exist. #
	error_exit "[sh] >> No src/ directory has been found. Be sure to properly setup your $RICHIE_HW environment."
fi

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

# -------------------------------- #
#  Check if RICHIE_HW_DEPS exists  #
# -------------------------------- #

echo -e "|---------------------------|"
echo -e "| RICHIE - RTL DEPENDENCIES |"
echo -e "|---------------------------|\n"

if [ -d "$RICHIE_HW_DEPS" ]; then
	# Take action if it exists. #
	echo -e "[sh] >> A deps/ directory has been found -> $RICHIE_HW_DEPS"
	echo -e "[sh] >> This location should comprise RTL dependencies, e.g. processors, DMA, interconnection, etc.)."
	echo -e "\n[sh] >> Is it a correct path? [ans=1,2,3]"

	select yn in "yes" "no" "help"; do
		case $yn in
			yes ) 	echo -e ""
					break;;
			no ) 	error_exit "[sh] >> Erroneous! Aborting.";;
			help ) 	echo -e "\n[sh] >> Content of $RICHIE_HW_DEPS:\n"
					ls -1 $RICHIE_HW_DEPS
					echo -e "\n[sh] >> Is it a correct path?";;
		esac
	done
else
	# Take action if it does not exist. #
	error_exit "[sh] >> No deps/ directory has been found. Be sure to properly setup your $RICHIE_HW environment."
fi

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

# -------------------------------- #
#  Check if RICHIE_HW_TEST exists  #
# -------------------------------- #

echo -e "|-------------------------|"
echo -e "| RICHIE - RTL TEST SUITE |"
echo -e "|-------------------------|\n"

if [ -d "$RICHIE_HW_TEST" ]; then
	# Take action if it exists. #
	echo -e "[sh] >> A vsim/ directory has been found -> $RICHIE_HW_TEST"
	echo -e "[sh] >> This location comprises a RTL simulation environment to verify the HW/SW behavior of the generated platform."
	echo -e "\n[sh] >> Is it a correct path? [ans=1,2,3]"

	select yn in "yes" "no" "help"; do
		case $yn in
			yes ) 	echo -e ""
					break;;
			no ) 	error_exit "[sh] >> Erroneous path! Aborting.";;
			help ) 	echo -e "\n[sh] >> Content of $RICHIE_HW_TEST:\n"
					ls -1 $RICHIE_HW_TEST
					echo -e "\n[sh] >> Is it a correct path?";;
		esac
	done
else
	# Take action if it does not exist. #
	error_exit "[sh] >> No test/ directory has been found. Be sure to properly setup your $RICHIE_HW environment."
fi

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

echo -e "[sh] >> Check test completed."

# ----------------------------- #
#  Completed environment check  #
# ----------------------------- #
