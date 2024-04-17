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

    Title:          Generation of the HWPE-based Accelerator Interface Tests

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

                        ==> 'richie-toolchain/richie-toolchain/python/<component-libraries>/process_design_knobs.py'

                    - The rendering phase requires a generator which is invoked by the
                    current script via the 'gen_*_comps' function. The definition of
                    both the generator and function are found under:

                        ==> 'richie-toolchain/richie-toolchain/python/<component-libraries>/generator.py'

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
from python.accelerator.process_design_knobs import AcceleratorDesignKnobsFormatted
from python.accelerator.process_design_knobs import print_generation_log
from python.accelerator.import_design_knobs import import_accelerator_design_knobs

'''
    Import generator
'''
from python.generator import Generator

'''
    Import emitter
'''
from python.emitter import Emitter

'''
    Import templates
'''
from templates.accelerator.hw.hwpe_wrapper.hwpe_wrapper import HwpeWrapper
from templates.accelerator.hw.hwpe_standalone_test.hwpe_standalone_test import HwpeStandaloneTest
from templates.accelerator.sw.hwpe_standalone_hal.hwpe_standalone_hal import HwpeStandaloneHal
from templates.accelerator.sw.hwpe_system_hal.hwpe_system_hal import HwpeSystemHal

'''
    Read input arguments
'''
dir_out_acc = sys.argv[1]

'''
    Retrieve accelerator specification
'''
target_acc = os.environ['TARGET_ACC']
accelerator_specs = import_accelerator_design_knobs(target_acc)

'''
    Format accelerator specification
'''

accelerator_design_knobs = AcceleratorDesignKnobsFormatted(accelerator_specs.AcceleratorSpecs)

'''
    Instantiate emitter
'''
emitter = Emitter(None, accelerator_design_knobs, None, dir_out_acc)

'''
    Print generation log
'''

print_generation_log(accelerator_design_knobs)

'''
    =====================================================================
    Component:      Standalone Test for the Accelerator interface (HWPE-based)

    Description:    Generation of hardware test components.
    ===================================================================== */
'''

'''
    Instantiate templates
'''
hwpe_standalone_test = HwpeStandaloneTest()

'''
    Instantiate generator
'''
generator = Generator()

'''
    Generate design components ~ Hardware test
    Basic standalone testbench that instantiates the DUT
    (generated accelerator), a RISC-V processor and some
    dummy memories to implement instruction, stack and data
    memories.
'''
generator.render(
    hwpe_standalone_test.HwpeTbHw(),
    None,
    accelerator_design_knobs,
    emitter,
    ['tb', 'tb_hwpe', ['hw', 'sv']],
    emitter.out_accelerator_standalone_test_hw
)

'''
    =====================================================================
    Component:      Standalone Test for the Accelerator interface (HWPE-based)

    Description:    Generation of software test components (Hardware
                    Abstraction Layer, HAL).
    ===================================================================== */
'''

'''
    Instantiate SW testbench item
'''
hwpe_standalone_hal = HwpeStandaloneHal()

'''
    Generate design components ~ Archi
    Description of the memory mapping.
'''
generator.render(
    hwpe_standalone_hal.ArchiHwpe(),
    None,
    accelerator_design_knobs,
    emitter,
    ['sw', 'archi_hwpe', ['sw', 'archi']],
    emitter.out_accelerator_standalone_test_hwpe_lib
)

'''
    Generate design components ~ Hardware Abstraction Layer (HAL)
    Hardware Abstraction Layer with accelerator SW primitives.
'''
generator.render(
    hwpe_standalone_hal.HalHwpe(),
    None,
    accelerator_design_knobs,
    emitter,
    ['sw', 'hal_hwpe', ['sw', 'hal']],
    emitter.out_accelerator_standalone_test_hwpe_lib
)

'''
    Generate design components ~ Software test
    SW test to assess HWPE functionality consisting of a baremetal
    test running in the standalone test.
'''
generator.render(
    hwpe_standalone_hal.HwpeTbSw(),
    None,
    accelerator_design_knobs,
    emitter,
    ['sw', 'tb_hwpe', ['sw', 'tb']],
    emitter.out_accelerator_standalone_test_sw
)

'''
    =====================================================================
    Component:      Standalone Test for the Accelerator interface (HWPE-based)

    Description:    Generation of simulation test components (QuestaSim waves).
    ===================================================================== */
'''

'''
    Generate design components ~ QuestaSim waves
'''
generator.render(
    hwpe_standalone_test.VsimWave(),
    None,
    accelerator_design_knobs,
    emitter,
    ['integr_support', 'vsim_wave', ['integr_support', 'vsim_wave']],
    emitter.out_accelerator
)

'''
    =====================================================================
    Component:      System-Level Test for the Accelerator interface (HWPE-based)

    Description:    The system-level test consists of the integration of the
                    accelerator in the Richie-based Accelerator-Rich HeSoC
                    and subsequent run of the test application on the Richie
                    Cluster.

                    Generation of software test components (Hardware
                    Abstraction Layer, HAL).
    ===================================================================== */
'''

'''
    Instantiate SW testbench item
'''
hwpe_system_hal = HwpeSystemHal()

'''
    Generate design components ~ Archi
    Description of the memory mapping.
'''
generator.render(
    hwpe_system_hal.ArchiHwpe(),
    None,
    accelerator_design_knobs,
    emitter,
    ['sw', 'archi_hwpe', ['sw', 'archi']],
    emitter.out_accelerator_system_test_hwpe_lib
)

'''
    Generate design components ~ Hardware Abstraction Layer (HAL)
    Hardware Abstraction Layer with accelerator SW primitives.
'''
generator.render(
    hwpe_system_hal.HalHwpe(),
    None,
    accelerator_design_knobs,
    emitter,
    ['sw', 'hal_hwpe', ['sw', 'hal']],
    emitter.out_accelerator_system_test_hwpe_lib
)

'''
    Generate design components ~ Software test
    SW test to assess HWPE functionality consisting of a baremetal
    test running inside the Richie-based Accelerator-Rich HeSoC.
'''
generator.render(
    hwpe_system_hal.HwpeTbSw(),
    None,
    accelerator_design_knobs,
    emitter,
    ['sw', 'tb_hwpe', ['sw', 'tb']],
    emitter.out_accelerator_system_test_hwpe_lib
)
