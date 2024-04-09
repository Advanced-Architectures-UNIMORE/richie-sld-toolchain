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

    Title:          HWPE accelerator interface

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

    Date:           11.6.2021

    Author:         Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''

#!/usr/bin/env python3

# Templates - Top
from templates.accelerators.hw.hwpe_wrapper.hwpe_cluster_intf.top.hwpe_cluster_intf import HwpeClusterIntf
from templates.accelerators.hw.hwpe_wrapper.hwpe_top_wrapper.top.hwpe_top_wrapper import hwpe_top_wrapper
from templates.accelerators.hw.hwpe_wrapper.hwpe_top.top.hwpe_top import hwpe_top
from templates.accelerators.hw.hwpe_wrapper.hwpe_package.top.hwpe_package import hwpe_package

# Templates - Engine
from templates.accelerators.hw.hwpe_wrapper.hwpe_engine.top.hwpe_engine import hwpe_engine
from templates.accelerators.hw.hwpe_wrapper.hwpe_kernel_adapter.top.hwpe_kernel_adapter import hwpe_kernel_adapter

# Templates - Streamer
from templates.accelerators.hw.hwpe_wrapper.hwpe_streamer.top.hwpe_streamer import hwpe_streamer

# Templates - Controller
from templates.accelerators.hw.hwpe_wrapper.hwpe_ctrl.top.hwpe_ctrl import hwpe_ctrl
from templates.accelerators.hw.hwpe_wrapper.hwpe_fsm.top.hwpe_fsm import hwpe_fsm

from python.collector import collector

# HWPE wrapper
class hwpe_wrapper:
    def __init__(self):
        self.path_common = 'templates/accelerators/hw/common/'

    def HwpeClusterIntf(self):
        print("\n[py] >> HWPE wrapper ~ Cluster interface")
        return HwpeClusterIntf(
            temp_type = 'templates/accelerators/hw/hwpe_wrapper/hwpe_cluster_intf/',
            temp_top = 'hwpe_cluster_intf.template_sv',
            temp_modules = ['hwpe_intf.template_sv'],
            path_common = self.path_common
        ).top()

    def top_wrapper(self):
        print("\n[py] >> HWPE wrapper ~ Wrapper (top)")
        return hwpe_top_wrapper(
            temp_type = 'templates/accelerators/hw/hwpe_wrapper/hwpe_top_wrapper/',
            temp_top = 'hwpe_top_wrapper.template_sv',
            temp_modules = [],
            path_common = self.path_common
        ).top()

    def top(self):
        print("\n[py] >> HWPE wrapper ~ HWPE (top)")
        return hwpe_top(
            temp_type = 'templates/accelerators/hw/hwpe_wrapper/hwpe_top/',
            temp_top = 'hwpe_top.template_sv',
            temp_modules = ['ctrl.template_sv', 'streaming.template_sv'],
            path_common = self.path_common
        ).top()

    def engine(self):
        print("\n[py] >> HWPE wrapper ~ Engine")
        return hwpe_engine(
            temp_type = 'templates/accelerators/hw/hwpe_wrapper/hwpe_engine/',
            temp_top = 'hwpe_engine.template_sv',
            temp_modules = ['fsm_synch.template_sv', 
                            'streaming.template_sv',
                            'map_ctrl_flags.template_sv',
                            'kernel_adapter_interface/hdl/' + 'pulp_std.template_sv', 
                            'kernel_adapter_interface/hls/' + 'xil_ap_ctrl_hs.template_sv', 
                            'kernel_adapter_interface/hls/' + 'mdc_dataflow.template_sv',
                            'kernel_adapter_interface/hls/' + 'xil_hls_stream.template_sv'],
            path_common = self.path_common
        ).top()

    def kernel_adapter(self):
        print("\n[py] >> HWPE wrapper ~ Kernel adapter")
        return hwpe_kernel_adapter(
            temp_type = 'templates/accelerators/hw/hwpe_wrapper/hwpe_kernel_adapter/',
            temp_top = 'hwpe_kernel_adapter.template_sv',
            temp_modules = ['kernel_adapter_interface/streaming.template_sv',
                            'kernel_adapter_interface/hdl/' + 'pulp_std.template_sv', 
                            'kernel_adapter_interface/hls/' + 'xil_ap_ctrl_hs.template_sv', 
                            'kernel_adapter_interface/hls/' + 'mdc_dataflow.template_sv',
                            'kernel_adapter_interface/hls/' + 'xil_hls_stream.template_sv',
                            'kernel_interface/hdl/' + 'pulp_std.template_sv', 
                            'kernel_interface/hls/' + 'xil_ap_ctrl_hs.template_sv', 
                            'kernel_interface/hls/' + 'mdc_dataflow.template_sv',
                            'kernel_interface/hls/' + 'xil_hls_stream.template_sv'],
            path_common = self.path_common
        ).top()

    def streamer(self):
        print("\n[py] >> HWPE wrapper ~ Streamer")
        return hwpe_streamer(
            temp_type = 'templates/accelerators/hw/hwpe_wrapper/hwpe_streamer/',
            temp_top = 'hwpe_streamer.template_sv',
            temp_modules = ['fifo.template_sv', 'tcdm.template_sv', 'streaming.template_sv'],
            path_common = self.path_common
        ).top()

    def ctrl(self):
        print("\n[py] >> HWPE wrapper ~ Controller")
        return hwpe_ctrl(
            temp_type = 'templates/accelerators/hw/hwpe_wrapper/hwpe_ctrl/',
            temp_top = 'hwpe_ctrl.template_sv',
            temp_modules = [],
            path_common = self.path_common
        ).top()

    def fsm(self):
        print("\n[py] >> HWPE wrapper ~ FSM")
        return hwpe_fsm(
            temp_type = 'templates/accelerators/hw/hwpe_wrapper/hwpe_fsm/',
            temp_top = 'hwpe_fsm.template_sv',
            temp_modules = ['address_generator.template_sv', 'engine_communication.template_sv', 'streamer_communication.template_sv'],
            path_common = self.path_common
        ).top()

    def package(self):
        print("\n[py] >> HWPE wrapper ~ Package")
        return hwpe_package(
            temp_type = 'templates/accelerators/hw/hwpe_wrapper/hwpe_package/',
            temp_top = 'hwpe_package.template_sv',
            temp_modules = ['address_generator_regs.template_sv', 'custom_regs.template_sv', 'standard_regs.template_sv', 'tcdm_regs.template_sv', 'uloop_regs.template_sv'],
            path_common = self.path_common
        ).top()

