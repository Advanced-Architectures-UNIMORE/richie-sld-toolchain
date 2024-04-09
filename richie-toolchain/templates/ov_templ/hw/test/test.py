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

    Title:          SoC tests

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

    Date:           29.12.2021

    Author:         Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''

#!/usr/bin/env python3

from templates.ov_templ.hw.test.overlay_tb_hw.top.overlay_tb_hw import OverlayTestbenchHw
from templates.ov_templ.hw.test.vsim_wave_cluster.top.vsim_wave_cluster import VsimWaveCluster
from templates.ov_templ.hw.test.vsim_wave_wrapper.top.vsim_wave_wrapper import VsimWaveWrapper
from templates.ov_templ.hw.test.vsim_wave_experiment_view.top.vsim_wave_experiment_view import VsimWaveExperimentView
from templates.ov_templ.hw.test.vsim_wave_soc.top.vsim_wave_soc import VsimWaveSoc

class Test:
    def __init__(self):
        self.path_common = 'templates/ov_templ/hw/common/'

    def OverlayTestbenchHw(self):
        print("\n[py] >> Overlay ~ Hardware testbench")
        return OverlayTestbenchHw(
            temp_type = 'templates/ov_templ/hw/test/overlay_tb_hw/',
            temp_top = 'overlay_tb_hw.template_sv',
            temp_modules = [],
            path_common = self.path_common
        ).top()
    
    def VsimWaveCluster(self):
        print("\n[py] >> Overlay ~ QuestaSim waves (Cluster)")
        return VsimWaveCluster(
            temp_type = 'templates/ov_templ/hw/test/vsim_wave_cluster/',
            temp_top = 'vsim_wave_cluster.template_wave_do',
            temp_modules = ['cluster.template_wave_do',
                            'riscv_core.template_wave_do',
                            'lic_acc_region.template_wave_do',
            ],
            path_common = self.path_common
        ).top()

    def VsimWaveWrapper(self):
        print("\n[py] >> Overlay ~ QuestaSim waves (Wrapper)")
        return VsimWaveWrapper(
            temp_type = 'templates/ov_templ/hw/test/vsim_wave_wrapper/',
            temp_top = 'vsim_wave_wrapper.template_wave_do',
            temp_modules = ['hwpe/hwpe_ctrl.template_wave_do', 
                            'hwpe/hwpe_engine.template_wave_do', 
                            'hwpe/hwpe_fsm.template_wave_do',
                            'hwpe/hwpe_streamer.template_wave_do',
                            'hwpe/hwpe_top.template_wave_do',
                            'hwpe/accelerator_kernel.template_wave_do',
                            'hwpe.template_wave_do'
            ],
            path_common = self.path_common
        ).top()

    def VsimWaveSoc(self):
        print("\n[py] >> Overlay ~ QuestaSim waves (SoC)")
        return VsimWaveSoc(
            temp_type = 'templates/ov_templ/hw/test/vsim_wave_soc/',
            temp_top = 'vsim_wave_soc.template_wave_do',
            temp_modules = ['pulp_cluster_inputs.template_wave_do',
                            'pulp_cluster_outputs.template_wave_do',
                            'soc.template_wave_do'
            ],
            path_common = self.path_common
        ).top()

    def VsimWaveExperimentView(self):
        print("\n[py] >> Overlay ~ QuestaSim waves (Experiment)")
        return VsimWaveSoc(
            temp_type = 'templates/ov_templ/hw/test/vsim_wave_experiment_view/',
            temp_top = 'vsim_wave_experiment_view.template_wave_do',
            temp_modules = ['group_by_device.template_wave_do',
                            'group_by_cluster.template_wave_do'
            ],
            path_common = self.path_common
        ).top()