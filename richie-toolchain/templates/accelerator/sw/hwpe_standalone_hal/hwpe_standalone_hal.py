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

                        ==> 'richie-toolchain/richie-toolchain/python/<component-libraries>/generator.py'

    Date:           1.9.2020

    Author:         Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''

#!/usr/bin/env python3

from templates.accelerator.sw.hwpe_standalone_hal.archi_hwpe.archi_hwpe import ArchiHwpe
from templates.accelerator.sw.hwpe_standalone_hal.hal_hwpe.hal_hwpe import HalHwpe
from templates.accelerator.sw.hwpe_standalone_hal.hwpe_tb_sw.hwpe_tb_sw import HwpeTbSw

class HwpeStandaloneHal:
    def __init__(self):
        self.path_common = 'templates/accelerator/sw/common/'

    def ArchiHwpe(self):
        print("\n[py] >> HWPE standalone test ~ Hardware Abstration Layer (archi)")
        return ArchiHwpe(
            temp_type = 'templates/accelerator/sw/hwpe_standalone_hal/archi_hwpe/',
            temp_top = 'archi_hwpe.c.mako',
            temp_modules = ['addressgen_archi.c.mako',
                            'custom_archi.c.mako'  ,
                            'tcdm_archi.c.mako',
                            'basic_archi.c.mako',
                            'standard_archi.c.mako',
                            'uloop_archi.c.mako'],
            path_common = self.path_common
        ).top()

    def HalHwpe(self):
        print("\n[py] >> HWPE standalone test ~ Hardware Abstration Layer (hal)")
        return HalHwpe(
            temp_type = 'templates/accelerator/sw/hwpe_standalone_hal/hal_hwpe/',
            temp_top = 'hal_hwpe.c.mako',
            temp_modules = [],
            path_common = self.path_common
        ).top()

    def HwpeTbSw(self):
        print("\n[py] >> HWPE standalone test ~ Software testbench")
        return HwpeTbSw(
            temp_type = 'templates/accelerator/sw/hwpe_standalone_hal/hwpe_tb_sw/',
            temp_top = 'hwpe_tb_sw.c.mako',
            temp_modules = ['hwpe/hwpe_addressgen_decl.c.mako',
                            'hwpe/hwpe_exec.c.mako',
                            'hwpe/hwpe_fsm_decl.c.mako',
                            'hwpe/hwpe_progr.c.mako',
                            'test/test_params.c.mako',
                            'test/test_stims.c.mako',
                            'test/test_check.c.mako'],
            path_common = self.path_common
        ).top()


