'''
 =====================================================================
 Project:      Accelerator-Rich Overlay Generator
 Title:        generate_ov_libs.py
 Description:  Generation of accelerator-rich overlay libraries.

 Date:         13.7.2022
 ===================================================================== */

 Copyright (C) 2022 University of Modena and Reggio Emilia.

 Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.

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
from templates.ov_templ.sw.libhwpe.libhwpe import LibHwpe
from templates.ov_templ.sw.libarov_target.libarov_target import LibArov
from templates.acc_templ.sw.hwpe_system_tb.hwpe_system_tb import hwpe_system_tb as hwpe_archi_hal

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
            [accelerator_id, None, None]
        )

        gen_acc_comps(
            hwpe_archi_hal.hal_hwpe(),
            acc_design_params,
            emitter,
            ['sw', 'hal_hwpe', ['sw', 'hal']],
            lib_path + '/inc',
            [accelerator_id, None, None]
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
    ['sw', 'arov_target', ['sw', 'API']],
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
    ['sw', 'arov_target', ['sw', 'API']],
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
    ['sw', 'arov_target', ['sw', 'header']],
    lib_path + '/inc',
    0,
    [ov_design_params.list_cl_lic, ov_design_params.list_cl_hci, None]
)
