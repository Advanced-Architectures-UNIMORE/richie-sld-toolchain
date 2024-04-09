'''
 =====================================================================
 Project:       HWPE system tb class
 Title:         hwpe_system_tb.py
 Description:   This class recalls all the the templates compliant with 
                the generation of a test for HWPE accelerator wrappers.

 Date:          1.9.2020
 ===================================================================== */

 Copyright (C) 2020 University of Modena and Reggio Emilia.

 Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.

'''

#!/usr/bin/env python3

from templates.acc_templ.sw.hwpe_system_tb.archi_hwpe.top.archi_hwpe import archi_hwpe
from templates.acc_templ.sw.hwpe_system_tb.hal_hwpe.top.hal_hwpe import hal_hwpe
from templates.acc_templ.sw.hwpe_system_tb.tb_hwpe.top.tb_hwpe import tb_hwpe

class hwpe_system_tb:
    def __init__(self):
        self.path_common = 'templates/acc_templ/sw/common/'

    def archi_hwpe(self):
        print("\n[py] >> LibHWPE ~ archi")
        return archi_hwpe(
            temp_type = 'templates/acc_templ/sw/hwpe_system_tb/archi_hwpe/',
            temp_top = 'archi_hwpe.template_c',
            temp_modules = ['addressgen_archi.template_c', 
                            'custom_archi.template_c'  , 
                            'tcdm_archi.template_c', 
                            'basic_archi.template_c', 
                            'standard_archi.template_c', 
                            'uloop_archi.template_c'],
            path_common = self.path_common
        ).top()

    def hal_hwpe(self):
        print("\n[py] >> LibHWPE ~ hal")
        return hal_hwpe(
            temp_type = 'templates/acc_templ/sw/hwpe_system_tb/hal_hwpe/',
            temp_top = 'hal_hwpe.template_c',
            temp_modules = [],
            path_common = self.path_common
        ).top()

    def tb_hwpe(self):
        print("\n[py] >> HWPE system test ~ SW testbench")
        return tb_hwpe(
            temp_type = 'templates/acc_templ/sw/hwpe_system_tb/tb_hwpe/',
            temp_top = 'tb_hwpe.template_c',
            temp_modules = ['hwpe/hwpe_addressgen_decl.template_c',
                            'hwpe/hwpe_exec.template_c',
                            'hwpe/hwpe_fsm_decl.template_c',
                            'hwpe/hwpe_progr.template_c',
                            'test/test_params.template_c',
                            'test/test_stims.template_c'],
            path_common = self.path_common
        ).top()


