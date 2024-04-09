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
# Name: 		Launch accelerator interface generation
#
# Description: 	Launch Python scripts which renders accelerator interface components.
#
# Date:        	23.11.2021
#
# Author: 		Gianluca Bellocchi <gianluca.bellocchi@unimore.it>
#
# =====================================================================

#!/bin/bash

readonly target_acc=$1
readonly dir_py_venv=$2
readonly dir_out_acc=$3

# Activate environment
source $dir_py_venv/bin/activate

# Launch python generator
cd richie-toolchain
python generate_wrapper.py $dir_out_acc
python generate_wrapper_test.py $dir_out_acc

# Deactivate environment
deactivate
