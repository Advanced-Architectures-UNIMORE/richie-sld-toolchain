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

                        ==> 'richie-toolchain/richie-toolchain/python/<component-libraries>/process_design_knobs.py'

                    - The rendering phase requires a generator which is invoked by the
                    current script via the 'gen_*_comps' function. The definition of
                    both the generator and function are found under:

                        ==> 'richie-toolchain/richie-toolchain/python/<component-libraries>/generator.py'

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
    Import custom functions
'''
from python.accelerator.process_design_knobs import AcceleratorDesignKnobsFormatted
from python.accelerator.process_design_knobs import print_wrapper_log
from python.accelerator.import_design_knobs import import_accelerator_design_knobs

'''
    Import generator
'''
from python.richie.generator import Generator

'''
    Import emitter
'''
from python.accelerator.emitter import AcceleratorEmitter

'''
    Import templates
'''
from templates.accelerator.hw.hwpe_wrapper.hwpe_wrapper import HwpeWrapper

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
emitter = AcceleratorEmitter(accelerator_design_knobs, dir_out_acc)

'''
    Print generation log
'''

print_wrapper_log(accelerator_design_knobs)

'''
    Instantiate templates
'''
hwpe_wrapper = HwpeWrapper()

'''
    Instantiate generator
'''
generator = Generator()

if accelerator_design_knobs.is_third_party is False:

    '''
        =====================================================================
        Component:      Accelerator interface (HWPE-based)

        Description:    Generation of components concerning the accelerator
                        interface. and integrate application-specific accelerators
                        inside the Richie Cluster. The interface is meant to
                        enable the accelerator communication within Richie.
        ===================================================================== */
    '''

    '''
        Generate design components ~ Cluster interface
    '''
    generator.render(
        hwpe_wrapper.HwpeClusterIntf(),
        None,
        accelerator_design_knobs,
        emitter,
        ['hwpe', 'cluster_intf', ['hw', 'sv']],
        emitter.out_gen_wrap
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
        emitter.out_gen_wrap
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
        emitter.out_gen_rtl
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
        emitter.out_gen_rtl
    )

    '''
        Generate design components ~ Kernel adapter
    '''
    generator.render(
        hwpe_wrapper.HwpeKernelAdapter(),
        None,
        accelerator_design_knobs,
        emitter,
        ['hwpe', 'kernel_adapter', ['hw', 'sv']],
        emitter.out_gen_rtl
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
        emitter.out_gen_rtl
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
        emitter.out_gen_rtl
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
        emitter.out_gen_rtl
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
        emitter.out_gen_rtl
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
        emitter.out_hwpe
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
        emitter.out_hwpe
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
        emitter.out_hwpe
    )

else:

    '''
        In this case, only generate the interface to the Richie Cluster.
    '''

    '''
        Generate design components ~ Cluster interface
    '''
    generator.render(
        hwpe_wrapper.HwpeClusterIntf(),
        None,
        accelerator_design_knobs,
        emitter,
        ['hwpe', 'cluster_intf', ['hw', 'sv']],
        emitter.out_gen_wrap
    )
