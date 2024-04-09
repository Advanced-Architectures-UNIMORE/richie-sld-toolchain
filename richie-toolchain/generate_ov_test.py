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

    Title:          Platform Tests Generation

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

    Date:           13.1.2022

    Author: 		Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''

#!/usr/bin/env python3

import sys

'''
    Import custom functions
'''
from python.overlay.process_params import overlay_params_formatted
from python.wrapper.process_params import wrapper_params_formatted
from python.overlay.process_params import print_ov_test_log
from python.overlay_test.generator import gen_ov_test_comps
from python.wrapper.generator import gen_acc_comps
from python.wrapper.import_params import import_acc_dev_module

'''
    Import emitter
'''
from python.overlay.emitter import EmitOv

'''
    Import design parameters
'''
from dev.ov_dev.specs.ov_specs import ov_specs

'''
    Import overlay test templates
'''
from templates.platforms.hw.test.test import Test

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
ov_design_params = overlay_params_formatted(ov_specs)

'''
    Print overlay test log
'''
print_ov_test_log(ov_design_params)

'''
    Instantiate emitter item
'''
emitter = EmitOv(ov_specs, dir_out_ov)

'''
    Instantiate overlay template item
'''
test = Test()

'''
    =====================================================================
    Component:      Overlay test (Hardware)

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
gen_ov_test_comps(
    test.OverlayTestbenchHw(),
    ov_design_params,
    emitter,
    ['tb', 'overlay_tb', ['hw', 'sv']],
    emitter.ov_gen_test
)

'''
    =====================================================================
    Component:      Overlay test (Software)

    Description:    Generation of test components, such as HW/SW testbench,
                    accelerator runtime calls, Modelsim waves, etc.
    ===================================================================== */
'''

'''
    Generate design components ~ Archi
    Retrieve memory-mapped hardware accelerator registers.
'''
# gen_comps(
#     hwpe_ov_tb_sw.archi_hwpe(),
#     ['sw', 'archi_hwpe', ['sw', 'archi']],
#     emitter.ov_gen_test_hwpe_lib
# )

'''
    Generate design components ~ Hardware abstraction layer (HAL)
    Retrieve Hardware Abstraction Layer with functions that permit
    to create an interaction between the RISC-V processor and the
    hardware accelerator.
'''
# gen_comps(
#     hwpe_ov_tb_sw.hal_hwpe(),
#     ['sw', 'hal_hwpe', ['sw', 'hal']],
#     emitter.ov_gen_test_hwpe_lib
# )

'''
    Generate design components ~ Software testbench
    Retrieve software testbench to assess HWPE functionality. This
    is a pure baremetal test running on the riscv proxy core comprised
    in the overlay system. This tb can be used as a starting point for
    additional platform testing.
'''
# gen_comps(
#     hwpe_ov_tb_sw.tb_hwpe(),
#     ['sw', 'tb_hwpe', ['sw', 'tb']],
#     emitter.ov_gen_test_sw
# )

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
gen_ov_test_comps(
    test.VsimWaveSoc(),
    ov_design_params,
    emitter,
    ['integr_support', 'vsim_wave_soc', ['integr_support', 'vsim_wave']],
    emitter.ov_gen_test_waves
)

for cluster_id in range(ov_design_params.n_clusters):

    '''
        Generate design components ~ QuestaSim waves
    '''
    gen_ov_test_comps(
        test.VsimWaveCluster(),
        ov_design_params,
        emitter,
        ['integr_support', 'vsim_wave_cluster_' + str(cluster_id), ['integr_support', 'vsim_wave']],
        emitter.ov_gen_test_waves,
        cluster_id
    )

    cl_lic_acc_names = ov_design_params.list_cl_lic[cluster_id][1]

    for accelerator_id in range(len(cl_lic_acc_names)):

        '''
            Retrieve wrapper design parameters
        '''

        target_acc = cl_lic_acc_names[accelerator_id]
        acc_specs = import_acc_dev_module(target_acc)

        '''
            Format wrapper design parameters
        '''

        acc_design_params = wrapper_params_formatted(acc_specs.acc_specs)

        '''
            Generate design components ~ QuestaSim waves
        '''

        hwpe_name = 'hwpe_cl' + str(cluster_id) + '_lic' + str(accelerator_id)

        # gen_acc_comps(
        #     test.VsimWaveWrapper(),
        #     acc_design_params,
        #     emitter,
        #     ['integr_support', 'vsim_wave_' + hwpe_name, ['integr_support', 'vsim_wave']],
        #     emitter.ov_gen_test_waves,
        #     [cluster_id, accelerator_id, None]
        # )

'''
    Generate design components ~ QuestaSim waves
'''
gen_ov_test_comps(
    test.VsimWaveExperimentView(),
    ov_design_params,
    emitter,
    ['integr_support', 'vsim_wave_experiment_view', ['integr_support', 'vsim_wave']],
    emitter.ov_gen_test_waves,
    0,
    [ov_design_params, None, None]
)
