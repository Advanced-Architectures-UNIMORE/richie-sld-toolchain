'''
    =====================================================================

    Copyright (C) 2021 University of Modena and Reggio Emilia

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

# Templates
from templates.acc_templ.hw.hwpe_standalone_tb.tb_hwpe.top.tb_hwpe import tb_hwpe

# HWPE wrapper - Hardware components for standalone testbench
class hwpe_standalone_tb:
    def __init__(self):
        self.path_common = 'templates/acc_templ/hw/common/'

    def tb_hwpe(self):
        print("\n[py] >> HWPE standalone test ~ HW testbench")
        return tb_hwpe(
            temp_type = 'templates/acc_templ/hw/hwpe_standalone_tb/tb_hwpe/',
            temp_top = 'tb_hwpe.template_sv',
            temp_modules = ['hwpe.template_sv'],
            path_common = self.path_common
        ).top()