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

    Title:          Accelerator Tests Generation

    Description:    This script specializes and generates a subsystem of the
                    Accelerator-Rich HeSoC, given the platform and accelerator
                    specification files which are provided as an entry point
                    by the user.

                    About the generation flow:

                    - Generated components are obtained through the rendering of
                    their associated templates. These are imported by the script
                    as Python modules and can be found under:

                        ==> 'richie-toolchain/richie-toolchain/templates'

                    - Specifications are pre-processed, so as to ease the rendering
                    phase by formatting values, and so on. This is accomplished by
                    the scripts under:

                        ==> 'richie-toolchain/richie-toolchain/python/SOMETHING-TO-RENDER/process_params.py'

                    - The rendering phase requires a generator which is invoked by the
                    current script via the 'gen_*_comps' function. The definition of
                    both the generator and function are found under:

                        ==> 'richie-toolchain/richie-toolchain/python/SOMETHING-TO-RENDER/generator.py'

                    - After generation, the specialized components are assembled all
                    together into an output environment which resembles the top hierarchy
                    of the Accelerator-Rich HeSoC and which holds the same name specified
                    in the platform specification file. In order to create this
                    environment, the Richie Toolchain instantiates an emitter object which
                    definition is found under:

                        ==> 'richie-toolchain/richie-toolchain/python'

    Date:           15.7.2021

    Author: 		Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''

#!/usr/bin/env python3

import sys
import os

'''
    Import custom functions
'''
from python.wrapper.process_params import wrapper_params_formatted
from python.wrapper.process_params import print_wrapper_test_log
from python.wrapper.generator import gen_acc_comps
from python.wrapper.import_params import import_acc_dev_module

'''
    Import emitter
'''
from python.wrapper.emitter import EmitWrapper

'''
    Import accelerator wrapper templates (integration support)
'''
from templates.acc_templ.integr_support.integr_support import integr_support

'''
    Import accelerator wrapper templates (TB)
'''
from templates.acc_templ.hw.hwpe_standalone_tb.hwpe_standalone_tb import hwpe_standalone_tb as hwpe_standalone_tb_hw
from templates.acc_templ.sw.hwpe_standalone_tb.hwpe_standalone_tb import hwpe_standalone_tb as hwpe_standalone_tb_sw
from templates.acc_templ.sw.hwpe_system_tb.hwpe_system_tb import hwpe_system_tb as hwpe_system_tb_sw

'''
    Read input arguments
'''
dir_out_acc = sys.argv[1]

'''
    Retrieve design parameters
'''
target_acc = os.environ['TARGET_ACC']
acc_specs = import_acc_dev_module(target_acc)

'''
    Format design parameters
'''

design_params = wrapper_params_formatted(acc_specs.acc_specs)

'''
    Instantiate emitter item
'''
emitter = EmitWrapper(design_params, dir_out_acc)

'''
    Print wrapper test log
'''

print_wrapper_test_log(design_params)

'''
    =====================================================================
    Component:      Wrapper standalone test (Hardware)

    Description:    Generation of test components, such as HW/SW testbench,
                    accelerator runtime calls, Modelsim waves, etc.
    ===================================================================== */
'''

'''
    Instantiate HW testbench item
'''
hwpe_standalone_tb_hw = hwpe_standalone_tb_hw()

'''
    Generate design components ~ hardware testbench
    Basic standalone testbench that instantiates the DUT
    (generated accelerator), a RISC-V processor and some
    dummy memories to implement instruction, stack and data
    memories.
'''
gen_acc_comps(
    hwpe_standalone_tb_hw.tb_hwpe(),
    design_params,
    emitter,
    ['tb', 'tb_hwpe', ['hw', 'sv']],
    emitter.hwpe_gen_standalone_test_hw
)

'''
    =====================================================================
    Component:      Wrapper standalone test (Software)

    Description:    Generation of test components, such as HW/SW testbench,
                    accelerator runtime calls, Modelsim waves, etc.
    ===================================================================== */
'''

'''
    Instantiate SW testbench item
'''
hwpe_standalone_tb_sw = hwpe_standalone_tb_sw()

'''
    Generate design components ~ archi
    Retrieve memory-mapped hardware accelerator registers.
'''
gen_acc_comps(
    hwpe_standalone_tb_sw.archi_hwpe(),
    design_params,
    emitter,
    ['sw', 'archi_hwpe', ['sw', 'archi']],
    emitter.hwpe_gen_standalone_test_hwpe_lib
)

'''
    Generate design components ~ hardware abstraction layer (HAL)
    Retrieve Hardware Abstraction Layer with functions that permit
    to create an interaction between the RISC-V processor and the
    hardware accelerator.
'''
gen_acc_comps(
    hwpe_standalone_tb_sw.hal_hwpe(),
    design_params,
    emitter,
    ['sw', 'hal_hwpe', ['sw', 'hal']],
    emitter.hwpe_gen_standalone_test_hwpe_lib
)

'''
    Generate design components ~ software testbench
    Retrieve software testbench to assess HWPE functionality. This
    is a pure baremetal test running on the riscv proxy core comprised
    in the standalone HWPE testbench. This tb can be used to assess the
    functionality of the generated wrapper before to integrate it at
    system-level.
'''
gen_acc_comps(
    hwpe_standalone_tb_sw.tb_hwpe(),
    design_params,
    emitter,
    ['sw', 'tb_hwpe', ['sw', 'tb']],
    emitter.hwpe_gen_standalone_test_sw
)

'''
    =====================================================================
    Component:      Wrapper standalone test (Debug support)

    Description:    Generation of test components, such as HW/SW testbench,
                    accelerator runtime calls, Modelsim waves, etc.
    ===================================================================== */
'''

'''
    Instantiate integration support item
'''
integr_support = integr_support()

'''
    Generate design components ~ QuestaSim waves
'''
gen_acc_comps(
    integr_support.vsim_wave(),
    design_params,
    emitter,
    ['integr_support', 'vsim_wave', ['integr_support', 'vsim_wave']],
    emitter.out_hwpe
)

'''
    =====================================================================
    Component:      Wrapper system test (Software)

    Description:    Generation of test components, such as HW/SW testbench,
                    accelerator runtime calls, Modelsim waves, etc.
    ===================================================================== */
'''

'''
    Instantiate SW testbench item
'''
hwpe_system_tb_sw = hwpe_system_tb_sw()

'''
    Generate design components ~ Archi
    Retrieve memory-mapped hardware accelerator registers.
'''
gen_acc_comps(
    hwpe_system_tb_sw.archi_hwpe(),
    design_params,
    emitter,
    ['sw', 'archi_hwpe', ['sw', 'archi']],
    emitter.hwpe_gen_system_test_hwpe_lib
)

'''
    Generate design components ~ Hardware abstraction layer (HAL)
    Retrieve Hardware Abstraction Layer with functions that permit
    to create an interaction between the RISC-V processor and the
    hardware accelerator.
'''
gen_acc_comps(
    hwpe_system_tb_sw.hal_hwpe(),
    design_params,
    emitter,
    ['sw', 'hal_hwpe', ['sw', 'hal']],
    emitter.hwpe_gen_system_test_hwpe_lib
)

'''
    Generate design components ~ Software testbench
    Retrieve software testbench to assess HWPE functionality. This
    is a pure baremetal test running on the riscv proxy core comprised
    in the overlay system. This tb can be used as a starting point for
    additional platform testing.
'''
gen_acc_comps(
    hwpe_system_tb_sw.tb_hwpe(),
    design_params,
    emitter,
    ['sw', 'tb_hwpe', ['sw', 'tb']],
    emitter.hwpe_gen_system_test_hwpe_lib
)
