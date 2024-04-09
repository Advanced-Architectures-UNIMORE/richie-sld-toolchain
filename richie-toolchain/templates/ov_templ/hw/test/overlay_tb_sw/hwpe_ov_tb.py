########################################################
## Gianluca Bellocchi <gianluca.bellocchi@unimore.it> ##
########################################################

#!/usr/bin/env python3

# Templates
from templates.ov_templ.sw.hwpe_ov_tb.archi_hwpe.top.archi_hwpe import archi_hwpe
from templates.ov_templ.sw.hwpe_ov_tb.hal_hwpe.top.hal_hwpe import hal_hwpe
from templates.ov_templ.sw.hwpe_ov_tb.tb_hwpe.top.tb_hwpe import tb_hwpe

# HWPE wrapper - Software components for system-level testbench
class hwpe_ov_tb:
    def __init__(self):
        self.path_common = 'templates/ov_templ/sw/common/'

    def archi_hwpe(self):
        print("\n[py] >> HWPE system-level testbench ~ archi")
        return archi_hwpe(
            temp_type = 'templates/ov_templ/sw/hwpe_ov_tb/archi_hwpe/',
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
        print("\n[py] >> HWPE system-level testbench ~ hal")
        return hal_hwpe(
            temp_type = 'templates/ov_templ/sw/hwpe_ov_tb/hal_hwpe/',
            temp_top = 'hal_hwpe.template_c',
            temp_modules = [],
            path_common = self.path_common
        ).top()

    def tb_hwpe(self):
        print("\n[py] >> HWPE system-level testbench ~ SW testbench")
        return tb_hwpe(
            temp_type = 'templates/ov_templ/sw/hwpe_ov_tb/tb_hwpe/',
            temp_top = 'tb_hwpe.template_c',
            temp_modules = ['hwpe/hwpe_addressgen_decl.template_c',
                            'hwpe/hwpe_exec.template_c',
                            'hwpe/hwpe_fsm_decl.template_c',
                            'hwpe/hwpe_progr.template_c',
                            'test/test_params.template_c',
                            'test/test_stims.template_c'],
            path_common = self.path_common
        ).top()


