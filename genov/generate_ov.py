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

    Title:          Platform IP Wrapper Generation

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
from python.overlay.process_params import get_acc_targets
from python.overlay.process_params import print_ov_log
from python.overlay.generator import gen_ov_comps

'''
    Import emitter
'''
from python.overlay.emitter import EmitOv

'''
    Import design parameters
'''
from dev.ov_dev.specs.ov_specs import ov_specs

'''
    Import overlay templates
'''
from templates.ov_templ.hw.overlay.overlay import Overlay

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
    Print overlay log
'''
print_ov_log(design_params)

'''
    Instantiate emitter item
'''
emitter = EmitOv(ov_specs, dir_out_ov)

'''
    Instantiate overlay template item
'''
overlay = Overlay()

'''
    =====================================================================
    Component:      Hardware

    Description:    Generation of IP wrapper for PULP instance.
    =====================================================================
'''

'''
    Generate design components ~ PULP IP
'''

gen_ov_comps(
    overlay.PulpIp(),
    design_params,
    emitter,
    ['soc', 'pulp_t' + design_params.target_fpga_soc, ['hw', 'v']],
    emitter.ov_gen_ip
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
gen_ov_comps(
    overlay.Bender(),
    design_params,
    emitter,
    ['integr_support', 'Bender', ['integr_support', 'yml']],
    emitter.out_ov
)

gen_ov_comps(
    overlay.BenderLock(),
    design_params,
    emitter,
    ['integr_support', 'Bender', ['integr_support', 'lock']],
    emitter.out_ov,
    [get_acc_targets(design_params), None, None]
)
