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
# Name: 		    Export generated Accelerator-Rich HeSoC.
#
# Description:  Export generated Accelerator-Rich HeSoC.
#
# Date:        	23.11.2021
#
# Author: 			Gianluca Bellocchi <gianluca.bellocchi@unimore.it>
#
# =====================================================================

#!/bin/bash

# Read Makefile arguments
readonly dir_out_richie=$1
readonly dir_hw_src=$2
readonly target_platform=$3

THIS_DIR=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
source $THIS_DIR/../common/common.sh

echo -e ""
echo -e "# ============================================== #"
echo -e "# Exporting the generated Accelerator-Rich HeSoC #"
echo -e "# ============================================== #\n"

# define src and dst
src=$dir_out_richie
dst="$dir_hw_src/$target_platform"

# Check hardware source directory where the platform variants are kept
if [ -d "$dir_hw_src" ]; then
	# Take action if it exists. #
	echo -e "[sh] >> Destination path has been found -> $dst"
	echo -e "\n[sh] >> Is it a correct path? [ans=1,2,3]"

	select yn in "yes" "no" "help"; do
		case $yn in
			yes ) 	echo -e ""
					break;;
			no ) 	error_exit "[sh] >> Erroneous path. Aborting.";;
			help ) 	echo -e "\n[sh] >> Content of destination path:\n"
					ls -1 $dst
					echo -e "\n[sh] >> Is it a correct path?";;
		esac
	done
else
	# Take action if it does not exist. #
	error_exit "[sh] >> No destination path has been found. Be sure to properly set up your environment."
fi

# Add generated platform configuration to platform design environment
if [ ! -d "$src" ]; then
    error_exit "[sh] >> Platform configuration not found."
elif [ ! -d "$dst" ]; then
	echo "[sh] >> Exporting generated files."
    cp -rf $src $dst
else
	echo "[sh] >> Platform configuration already exists. Overwriting previously generated files."
	rm -rf $dst
    cp -rf $src $dst
fi
