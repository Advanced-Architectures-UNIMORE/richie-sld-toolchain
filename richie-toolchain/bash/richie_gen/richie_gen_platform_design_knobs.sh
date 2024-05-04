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
# Name: 		    Retrieve platform specification
#
# Description:  Retrieve platform specification file with the HeSoC characteristics.
#
# Date:        	22.12.2021
#
# Author: 			Gianluca Bellocchi <gianluca.bellocchi@unimore.it>
#
# =====================================================================

#!/bin/bash

readonly dir_richie_src=$1
readonly dir_dev=$2
readonly target_platform=$3

cd ${dir_richie_src} && make -s clean all DEV_DIR=${dir_dev} TARGET_PLATFORM=${target_platform}
