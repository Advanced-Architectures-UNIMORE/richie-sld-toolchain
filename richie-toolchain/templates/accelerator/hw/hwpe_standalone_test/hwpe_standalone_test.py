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

    Title:          HWPE standalone test

    Description:    This class collects the templates which comply with
                    a subsystem of the Accelerator-Rich HeSoC.

                    About the generation flow:

                    - The class object is imported and instantiated by
                    the generation scripts under:

                        ==> 'richie-toolchain/richie-toolchain/generate_*.py'

                    - The object is then passed to a generator, which
                    accomplishes the rendering phase. Generators are
                    defined under:

                        ==> 'richie-toolchain/richie-toolchain/python/generator.py'

    Date:           1.9.2020

    Author:         Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''

#!/usr/bin/env python3

from templates.accelerator.hw.hwpe_standalone_test.hwpe_tb_hw.hwpe_tb_hw import HwpeTbHw
from templates.accelerator.hw.hwpe_standalone_test.vsim_wave.vsim_wave import VsimWave

class HwpeStandaloneTest:
    def __init__(self):
        self.path_common = 'templates/accelerator/hw/common/'

    def HwpeTbHw(self):
        print("\n[py] >> HWPE standalone test ~ HW testbench")
        return HwpeTbHw(
            temp_type = 'templates/accelerator/hw/hwpe_standalone_test/hwpe_tb_hw/',
            temp_top = 'hwpe_tb_hw.sv.mako',
            temp_modules = ['hwpe.sv.mako'],
            path_common = self.path_common
        ).top()

    def VsimWave(self):
        print("\n[py] >> HWPE standalone test ~ QuestaSim waves (HWPE Accelerator)")
        return VsimWave(
            temp_type = 'templates/accelerator/hw/hwpe_standalone_test/vsim_wave/',
            temp_top = 'vsim_wave.tcl.mako',
            temp_modules = ['hwpe_ctrl.tcl.mako',
                            'hwpe_engine.tcl.mako',
                            'hwpe_fsm.tcl.mako',
                            'hwpe_streamer.tcl.mako',
                            'hwpe_top.tcl.mako',
                            'datapath_interface/mdc_dataflow.tcl.mako',
                            'datapath_interface/xil_ap_ctrl_hs.tcl.mako',
                            'datapath_interface/datapath_hls.tcl.mako',
                            'richie_acc_intf.tcl.mako'
            ],
            path_common = self.path_common
        ).top()
