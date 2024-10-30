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

    Title:          Generation of the HWPE-based Accelerator Interface

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

                        ==> 'richie-toolchain/richie-toolchain/python/formatter.py'

                    - The rendering phase requires a generator which is invoked by the
                    current script via the 'gen_*_comps' function. The definition of
                    both the generator and function are found under:

                        ==> 'richie-toolchain/richie-toolchain/python/generator.py'

                    - After generation, the specialized components are assembled all
                    together into an output environment which resembles the top hierarchy
                    of the Accelerator-Rich HeSoC and which holds the same name specified
                    in the platform specification file. In order to create this
                    environment, the Richie Toolchain instantiates an emitter object which definition
                    is found under:

                        ==> 'richie-toolchain/richie-toolchain/python'

    Date:           23.11.2021

    Author: 		Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''

#!/usr/bin/env python3

import sys
import os

'''
    Import generator
'''
from python.generator import Generator

'''
    Import emitter
'''
from python.emitter import Emitter

'''
    Import logger
'''
from python.logger import Logger

'''
    Import formatter
'''
from python.formatter import Formatter

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
    Instantiate formatter
'''
format = Formatter()

'''
    Retrieve accelerator specification
'''
target_acc = os.environ['TARGET_ACC']
accelerator_design_knobs_raw_module = format.import_accelerator_design_knobs(target_acc)
accelerator_design_knobs_raw = accelerator_design_knobs_raw_module.AcceleratorSpecs

'''
    Format accelerator specification
'''
accelerator_design_knobs = format.accelerator(accelerator_design_knobs_raw)

'''
    Instantiate emitter
'''
emitter = Emitter(None, accelerator_design_knobs, None, dir_out_acc)

'''
    Instantiate logger
'''
logger = Logger(None, accelerator_design_knobs)

'''
    Instantiate templates
'''
hwpe_wrapper = HwpeWrapper()
hwpe_standalone_test = HwpeStandaloneTest()

'''
    Instantiate generator
'''
generator = Generator()

'''
    =====================================================================
    Component:      Accelerator interface (HWPE-based)

    Description:    Generation of the accelerator interface to integrate
                    application-specific accelerators inside Richie.
    ===================================================================== */
'''

'''
    Print generation log
'''
logger.hwpe_accelerator_interface()

'''
    Generate design components ~ Cluster interface
'''
generator.render(
    hwpe_wrapper.HwpeClusterIntf(),
    None,
    accelerator_design_knobs,
    emitter,
    ['hwpe', 'cluster_intf', ['hw', 'sv']],
    emitter.out_accelerator_rtl
)

'''
    Generate design components ~ Top wrapper
'''
generator.render(
    hwpe_wrapper.HwpeTopWrapper(),
    None,
    accelerator_design_knobs,
    emitter,
    ['hwpe', 'top_wrapper', ['hw', 'sv']],
    emitter.out_accelerator_rtl
)

'''
    Generate design components ~ Top
'''
generator.render(
    hwpe_wrapper.HwpeTop(),
    None,
    accelerator_design_knobs,
    emitter,
    ['hwpe', 'top', ['hw', 'sv']],
    emitter.out_accelerator_rtl
)

'''
    Generate design components ~ Engine
'''
generator.render(
    hwpe_wrapper.HwpeEngine(),
    None,
    accelerator_design_knobs,
    emitter,
    ['hwpe', 'engine', ['hw', 'sv']],
    emitter.out_accelerator_rtl
)

'''
    Generate design components ~ Datapath adapter
'''
generator.render(
    hwpe_wrapper.HwpeDatapathAdapter(),
    None,
    accelerator_design_knobs,
    emitter,
    ['hwpe', 'datapath_adapter', ['hw', 'sv']],
    emitter.out_accelerator_rtl
)

'''
    Generate design components ~ Streamer
'''
generator.render(
    hwpe_wrapper.HwpeStreamer(),
    None,
    accelerator_design_knobs,
    emitter,
    ['hwpe', 'streamer', ['hw', 'sv']],
    emitter.out_accelerator_rtl
)

'''
    Generate design components ~ Controller
'''
generator.render(
    hwpe_wrapper.HwpeCtrl(),
    None,
    accelerator_design_knobs,
    emitter,
    ['hwpe', 'ctrl', ['hw', 'sv']],
    emitter.out_accelerator_rtl
)

'''
    Generate design components ~ FSM
'''
generator.render(
    hwpe_wrapper.HwpeFsm(),
    None,
    accelerator_design_knobs,
    emitter,
    ['hwpe', 'fsm', ['hw', 'sv']],
    emitter.out_accelerator_rtl
)

'''
    Generate design components ~ Package
'''
generator.render(
    hwpe_wrapper.HwpePackage(),
    None,
    accelerator_design_knobs,
    emitter,
    ['hwpe', 'package', ['hw', 'sv']],
    emitter.out_accelerator_rtl
)

'''
    =====================================================================
    Component:      Accelerator interface (Dependency management)

    Description:    Generation of integration support components, such as
                    scripts for source management tools, simulations, etc.
    ===================================================================== */
'''

'''
    Generate design components ~ Bender
'''
generator.render(
    hwpe_wrapper.Bender(),
    None,
    accelerator_design_knobs,
    emitter,
    ['integr_support', 'Bender', ['integr_support', 'yml']],
    emitter.out_accelerator
)

'''
    Generate design components ~ List of IP modules
'''
generator.render(
    hwpe_wrapper.SrcFiles(),
    None,
    accelerator_design_knobs,
    emitter,
    ['tb', 'src_files', ['integr_support', 'yml']],
    emitter.out_accelerator
)

'''
    Generate design components ~ List of IP dependencies
'''
generator.render(
    hwpe_wrapper.IpsList(),
    None,
    accelerator_design_knobs,
    emitter,
    ['tb', 'ips_list', ['integr_support', 'yml']],
    emitter.out_accelerator
)

'''
    =========================================================================
    Component:      Standalone Test for the Accelerator interface (HWPE-based)

    Description:    Generation of hardware test components.
    ========================================================================= */
'''

'''
    Print generation log
'''
logger.hwpe_accelerator_interface_test()

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

    Description:    Generation of integration support components, such as
                    scripts for source management tools, simulations, etc.
    ===================================================================== */
'''

'''
    Generate design components ~ Bender
'''
generator.render(
    hwpe_standalone_test.Bender(),
    None,
    accelerator_design_knobs,
    emitter,
    ['integr_support', 'Bender', ['integr_support', 'yml']],
    emitter.out_accelerator_standalone_test_hw
)

'''
    Generate design components ~ Bender lock
'''
generator.render(
    hwpe_standalone_test.BenderLock(),
    None,
    accelerator_design_knobs,
    emitter,
    ['integr_support', 'Bender', ['integr_support', 'lock']],
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
