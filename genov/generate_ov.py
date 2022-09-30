'''
 =====================================================================
 Project:      Accelerator-Rich Overlay Generator
 Title:        generate_ov.py
 Description:  Generation of accelerator-rich overlay components.

 Date:         23.11.2021
 ===================================================================== */

 Copyright (C) 2021 University of Modena and Reggio Emilia.

 Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.

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