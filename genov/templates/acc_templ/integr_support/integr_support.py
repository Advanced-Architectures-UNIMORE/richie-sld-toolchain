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

    Project:        GenOv

    Title:          Integration support for Accelerator Interface

    Description:    This class collects the templates which comply with 
                    a subsystem of the accelerator-rich SoC.

                    About the generation flow:

                    - The class object is imported and instantiated by 
                    the generation scripts under:

                        ==> 'genov/genov/generate_*.py'

                    - The object is then passed to a generator, which 
                    accomplishes the rendering phase. Generators are
                    defined under:

                        ==> 'genov/genov/python/SOMETHING-TO-RENDER/generator.py'

    Date:           29.12.2021

    Author:         Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''

#!/usr/bin/env python3

from templates.acc_templ.integr_support.bender.top.bender import bender
from templates.acc_templ.integr_support.ips_list.top.ips_list import ips_list
from templates.acc_templ.integr_support.src_files.top.src_files import src_files

class integr_support:
    def __init__(self):
        self.path_common = ''

    def bender(self):
        print("\n[py] >> Integration support ~ bender")
        return bender(
            temp_type = 'templates/acc_templ/integr_support/bender/',
            temp_top = 'bender.template_yml',
            temp_modules = [],
            path_common = self.path_common
        ).top()

    def src_files(self):
        print("\n[py] >> Integration support ~ src_files")
        return src_files(
            temp_type = 'templates/acc_templ/integr_support/src_files/',
            temp_top = 'src_files.template_yml',
            temp_modules = [],
            path_common = self.path_common
        ).top()

    def ips_list(self):
        print("\n[py] >> Integration support ~ ips_list")
        return ips_list(
            temp_type = 'templates/acc_templ/integr_support/ips_list/',
            temp_top = 'ips_list.template_yml',
            temp_modules = [],
            path_common = self.path_common
        ).top()

    def vsim_wave(self):
        print("\n[py] >> Integration support ~ vsim_wave")
        return ips_list(
            temp_type = 'templates/acc_templ/integr_support/vsim_wave/',
            temp_top = 'vsim_wave.template_wave_do',
            temp_modules = ['hwpe_ctrl.template_wave_do', 
                            'hwpe_engine.template_wave_do', 
                            'hwpe_fsm.template_wave_do',
                            'hwpe_streamer.template_wave_do',
                            'hwpe_top.template_wave_do',
                            'kernel_interface/mdc_dataflow.template_wave_do',
                            'kernel_interface/xil_ap_ctrl_hs.template_wave_do',
                            'kernel_interface/kernel_hls.template_wave_do',
                            'ov_acc_intf.template_wave_do'
            ],
            path_common = self.path_common
        ).top()



