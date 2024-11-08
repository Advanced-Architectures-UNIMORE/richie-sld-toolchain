'''
    =====================================================================

    Copyright (C) 2021 University of Modena and Reggio Emilia

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

    =====================================================================

    Project:        Richie Toolchain

    Title:          Initialize Generation

    Description:    Preliminary operation to initialize the generation flow
                    with the required information about the input specifications.

    Date:           7.6.2021

    Author: 		Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''

#!/usr/bin/env python3

'''
    Import design knobs
'''
from dev.platform_dev.specs.platform_specs import PlatformSpecs

'''
    Import custom functions
'''
from python.formatter import get_acc_info

'''
    Create accelerator configuration file, which guides the generation of
    HW/SW accelerator interfaces on top of the provided accelerator design
    knobs. The former file is processed by the shell script:

        "richie-sld-toolchain/tools/common_sh/acc_gen/acc_gen_config.sh"
'''

acc_cfg_file = "dev/platform_dev/acc_config.cfg"

print("[py] >> Creating accelerator configuration file to guide the generation of HW/SW accelerator interfaces")
print("\n\t- Location ->", acc_cfg_file, "\n")

# Retrieve platform specification
platform_specs = PlatformSpecs()

# Create file
f = open(acc_cfg_file, "w")

# Extract design knobs
[target_acc, n_acc] = get_acc_info(platform_specs)

# - Number of accelerators
f.write("N_ACC=" + str(n_acc) + "\n")

# - Accelerator targets
i = 0
for t in target_acc:
    f.write("TARGET_ACC_" + str(i) + "=" + t + "\n")
    i += 1

f.close()
