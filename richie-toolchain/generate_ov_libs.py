'''
    =====================================================================

    Copyright (C) 2022 University of Modena and Reggio Emilia

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

    Title:          Platform Library Generation

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

    Date:           13.7.2022

    Author: 		Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''

#!/usr/bin/env python3

import sys, os

'''
    Import custom functions
'''
from python.overlay.process_params import overlay_params_formatted
from python.wrapper.process_params import wrapper_params_formatted
from python.overlay_libs.generator import gen_ov_libs_comps
from python.wrapper.generator import gen_acc_comps
from python.overlay_libs.process_params import print_ov_libs_log
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
    Import templates
'''
from templates.platforms.sw.libhwpe.libhwpe import LibHwpe
from templates.platforms.sw.libarov_target.libarov_target import LibArov
from templates.platforms.sw.hwpe_structs.hwpe_structs import HwpeStructs
from templates.platforms.sw.soc_structs.soc_structs import SocStructs
from templates.accelerators.sw.hwpe_system_tb.hwpe_system_tb import hwpe_system_tb as hwpe_archi_hal

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
    Print overlay log
'''
print_ov_libs_log(ov_design_params)

'''
    Instantiate emitter item
'''
emitter = EmitOv(ov_specs, dir_out_ov)

'''
    Instantiate templates
'''
libhwpe = LibHwpe()
libarov = LibArov()
hwpe_structs = HwpeStructs()
soc_structs = SocStructs()
hwpe_archi_hal = hwpe_archi_hal()

'''
    =====================================================================
    Component:      Software libraries - LibHWPE

    Description:    Generation of libraries and correlated components
                    to abstract and simplify the control of HWPE-based
                    hardware accelerators.
    ===================================================================== */
'''

for cl_offset in range(ov_design_params.n_clusters):

    cl_lic_acc_names = ov_design_params.list_cl_lic[cl_offset][1]

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
            Create libraries directory
        '''

        lib_path = emitter.ov_gen_libhwpe + '/hwpe_cl' + str(cl_offset) + '_lic' + str(accelerator_id)

        os.mkdir(lib_path)
        os.mkdir(lib_path + '/host')
        os.mkdir(lib_path + '/inc')
        os.mkdir(lib_path + '/pulp')

        '''
            Generate design components ~ LibHWPE (Host APIs)
        '''

        hwpe_name = 'hwpe_cl' + str(cl_offset) + '_lic' + str(accelerator_id)

        gen_ov_libs_comps(
            libhwpe.HwpeClLicHost(hwpe_name),
            ov_design_params,
            acc_design_params,
            emitter,
            ['sw', hwpe_name, ['sw', 'API']],
            lib_path + '/host',
            cl_offset,
            [accelerator_id, None, None]
        )

        gen_ov_libs_comps(
            libhwpe.MakefileHost(hwpe_name),
            ov_design_params,
            acc_design_params,
            emitter,
            ['integr_support', 'Makefile', ['integr_support', 'mk']],
            lib_path + '/host',
            cl_offset,
            [accelerator_id, None, None]
        )

        gen_ov_libs_comps(
            libhwpe.HwpeClLicPulp(hwpe_name),
            ov_design_params,
            acc_design_params,
            emitter,
            ['sw', hwpe_name, ['sw', 'API']],
            lib_path + '/pulp',
            cl_offset,
            [accelerator_id, None, None]
        )

        gen_ov_libs_comps(
            libhwpe.MakefilePulp(hwpe_name),
            ov_design_params,
            acc_design_params,
            emitter,
            ['integr_support', 'Makefile', ['integr_support', 'mk']],
            lib_path + '/pulp',
            cl_offset,
            [accelerator_id, None, None]
        )

        gen_ov_libs_comps(
            libhwpe.HwpeClLicHeader(hwpe_name),
            ov_design_params,
            acc_design_params,
            emitter,
            ['sw', hwpe_name, ['sw', 'header']],
            lib_path + '/inc',
            cl_offset,
            [accelerator_id, None, None]
        )

        '''
            Generate archi and hal for HWPE
        '''

        gen_acc_comps(
            hwpe_archi_hal.archi_hwpe(),
            acc_design_params,
            emitter,
            ['sw', 'archi_hwpe', ['sw', 'archi']],
            lib_path + '/inc',
            [cl_offset, accelerator_id, None]
        )

        gen_acc_comps(
            hwpe_archi_hal.hal_hwpe(),
            acc_design_params,
            emitter,
            ['sw', 'hal_hwpe', ['sw', 'hal']],
            lib_path + '/inc',
            [cl_offset, accelerator_id, None]
        )

'''
    =====================================================================
    Component:      Software libraries - LibAROV

    Description:    Generation of libraries and correlated components
                    to abstract and simplify the accelerator-rich
                    system control.
    ===================================================================== */
'''

'''
    Create libraries directory
'''

lib_path = emitter.ov_gen_libarov_target

os.mkdir(lib_path + '/host')
os.mkdir(lib_path + '/inc')
os.mkdir(lib_path + '/pulp')

'''
    Generate design components ~ LibAROV (Host APIs)
'''

gen_ov_libs_comps(
    libarov.ArovTargetHost(),
    ov_design_params,
    acc_design_params,
    emitter,
    ['sw', 'arov-target', ['sw', 'API']],
    lib_path + '/host'
)

gen_ov_libs_comps(
    libarov.MakefileHost(),
    ov_design_params,
    acc_design_params,
    emitter,
    ['integr_support', 'Makefile', ['integr_support', 'mk']],
    lib_path + '/host'
)

gen_ov_libs_comps(
    libarov.ArovTargetPulp(),
    ov_design_params,
    acc_design_params,
    emitter,
    ['sw', 'arov-target', ['sw', 'API']],
    lib_path + '/pulp',
    0,
    [ov_design_params.list_cl_lic, ov_design_params.list_cl_hci, None]
)

gen_ov_libs_comps(
    libarov.MakefilePulp(),
    ov_design_params,
    acc_design_params,
    emitter,
    ['integr_support', 'Makefile', ['integr_support', 'mk']],
    lib_path + '/pulp'
)

gen_ov_libs_comps(
    libarov.ArovTargetHeader(),
    ov_design_params,
    acc_design_params,
    emitter,
    ['sw', 'arov-target', ['sw', 'header']],
    lib_path + '/inc',
    0,
    [ov_design_params.list_cl_lic, ov_design_params.list_cl_hci, None]
)

'''
    =====================================================================
    Component:      Software libraries - HWPE structs

    Description:    Generation of C structures for HWPE wrappers.
    ===================================================================== */
'''

'''
    Generate design components ~ Application-specific HWPE structs
'''

list_acc_types = []
list_acc_integrated = []

for cl_offset in range(ov_design_params.n_clusters):

    cl_lic_acc_names = ov_design_params.list_cl_lic[cl_offset][1]

    for accelerator_id in range(len(cl_lic_acc_names)):

        '''
            Retrieve wrapper design parameters
        '''

        target_acc = cl_lic_acc_names[accelerator_id]

        list_acc_integrated.append(target_acc)

        if target_acc not in list_acc_types:

            list_acc_types.append(target_acc)

            acc_specs = import_acc_dev_module(target_acc)

            '''
                Format wrapper design parameters
            '''

            acc_design_params = wrapper_params_formatted(acc_specs.acc_specs)

            '''
                Generate design components ~ LibHWPE (Host APIs)
            '''

            hwpe_name = acc_design_params.target

            gen_ov_libs_comps(
                hwpe_structs.DefStructHwpe(hwpe_name),
                ov_design_params,
                acc_design_params,
                emitter,
                ['sw', "def_struct_hwpe_" + hwpe_name, ['sw', 'header']],
                emitter.ov_gen_hwpe_structs,
                cl_offset,
                [accelerator_id, None, None]
            )

'''
    Generate design components ~ Common HWPE structs
'''

gen_ov_libs_comps(
    hwpe_structs.DefStructCommon(),
    ov_design_params,
    acc_design_params,
    emitter,
    ['sw', 'def_struct_hwpe_common', ['sw', 'header']],
    emitter.ov_gen_hwpe_structs,
    0,
    [list_acc_types, list_acc_integrated, None]
)

'''
    =====================================================================
    Component:      Software libraries - SoC structs

    Description:    Generation of C structures for Soc.
    ===================================================================== */
'''

'''
    Generate design components ~ Performance evaluation
'''

gen_ov_libs_comps(
    soc_structs.DefStructPerfEval(),
    ov_design_params,
    acc_design_params,
    emitter,
    ['sw', 'def_struct_soc_perf_eval', ['sw', 'header']],
    emitter.ov_gen_soc_structs
)
