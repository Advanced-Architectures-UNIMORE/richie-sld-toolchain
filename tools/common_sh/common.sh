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
# Name: 				Python Venv requirements
#
# Description: 	Definition of shell variables and functions which are
#               shared by other GenOv scripts.
#
# Date:        	23.11.2021
#
# Author: 			Gianluca Bellocchi <gianluca.bellocchi@unimore.it>
#
# =====================================================================

#!/bin/bash

: '
  Shell variables
'

hwpe_target=$1

: '
  Shell functions
'

error_exit()
{
  echo -e "\n$1\n" 1>&2
  exit 1
}

q_correctness()
{
    remote_info=$1

    # echo -e "\n>> Are these information correct?"
    # select yn in "yes" "no"; do
    #   case $yn in
    #     yes ) 	break;;
    #     no ) 	  error_exit "[sh] >> Environment error!";;
    #   esac
    # done
}

check_env_var()
{
    variable_name=$1
    variable_value=$2

    if [[ -z "$variable_value" ]]; then
      error_exit "[sh] >> $variable_name is not defined yet. Please correct this!\n"
    else
      echo "[sh] >> $variable_name defined at $variable_value"
    fi
}
