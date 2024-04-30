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
# Name: 		    List accelerator datapath components
#
# Description: 	Retrieve list of RTL modules that implement the datapath of the
#               application-specific accelerator.
#
# Date:        	23.11.2021
#
# Author: 			Gianluca Bellocchi <gianluca.bellocchi@unimore.it>
#
# =====================================================================

#!/bin/bash

readonly dir_accelerator_dev=$1
readonly target_acc=$2

ls ${dir_accelerator_dev}/${target_acc}/rtl >> ${dir_accelerator_dev}/${target_acc}/datapath_list.log
