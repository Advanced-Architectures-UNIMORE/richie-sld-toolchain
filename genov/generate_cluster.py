'''
 =====================================================================
 Project:      Accelerator-Rich Overlay Generator
 Title:        generate_cluster.py
 Description:  Generation of accelerator-rich cluster components.

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

    