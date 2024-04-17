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

    Title:          Generation of the Accelerator-Rich HeSoC Subsystem

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
from python.hesoc.process_design_knobs import print_generation_log

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
from templates.platform.hw.hesoc.hesoc import Hesoc

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
    Print generation log
'''
print_generation_log(platform_design_knobs)

'''
    Instantiate emitter
'''
emitter = EmitRichie(platform_specs, dir_out_richie)

'''
    Instantiate templates
'''
hesoc = Hesoc()

'''
    Instantiate generator
'''
generator = Generator()

'''
    =====================================================================
    Component:      Heterogeneous System-on-Chip - Packages

    Description:    Generation of hardware components for the Richie HeSoC.
    ===================================================================== */
'''

'''
    Generate design components ~ HeSoC package
'''
generator.render(
    hesoc.HesocCfgPkg(),
    platform_design_knobs,
    None,
    emitter,
    ['hesoc', 'hesoc_cfg_pkg', ['hw', 'sv']],
    emitter.out_gen_hesoc_pkg
)

'''
    =====================================================================
    Component:      Heterogeneous System-on-Chip - Hardware

    Description:    Generation of hardware components for HeSoC.
    ===================================================================== */
'''

'''
    Generate design components ~ HERO AXI mailbox
'''
generator.render(
    hesoc.HeroAxiMailbox(),
    platform_design_knobs,
    None,
    emitter,
    ['hesoc', 'hero_axi_mailbox', ['hw', 'sv']],
    emitter.out_gen_hesoc_rtl
)

'''
    Generate design components ~ L2 memory
'''
generator.render(
    hesoc.L2Mem(),
    platform_design_knobs,
    None,
    emitter,
    ['hesoc', 'l2_mem', ['hw', 'sv']],
    emitter.out_gen_hesoc_rtl
)

'''
    Generate design components ~ PULP
'''
generator.render(
    hesoc.Pulp(),
    platform_design_knobs,
    None,
    emitter,
    ['hesoc', 'pulp', ['hw', 'sv']],
    emitter.out_gen_hesoc_rtl
)

'''
    Generate design components ~ HeSoC interconnect (system-level)
'''
generator.render(
    hesoc.HesocInterconnect(),
    platform_design_knobs,
    None,
    emitter,
    ['hesoc', 'hesoc_interconnect', ['hw', 'sv']],
    emitter.out_gen_hesoc_rtl
)

'''
    Generate design components ~ HeSoC control registers
'''
generator.render(
    hesoc.HesocCtrlRegs(),
    platform_design_knobs,
    None,
    emitter,
    ['hesoc', 'hesoc_ctrl_regs', ['hw', 'sv']],
    emitter.out_gen_hesoc_rtl
)

'''
    Generate design components ~ HeSoC peripherals
'''
generator.render(
    hesoc.HesocPeripherals(),
    platform_design_knobs,
    None,
    emitter,
    ['hesoc', 'hesoc_peripherals', ['hw', 'sv']],
    emitter.out_gen_hesoc_rtl
)

'''
    =====================================================================
    Component:      Heterogeneous System-on-Chip - Hardware (OOC)

    Description:    Generation of hardware OOC components for HeSoC.
    ===================================================================== */
'''

'''
    Generate design components ~ DMA wrapper OOC
'''
generator.render(
    hesoc.DmacWrapOOC(),
    platform_design_knobs,
    None,
    emitter,
    ['hesoc', 'dmac_wrap_ooc', ['hw', 'sv']],
    emitter.out_gen_hesoc_ooc
)

'''
    Generate design components ~ PULP OOC
'''
generator.render(
    hesoc.PulpOoc(),
    platform_design_knobs,
    None,
    emitter,
    ['hesoc', 'pulp_ooc', ['hw', 'sv']],
    emitter.out_gen_hesoc_ooc
)

for cl_offset in range(platform_design_knobs.n_clusters):

    '''
        Generate design components ~ PULP cluster OOC
    '''
    generator.render(
        hesoc.PulpClusterOOC(),
        platform_design_knobs,
        None,
        emitter,
        ['cl', str(cl_offset) + '_ooc', ['hw', 'sv']],
        emitter.out_gen_hesoc_ooc,
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
    hesoc.Bender(),
    platform_design_knobs,
    None,
    emitter,
    ['integr_support', 'Bender', ['integr_support', 'yml']],
    emitter.out_gen_hesoc
)
