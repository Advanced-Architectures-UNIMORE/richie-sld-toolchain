'''
    =====================================================================

    Copyright (C) 2021 ETH Zurich, University of Modena and Reggio Emilia

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

    Title:          Generation of the Platform Cluster

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

    Date:           23.11.2021

    Author: 		Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''

#!/usr/bin/env python3

import sys

'''
    Import custom functions
'''
from python.richie.process_design_knobs import PlatformDesignKnobsFormatted
from python.cluster.process_design_knobs import print_generation_log
from python.richie.process_design_knobs import get_acc_targets

'''
    Import generator
'''
from python.richie.generator import Generator

'''
    Import emitter
'''
from python.richie.emitter import EmitRichie

'''
    Import design knobs
'''
from dev.platform_dev.specs.platform_specs import PlatformSpecs

'''
    Import templates
'''
from templates.platform.hw.cluster.cluster import Cluster

'''
    Read input arguments
'''
dir_out_richie = sys.argv[1]

'''
    Retrieve platform specification
'''
platform_specs = PlatformSpecs

'''
    Format platform specification
'''
platform_design_knobs = PlatformDesignKnobsFormatted(platform_specs)

'''
    Instantiate emitter
'''
emitter = EmitRichie(platform_specs, dir_out_richie)

'''
    Instantiate templates
'''
cluster = Cluster()

'''
    Instantiate generator
'''
generator = Generator()

'''
    Generate one-by-one all necessary cluster components
'''

for cl_offset in range(platform_design_knobs.n_clusters):

    '''
        Print generation log
    '''
    print_generation_log(platform_design_knobs, cl_offset)

    '''
        =====================================================================
        Component:      Parameters and macros

        Description:    Generation of hardware components for the Richie Cluster.
        ===================================================================== */
    '''

    '''
        Generate design components ~ PULP cluster package
    '''
    generator.render(
        cluster.PulpClusterCfgPkg(),
        platform_design_knobs,
        None,
        emitter,
        ['cl', str(cl_offset) + '_cfg_pkg', ['hw', 'sv']],
        emitter.out_gen_cl_pkg,
        cl_offset
    )

    '''
        Generate design components ~ PULP cluster macros
    '''
    generator.render(
        cluster.PulpClusterDefines(),
        platform_design_knobs,
        None,
        emitter,
        ['cl', str(cl_offset) + '_defines', ['hw', 'sv']],
        emitter.out_gen_cl_pkg,
        cl_offset
    )

    '''
        =====================================================================
        Component:      Hardware

        Description:    Generation of hardware components for cluster.
        ===================================================================== */
    '''

    '''
        Generate design components ~ LIC accelerator region
    '''

    generator.render(
        cluster.LicAccRegion(),
        platform_design_knobs,
        None,
        emitter,
        ['cl', str(cl_offset) + '_lic_acc_region', ['hw', 'sv']],
        emitter.out_gen_cl_rtl,
        cl_offset
    )

    '''
        Generate design components ~ Peripheral accelerator interface
    '''
    generator.render(
        cluster.PeriphAccIntf(),
        platform_design_knobs,
        None,
        emitter,
        ['cl', str(cl_offset) + '_periph_acc_intf', ['hw', 'sv']],
        emitter.out_gen_cl_rtl,
        cl_offset
    )

'''
    =====================================================================
    Component:      Integration support

    Description:    Generation of integration support components, such as
                    scripts for source management tools, simulations, etc.
    ===================================================================== */
'''

'''
    Generate design components ~ Bender
'''
generator.render(
    cluster.Bender(),
    platform_design_knobs,
    None,
    emitter,
    ['integr_support', 'Bender', ['integr_support', 'yml']],
    emitter.out_gen_cl,
    0,
    [get_acc_targets(platform_design_knobs), None, None]
)

