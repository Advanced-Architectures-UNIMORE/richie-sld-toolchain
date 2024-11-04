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

    Title:          Generation of the Platform Software Library

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

    Date:           13.7.2022

    Author: 		Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''

#!/usr/bin/env python3

import sys, os

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
from templates.platform.sw.libhwpe.libhwpe import LibHwpe
from templates.platform.sw.librichie_target.librichie_target import LibRichie
from templates.platform.sw.hwpe_structs.hwpe_structs import HwpeStructs
from templates.platform.sw.hesoc_structs.hesoc_structs import HesocStructs
from templates.accelerator.sw.hwpe_system_hal.hwpe_system_hal import HwpeSystemHal

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
    Print generation log
'''
logger.richie_libs()

'''
    Instantiate emitter
'''
emitter = Emitter(platform_specs, None, dir_out_richie, None)

'''
    Instantiate templates
'''
libhwpe = LibHwpe()
librichie = LibRichie()
hwpe_structs = HwpeStructs()
hesoc_structs = HesocStructs()
hwpe_system_hal = HwpeSystemHal()

'''
    Instantiate generator
'''
generator = Generator()

'''
    =====================================================================
    Component:      Software libraries - LibRICHIE

    Description:    Generation of libraries and correlated components
                    to abstract and simplify the accelerator-rich
                    system control.
    ===================================================================== */
'''

'''
    Create libraries directory
'''

platform_librichie_path = emitter.out_platform_librichie_target

os.mkdir(platform_librichie_path + '/host')
os.mkdir(platform_librichie_path + '/inc')
os.mkdir(platform_librichie_path + '/pulp')

'''
    Generate design components ~ LibRICHIE (Host APIs)
'''

generator.render(
    librichie.RichieTargetHost(),
    platform_design_knobs,
    None,
    emitter,
    ['sw', 'richie-target', ['sw', 'API']],
    platform_librichie_path + '/host'
)

generator.render(
    librichie.MakefileHost(),
    platform_design_knobs,
    None,
    emitter,
    ['integr_support', 'Makefile', ['integr_support', 'mk']],
    platform_librichie_path + '/host'
)

generator.render(
    librichie.RichieTargetPulp(),
    platform_design_knobs,
    None,
    emitter,
    ['sw', 'richie-target', ['sw', 'API']],
    platform_librichie_path + '/pulp',
    0,
    [platform_design_knobs.list_cl_lic, platform_design_knobs.list_cl_hci, None]
)

generator.render(
    librichie.MakefilePulp(),
    platform_design_knobs,
    None,
    emitter,
    ['integr_support', 'Makefile', ['integr_support', 'mk']],
    platform_librichie_path + '/pulp'
)

generator.render(
    librichie.RichieTargetHeader(),
    platform_design_knobs,
    None,
    emitter,
    ['sw', 'richie-target', ['sw', 'header']],
    platform_librichie_path + '/inc',
    0,
    [platform_design_knobs.list_cl_lic, platform_design_knobs.list_cl_hci, None]
)

'''
    =====================================================================
    Component:      Software libraries - LibHWPE

    Description:    Generation of libraries and correlated components
                    to abstract and simplify the control of HWPE-based
                    hardware accelerators.
    ===================================================================== */
'''

for cl_offset in range(platform_design_knobs.n_clusters):

    cl_lic_acc_names = platform_design_knobs.list_cl_lic[cl_offset][1]

    for accelerator_id in range(len(cl_lic_acc_names)):

        '''
            Retrieve accelerator specification
        '''

        target_acc = cl_lic_acc_names[accelerator_id]
        accelerator_design_knobs_raw_module = format.import_accelerator_design_knobs(target_acc)
        accelerator_design_knobs_raw = accelerator_design_knobs_raw_module.AcceleratorSpecs

        '''
            Format accelerator specification
        '''

        accelerator_design_knobs = format.accelerator(accelerator_design_knobs_raw)

        '''
            Create libraries directory
        '''

        platform_libhwpe_path = emitter.out_platform_libhwpe + '/hwpe_cl' + str(cl_offset) + '_lic' + str(accelerator_id)

        os.mkdir(platform_libhwpe_path)
        os.mkdir(platform_libhwpe_path + '/host')
        os.mkdir(platform_libhwpe_path + '/inc')
        os.mkdir(platform_libhwpe_path + '/pulp')

        '''
            Generate design components ~ LibHWPE (Host APIs)
        '''

        hwpe_name = 'hwpe_cl' + str(cl_offset) + '_lic' + str(accelerator_id)

        generator.render(
            libhwpe.HwpeClLicHost(hwpe_name),
            platform_design_knobs,
            accelerator_design_knobs,
            emitter,
            ['sw', hwpe_name, ['sw', 'API']],
            platform_libhwpe_path + '/host',
            cl_offset,
            [accelerator_id, None, None]
        )

        generator.render(
            libhwpe.MakefileHost(hwpe_name),
            platform_design_knobs,
            accelerator_design_knobs,
            emitter,
            ['integr_support', 'Makefile', ['integr_support', 'mk']],
            platform_libhwpe_path + '/host',
            cl_offset,
            [accelerator_id, None, None]
        )

        generator.render(
            libhwpe.HwpeClLicPulp(hwpe_name),
            platform_design_knobs,
            accelerator_design_knobs,
            emitter,
            ['sw', hwpe_name, ['sw', 'API']],
            platform_libhwpe_path + '/pulp',
            cl_offset,
            [accelerator_id, None, None]
        )

        generator.render(
            libhwpe.MakefilePulp(hwpe_name),
            platform_design_knobs,
            accelerator_design_knobs,
            emitter,
            ['integr_support', 'Makefile', ['integr_support', 'mk']],
            platform_libhwpe_path + '/pulp',
            cl_offset,
            [accelerator_id, None, None]
        )

        generator.render(
            libhwpe.HwpeClLicHeader(hwpe_name),
            platform_design_knobs,
            accelerator_design_knobs,
            emitter,
            ['sw', hwpe_name, ['sw', 'header']],
            platform_libhwpe_path + '/inc',
            cl_offset,
            [accelerator_id, None, None]
        )

        '''
            Generate archi and hal for HWPE
        '''

        generator.render(
            hwpe_system_hal.ArchiHwpe(),
            None,
            accelerator_design_knobs,
            emitter,
            ['sw', 'archi_hwpe', ['sw', 'archi']],
            platform_libhwpe_path + '/inc',
            cl_offset,
            [cl_offset, accelerator_id, None]
        )

        generator.render(
            hwpe_system_hal.HalHwpe(),
            None,
            accelerator_design_knobs,
            emitter,
            ['sw', 'hal_hwpe', ['sw', 'hal']],
            platform_libhwpe_path + '/inc',
            cl_offset,
            [cl_offset, accelerator_id, None]
        )

'''
    =====================================================================
    Component:      Software libraries - HWPE structs

    Description:    Generation of C structures for HWPE-based accelerator
                    interfaces.
    ===================================================================== */
'''

'''
    Generate design components ~ Application-specific HWPE structs
'''

list_acc_types = []
list_acc_integrated = []

for cl_offset in range(platform_design_knobs.n_clusters):

    cl_lic_acc_names = platform_design_knobs.list_cl_lic[cl_offset][1]

    for accelerator_id in range(len(cl_lic_acc_names)):

        '''
            Retrieve accelerator specification
        '''

        target_acc = cl_lic_acc_names[accelerator_id]

        list_acc_integrated.append(target_acc)

        if target_acc not in list_acc_types:

            list_acc_types.append(target_acc)

            '''
                Retrieve accelerator specification
            '''

            target_acc = cl_lic_acc_names[accelerator_id]
            accelerator_design_knobs_raw_module = format.import_accelerator_design_knobs(target_acc)
            accelerator_design_knobs_raw = accelerator_design_knobs_raw_module.AcceleratorSpecs

            '''
                Format accelerator specification
            '''

            accelerator_design_knobs = format.accelerator(accelerator_design_knobs_raw)

            '''
                Generate design components ~ LibHWPE (Host APIs)
            '''

            hwpe_name = accelerator_design_knobs.target

            generator.render(
                hwpe_structs.DefStructHwpe(hwpe_name),
                platform_design_knobs,
                accelerator_design_knobs,
                emitter,
                ['sw', "def_struct_hwpe_" + hwpe_name, ['sw', 'header']],
                emitter.out_platform_hwpe_structs,
                cl_offset,
                [accelerator_id, None, None]
            )

'''
    Generate design components ~ Common HWPE structs
'''

generator.render(
    hwpe_structs.DefStructCommon(),
    platform_design_knobs,
    accelerator_design_knobs,
    emitter,
    ['sw', 'def_struct_hwpe_common', ['sw', 'header']],
    emitter.out_platform_hwpe_structs,
    0,
    [list_acc_types, list_acc_integrated, None]
)

'''
    =======================================================================
    Component:      Software libraries - HeSoC structs

    Description:    Generation of C structures for Soc.
    ======================================================================= */
'''

'''
    Generate design components ~ Performance evaluation
'''

generator.render(
    hesoc_structs.DefStructPerfEval(),
    platform_design_knobs,
    accelerator_design_knobs,
    emitter,
    ['sw', 'def_struct_hesoc_perf_eval', ['sw', 'header']],
    emitter.out_platform_hesoc_structs
)
