'''
    =====================================================================

    Copyright (C) 2020 University of Modena and Reggio Emilia

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

    Title:          HWPE standalone testbench

    Description:    This class collects the templates which comply with 
                    a subsystem of the Accelerator-Rich HeSoC.

                    About the generation flow:

                    - The class object is imported and instantiated by 
                    the generation scripts under:

                        ==> 'richie-toolchain/richie-toolchain/generate_*.py'

                    - The object is then passed to a generator, which 
                    accomplishes the rendering phase. Generators are
                    defined under:

                        ==> 'richie-toolchain/richie-toolchain/python/SOMETHING-TO-RENDER/generator.py'

    Date:           1.9.2020

    Author:         Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''

#!/usr/bin/env python3

from templates.acc_templ.sw.hwpe_standalone_tb.archi_hwpe.top.archi_hwpe import archi_hwpe
from templates.acc_templ.sw.hwpe_standalone_tb.hal_hwpe.top.hal_hwpe import hal_hwpe
from templates.acc_templ.sw.hwpe_standalone_tb.tb_hwpe.top.tb_hwpe import tb_hwpe

class hwpe_standalone_tb:
    def __init__(self):
        self.path_common = 'templates/acc_templ/sw/common/'

    def archi_hwpe(self):
        print("\n[py] >> HWPE standalone test ~ archi")
        return archi_hwpe(
            temp_type = 'templates/acc_templ/sw/hwpe_standalone_tb/archi_hwpe/',
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
        print("\n[py] >> HWPE standalone test ~ hal")
        return hal_hwpe(
            temp_type = 'templates/acc_templ/sw/hwpe_standalone_tb/hal_hwpe/',
            temp_top = 'hal_hwpe.template_c',
            temp_modules = [],
            path_common = self.path_common
        ).top()

    def tb_hwpe(self):
        print("\n[py] >> HWPE standalone test ~ SW testbench")
        return tb_hwpe(
            temp_type = 'templates/acc_templ/sw/hwpe_standalone_tb/tb_hwpe/',
            temp_top = 'tb_hwpe.template_c',
            temp_modules = ['hwpe/hwpe_addressgen_decl.template_c',
                            'hwpe/hwpe_exec.template_c',
                            'hwpe/hwpe_fsm_decl.template_c',
                            'hwpe/hwpe_progr.template_c',
                            'test/test_params.template_c',
                            'test/test_stims.template_c',
                            'test/test_check.template_c'],
            path_common = self.path_common
        ).top()


