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
# Name: 		    Venv test
#
# Description:  Check Venv to prevent unwanted errors.
#
# Date:        	23.11.2021
#
# Author: 			Gianluca Bellocchi <gianluca.bellocchi@unimore.it>
#
# =====================================================================

#!/bin/bash

echo -e "[sh] >> Checking python virtual environment."

readonly dir_py_venv=$1

THIS_DIR=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
source $THIS_DIR/../common/common.sh

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

# --------------------------------------------- #
#  Check if python virtual environment exists.  #
# --------------------------------------------- #

echo -e "|-----------------------------------------|"
echo -e "| GENERATOR - PYTHON VIRTUAL ENVIRONMENT. |"
echo -e "|-----------------------------------------|\n"

if [ -d "$dir_py_venv" ]; then
  # Take action if it exists. #
  echo -e "[sh] >> A py-venv path has been found -> $dir_py_venv"
  echo -e "[sh] >> This location should correespond to the local python virtual environment for the generator."
  echo -e "\n>> Is it a correct path?"

  select yn in "yes" "no" "help"; do
    case $yn in
        yes )   echo -e "\n"
					      break;;
        no )    error_exit "[sh] >> Erroneous path for python virtual environment! Aborting.";;
        help )  echo -e "\n>> Content of $dir_py_venv:\n"
                ls -1 $dir_py_venv
                echo -e "\n>> Is it a correct path?";;
    esac
  done
else
  # Take action if it does not exist.
  error_exit "[sh] >> No py-venv path has been found. Be sure to initialize it with 'make init_venv'."
fi

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

echo -e "[sh] >> Completed checking the python virtual environment."

# ------------------------------ #
#  Completed environment check.  #
# ------------------------------ #
