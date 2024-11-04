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
# Name: 		    Generate accelerator test
#
# Description:  Generate standalone verification environment.
#
# Date:        	23.11.2021
#
# Author: 		  Gianluca Bellocchi <gianluca.bellocchi@unimore.it>
#
# =====================================================================

#!/bin/bash

readonly target_acc_verif=$1
readonly dir_out=$2
readonly dir_verif=$3

# Get source components
echo -e "[sh] >> Retrieving test components to verify the DUT <$target_acc_verif> with the generated HW/SW interface"

# update DUT
cp -rf $dir_out/$target_acc_verif $dir_verif/hw/ips

# update hardware test components
cp -rf $dir_out/$target_acc_verif/test/hw/tb_hwpe.sv $dir_verif/hw/rtl/
cp -rf $dir_out/$target_acc_verif/test/hw/Bender.yml $dir_verif/hw/
cp -rf $dir_out/$target_acc_verif/test/hw/Bender.lock $dir_verif/hw/

# update software test components
cp -rf $dir_out/$target_acc_verif/test/sw/* $dir_verif/sw/
