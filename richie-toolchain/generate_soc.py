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

    Title:          SoC Generation

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
from python.soc.process_params import print_soc_log
from python.soc.generator import gen_soc_comps

'''
    Import emitter
'''
from python.overlay.emitter import EmitOv

'''
    Import design parameters
'''
from dev.ov_dev.specs.ov_specs import ov_specs

'''
    Import SoC templates
'''
from templates.ov_templ.hw.soc.soc import Soc

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
    Print SoC log
'''
print_soc_log(design_params)

'''
    Instantiate emitter item
'''
emitter = EmitOv(ov_specs, dir_out_ov)

'''
    Instantiate SoC template item
'''
soc = Soc()

'''
    =====================================================================
    Component:      System-on-Chip - Packages

    Description:    Generation of hardware components for SoC.
    ===================================================================== */
'''

'''
    Generate design components ~ SoC package
'''
gen_soc_comps(
    soc.SocCfgPkg(),
    design_params,
    emitter,
    ['soc', 'soc_cfg_pkg', ['hw', 'sv']],
    emitter.ov_gen_soc_pkg
)

'''
    =====================================================================
    Component:      System-on-Chip - Hardware

    Description:    Generation of hardware components for SoC.
    ===================================================================== */
'''

'''
    Generate design components ~ HERO AXI mailbox
'''
gen_soc_comps(
    soc.HeroAxiMailbox(),
    design_params,
    emitter,
    ['soc', 'hero_axi_mailbox', ['hw', 'sv']],
    emitter.ov_gen_soc_rtl
)

'''
    Generate design components ~ L2 memory
'''
gen_soc_comps(
    soc.L2Mem(),
    design_params,
    emitter,
    ['soc', 'l2_mem', ['hw', 'sv']],
    emitter.ov_gen_soc_rtl
)

'''
    Generate design components ~ PULP
'''
gen_soc_comps(
    soc.Pulp(),
    design_params,
    emitter,
    ['soc', 'pulp', ['hw', 'sv']],
    emitter.ov_gen_soc_rtl
)

'''
    Generate design components ~ SoC bus
'''
gen_soc_comps(
    soc.SocBus(),
    design_params,
    emitter,
    ['soc', 'soc_bus', ['hw', 'sv']],
    emitter.ov_gen_soc_rtl
)

'''
    Generate design components ~ SoC control registers
'''
gen_soc_comps(
    soc.SocCtrlRegs(),
    design_params,
    emitter,
    ['soc', 'soc_ctrl_regs', ['hw', 'sv']],
    emitter.ov_gen_soc_rtl
)

'''
    Generate design components ~ SoC peripherals
'''
gen_soc_comps(
    soc.SocPeripherals(),
    design_params,
    emitter,
    ['soc', 'soc_peripherals', ['hw', 'sv']],
    emitter.ov_gen_soc_rtl
)

'''
    =====================================================================
    Component:      System-on-Chip - Hardware (OOC)

    Description:    Generation of hardware OOC components for SoC.
    ===================================================================== */
'''

'''
    Generate design components ~ DMA wrapper OOC
'''
gen_soc_comps(
    soc.DmacWrapOOC(),
    design_params,
    emitter,
    ['soc', 'dmac_wrap_ooc', ['hw', 'sv']],
    emitter.ov_gen_soc_ooc
)

'''
    Generate design components ~ PULP OOC
'''
gen_soc_comps(
    soc.PulpOoc(),
    design_params,
    emitter,
    ['soc', 'pulp_ooc', ['hw', 'sv']],
    emitter.ov_gen_soc_ooc
)

for cl_offset in range(design_params.n_clusters):

    '''
        Generate design components ~ PULP cluster OOC
    '''
    gen_soc_comps(
        soc.PulpClusterOOC(),
        design_params,
        emitter,
        ['cl', str(cl_offset) + '_ooc', ['hw', 'sv']],
        emitter.ov_gen_soc_ooc,
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
gen_soc_comps(
    soc.Bender(),
    design_params,
    emitter,
    ['integr_support', 'Bender', ['integr_support', 'yml']],
    emitter.ov_gen_soc
)
