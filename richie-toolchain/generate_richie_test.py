'''
    =====================================================================

    Copyright (C) 2022 ETH Zurich, University of Modena and Reggio Emilia

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

    Title:          Generation of the Richie Tests

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

    Date:           13.1.2022

    Author: 		Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''

#!/usr/bin/env python3

import sys

'''
    Import custom functions
'''
from python.richie.process_design_knobs import PlatformDesignKnobsFormatted
from python.richie.process_design_knobs import print_generation_log

from python.accelerator.process_design_knobs import AcceleratorDesignKnobsFormatted
from python.accelerator.import_design_knobs import import_accelerator_design_knobs

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
from templates.platform.hw.richie_test.richie_test import RichieTest

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
richie_test = RichieTest()

'''
    Instantiate generator
'''
generator = Generator()

'''
    =====================================================================
    Component:      Richie test (Hardware)

    Description:    Generation of test components, such as HW/SW testbench,
                    accelerator runtime calls, Modelsim waves, etc.
    ===================================================================== */
'''

'''
    Generate design components ~ Hardware testbench
    Basic standalone testbench that instantiates the DUT
    (generated accelerator), a RISC-V processor and some
    dummy memories to implement instruction, stack and data
    memories.
'''
generator.render(
    richie_test.RichieTestbenchHw(),
    platform_design_knobs,
    None,
    emitter,
    ['tb', 'richie_tb', ['hw', 'sv']],
    emitter.out_gen_test
)

'''
    =====================================================================
    Component:      Overlay test (Debug support)

    Description:    Generation of test components, such as HW/SW testbench,
                    accelerator runtime calls, Modelsim waves, etc.
    ===================================================================== */
'''

'''
    Generate design components ~ QuestaSim waves
'''
generator.render(
    richie_test.VsimWaveHesoc(),
    platform_design_knobs,
    None,
    emitter,
    ['integr_support', 'vsim_wave_hesoc', ['integr_support', 'vsim_wave']],
    emitter.out_gen_test_waves
)

for cluster_id in range(platform_design_knobs.n_clusters):

    '''
        Generate design components ~ QuestaSim waves
    '''
    generator.render(
        richie_test.VsimWaveCluster(),
        platform_design_knobs,
        None,
        emitter,
        ['integr_support', 'vsim_wave_cluster_' + str(cluster_id), ['integr_support', 'vsim_wave']],
        emitter.out_gen_test_waves,
        cluster_id
    )

    cl_lic_acc_names = platform_design_knobs.list_cl_lic[cluster_id][1]

    for accelerator_id in range(len(cl_lic_acc_names)):

        '''
            Retrieve accelerator specification
        '''

        target_acc = cl_lic_acc_names[accelerator_id]
        accelerator_specs = import_accelerator_design_knobs(target_acc)

        '''
            Format accelerator specification
        '''

        accelerator_design_knobs = AcceleratorDesignKnobsFormatted(accelerator_specs.AcceleratorSpecs)

        '''
            Generate design components ~ QuestaSim waves
        '''

        hwpe_name = 'hwpe_cl' + str(cluster_id) + '_lic' + str(accelerator_id)

        generator.render(
            richie_test.VsimWaveWrapper(accelerator_design_knobs.target, hwpe_name),
            platform_design_knobs,
            accelerator_design_knobs,
            emitter,
            ['integr_support', 'vsim_wave_' + hwpe_name, ['integr_support', 'vsim_wave']],
            emitter.out_gen_test_waves,
            cluster_id,
            [cluster_id, accelerator_id, None]
        )

'''
    Generate design components ~ QuestaSim waves
'''
generator.render(
    richie_test.VsimWaveExperimentView(),
    platform_design_knobs,
    None,
    emitter,
    ['integr_support', 'vsim_wave_experiment_view', ['integr_support', 'vsim_wave']],
    emitter.out_gen_test_waves,
    0,
    [platform_design_knobs, None, None]
)
