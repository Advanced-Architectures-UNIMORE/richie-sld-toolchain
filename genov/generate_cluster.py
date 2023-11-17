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

    Project:        GenOv

    Title:          Cluster Generation

    Description:    This script specializes and generates a subsystem of the
                    accelerator-rich SoC, given the platform and accelerator
                    specification files which are provided as an entry point
                    by the user.

                    About the generation flow:

                    - Generated components are obtained through the rendering of
                    their associated templates. These are imported by the script
                    as Python modules and can be found under:

                        ==> 'genov/genov/templates'

                    - Specifications are pre-processed, so as to ease the rendering
                    phase by formatting values, and so on. This is accomplished by
                    the scripts under:

                        ==> 'genov/genov/python/SOMETHING-TO-RENDER/process_params.py'

                    - The rendering phase requires a generator which is invoked by the
                    current script via the 'gen_*_comps' function. The definition of
                    both the generator and function are found under:

                        ==> 'genov/genov/python/SOMETHING-TO-RENDER/generator.py'

                    - After generation, the specialized components are assembled all
                    together into an output environment which resembles the top hierarchy
                    of the accelerator-rich SoC and which holds the same name specified
                    in the platform specification file. In order to create this
                    environment, GenOv instantiates an emitter object which definition
                    is found under:

                        ==> 'genov/genov/python'

    Date:           23.11.2021

    Author: 		Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''

#!/usr/bin/env python3

import sys

'''
    Import custom functions
'''
from python.overlay.process_params import overlay_params_formatted
from python.cluster.generator import gen_cl_comps
from python.cluster.process_params import print_cl_log
from python.overlay.process_params import get_acc_targets

'''
    Import emitter
'''
from python.overlay.emitter import EmitOv

'''
    Import design parameters
'''
from dev.ov_dev.specs.ov_specs import ov_specs

'''
    Import cluster templates
'''
from templates.ov_templ.hw.cluster.cluster import Cluster

'''
    Read input arguments
'''
dir_out_ov = sys.argv[1]

'''
    Retrieve overlay design parameters
'''
ov_specs = ov_specs

'''
    Format design parameters
'''
design_params = overlay_params_formatted(ov_specs)

'''
    Instantiate emitter item
'''
emitter = EmitOv(ov_specs, dir_out_ov)

'''
    Instantiate cluster template item
'''
cluster = Cluster()

'''
    =====================================================================
    Component:      Parameters and macros

    Description:    Generation of hardware components for SoC.
    ===================================================================== */
'''

for cl_offset in range(design_params.n_clusters):

    '''
        Generate design components ~ PULP cluster package
    '''
    gen_cl_comps(
        cluster.PulpClusterCfgPkg(),
        design_params,
        emitter,
        ['cl', str(cl_offset) + '_cfg_pkg', ['hw', 'sv']],
        emitter.ov_gen_cl_pkg,
        cl_offset
    )

    '''
        Generate design components ~ PULP cluster macros
    '''
    gen_cl_comps(
        cluster.PulpClusterDefines(),
        design_params,
        emitter,
        ['cl', str(cl_offset) + '_defines', ['hw', 'sv']],
        emitter.ov_gen_cl_pkg,
        cl_offset
    )

'''
    =====================================================================
    Component:      Hardware

    Description:    Generation of hardware components for cluster.
    ===================================================================== */
'''

'''
    Generate one-by-one all necessary cluster components
'''

for cl_offset in range(design_params.n_clusters):

    '''
        Print cluster log
    '''

    print_cl_log(design_params, cl_offset)

    '''
        Generate design components ~ LIC accelerator region
    '''

    gen_cl_comps(
        cluster.LicAccRegion(),
        design_params,
        emitter,
        ['cl', str(cl_offset) + '_lic_acc_region', ['hw', 'sv']],
        emitter.ov_gen_cl_rtl,
        cl_offset
    )

    '''
        Generate design components ~ Peripheral accelerator interface
    '''
    gen_cl_comps(
        cluster.PeriphAccIntf(),
        design_params,
        emitter,
        ['cl', str(cl_offset) + '_periph_acc_intf', ['hw', 'sv']],
        emitter.ov_gen_cl_rtl,
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
gen_cl_comps(
    cluster.Bender(),
    design_params,
    emitter,
    ['integr_support', 'Bender', ['integr_support', 'yml']],
    emitter.ov_gen_cl,
    0,
    [get_acc_targets(design_params), None, None]
)

