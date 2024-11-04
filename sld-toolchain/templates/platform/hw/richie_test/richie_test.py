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

    Title:          HeSoC tests

    Description:    This class collects the templates which comply with
                    a subsystem of the Accelerator-Rich HeSoC.

                    About the generation flow:

                    - The class object is imported and instantiated by
                    the generation scripts under:

                        ==> 'richie-sld-toolchain/sld-toolchain/generate_*.py'

                    - The object is then passed to a generator, which
                    accomplishes the rendering phase. Generators are
                    defined under:

                        ==> 'richie-sld-toolchain/sld-toolchain/python/generator.py'

    Date:           29.12.2021

    Author:         Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''

#!/usr/bin/env python3

from templates.platform.hw.richie_test.richie_tb_hw.richie_tb_hw import RichieTestbenchHw
from templates.platform.hw.richie_test.vsim_wave_cluster.vsim_wave_cluster import VsimWaveCluster
from templates.platform.hw.richie_test.vsim_wave_wrapper.vsim_wave_wrapper import VsimWaveWrapper
from templates.platform.hw.richie_test.vsim_wave_experiment_view.vsim_wave_experiment_view import VsimWaveExperimentView
from templates.platform.hw.richie_test.vsim_wave_hesoc.vsim_wave_hesoc import VsimWaveHesoc

class RichieTest:
    def __init__(self):
        self.path_common = 'templates/platform/hw/common/'

    def RichieTestbenchHw(self):
        print("\n[py] >> Richie test ~ Hardware testbench")
        return RichieTestbenchHw(
            temp_type = 'templates/platform/hw/richie_test/richie_tb_hw/',
            temp_top = 'richie_tb_hw.sv.mako',
            temp_modules = ['hwpe.sv.mako'],
            path_common = self.path_common
        ).top()

    def VsimWaveCluster(self):
        print("\n[py] >> Richie test ~ QuestaSim waves (Cluster)")
        return VsimWaveCluster(
            temp_type = 'templates/platform/hw/richie_test/vsim_wave_cluster/',
            temp_top = 'vsim_wave_cluster.tcl.mako',
            temp_modules = ['cluster.tcl.mako',
                            'riscv_core.tcl.mako',
                            'lic_acc_region.tcl.mako',
            ],
            path_common = self.path_common
        ).top()

    def VsimWaveWrapper(self, accelerator_name, accelerator_integration):
        print("\n[py] >> Richie test ~ QuestaSim waves (HWPE Accelerator: %s, as %s)" % (accelerator_name, accelerator_integration))
        return VsimWaveWrapper(
            temp_type = 'templates/platform/hw/richie_test/vsim_wave_wrapper/',
            temp_top = 'vsim_wave_wrapper.tcl.mako',
            temp_modules = ['hwpe/hwpe_ctrl.tcl.mako',
                            'hwpe/hwpe_engine.tcl.mako',
                            'hwpe/hwpe_fsm.tcl.mako',
                            'hwpe/hwpe_streamer.tcl.mako',
                            'hwpe/hwpe_top.tcl.mako',
                            'hwpe/accelerator_datapath.tcl.mako',
                            'hwpe.tcl.mako'
            ],
            path_common = self.path_common
        ).top()

    def VsimWaveHesoc(self):
        print("\n[py] >> Richie test ~ QuestaSim waves (HeSoC)")
        return VsimWaveHesoc(
            temp_type = 'templates/platform/hw/richie_test/vsim_wave_hesoc/',
            temp_top = 'vsim_wave_hesoc.tcl.mako',
            temp_modules = ['pulp_cluster_inputs.tcl.mako',
                            'pulp_cluster_outputs.tcl.mako',
                            'hesoc.tcl.mako'
            ],
            path_common = self.path_common
        ).top()

    def VsimWaveExperimentView(self):
        print("\n[py] >> Richie test ~ QuestaSim waves (Experiment)")
        return VsimWaveExperimentView(
            temp_type = 'templates/platform/hw/richie_test/vsim_wave_experiment_view/',
            temp_top = 'vsim_wave_experiment_view.tcl.mako',
            temp_modules = ['group_by_device.tcl.mako',
                            'group_by_cluster.tcl.mako'
            ],
            path_common = self.path_common
        ).top()
