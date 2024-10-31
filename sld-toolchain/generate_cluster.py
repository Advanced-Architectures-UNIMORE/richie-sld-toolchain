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

    Title:          Generation of the Richie Cluster

    Description:    This script specializes and generates a subsystem of the
                    Accelerator-Rich HeSoC, given the platform and accelerator
                    specification files which are provided as an entry point
                    by the user.

                    About the generation flow:

                    - Generated components are obtained through the rendering of
                    their associated templates. These are imported by the script
                    as Python modules and can be found under:

                        ==> 'richie-sld-toolchain/sld-toolchain/templates'

                    - Specifications are pre-processed, so as to ease the rendering
                    phase by formatting values, and so on. This is accomplished by
                    the scripts under:

                        ==> 'richie-sld-toolchain/sld-toolchain/python/formatter.py'

                    - The rendering phase requires a generator which is invoked by the
                    current script via the 'gen_*_comps' function. The definition of
                    both the generator and function are found under:

                        ==> 'richie-sld-toolchain/sld-toolchain/python/generator.py'

                    - After generation, the specialized components are assembled all
                    together into an output environment which resembles the top hierarchy
                    of the Accelerator-Rich HeSoC and which holds the same name specified
                    in the platform specification file. In order to create this
                    environment, the Richie Toolchain instantiates an emitter object which
                    definition is found under:

                        ==> 'richie-sld-toolchain/sld-toolchain/python'

    Date:           23.11.2021

    Author: 		Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''

#!/usr/bin/env python3

import sys

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
    Import design knobs
'''
from dev.platform_dev.specs.platform_specs import PlatformSpecs

'''
    Import formatter
'''
from python.formatter import Formatter

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
    Instantiate formatter
'''
format = Formatter()

'''
    Format platform specification
'''
platform_design_knobs = format.platform(platform_specs)

'''
    Instantiate logger
'''
logger = Logger(platform_design_knobs, None)

'''
    Instantiate emitter
'''
emitter = Emitter(platform_specs, None, dir_out_richie, None)

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
    logger.cluster(cl_offset)

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
        emitter.out_platform_cl_pkg,
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
        ['cl', str(cl_offset) + '_defines', ['hw', 'svh']],
        emitter.out_platform_cl_inc,
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
        emitter.out_platform_cl_rtl,
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
        emitter.out_platform_cl_rtl,
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
    emitter.out_platform_cl,
    0,
    [format.get_acc_targets(platform_design_knobs), None, None]
)

