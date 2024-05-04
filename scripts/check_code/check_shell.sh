# =====================================================================
#
# Copyright (C) 2024 University of Modena and Reggio Emilia
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
# Name:         Check shell script
#
# Description:  Launch ShellCheck formatting tool.
#
# Date:        	2.5.2024
#
# Author: 	    Gianluca Bellocchi <gianluca.bellocchi@unimore.it>
#
# =====================================================================

#!/bin/bash

THIS_DIR=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
source $THIS_DIR/../common/common.sh

# Read Makefile arguments
readonly dir_root=$1
readonly dir_tools=$2

# Run Verible
find $dir_root -type f -name "*.sh" -exec $dir_tools/shellcheck-stable/shellcheck "{}" \;
