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

                        ==> 'richie-toolchain/richie-toolchain/python/generator.py'

    Date:           11.6.2021

    Author:         Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''

#!/usr/bin/env python3

from templates.accelerator.hw.hwpe_wrapper.hwpe_cluster_intf.hwpe_cluster_intf import HwpeClusterIntf
from templates.accelerator.hw.hwpe_wrapper.hwpe_top_wrapper.hwpe_top_wrapper import HwpeTopWrapper
from templates.accelerator.hw.hwpe_wrapper.hwpe_top.hwpe_top import HwpeTop
from templates.accelerator.hw.hwpe_wrapper.hwpe_package.hwpe_package import HwpePackage

from templates.accelerator.hw.hwpe_wrapper.hwpe_engine.hwpe_engine import HwpeEngine
from templates.accelerator.hw.hwpe_wrapper.hwpe_kernel_adapter.hwpe_kernel_adapter import HwpeKernelAdapter

from templates.accelerator.hw.hwpe_wrapper.hwpe_streamer.hwpe_streamer import HwpeStreamer

from templates.accelerator.hw.hwpe_wrapper.hwpe_ctrl.hwpe_ctrl import HwpeCtrl
from templates.accelerator.hw.hwpe_wrapper.hwpe_fsm.hwpe_fsm import HwpeFsm

from templates.accelerator.hw.hwpe_wrapper.bender.bender import Bender
from templates.accelerator.hw.hwpe_wrapper.ips_list.ips_list import IpsList
from templates.accelerator.hw.hwpe_wrapper.src_files.src_files import SrcFiles

from python.collector import Collector

class HwpeWrapper:
    def __init__(self):
        self.path_common = 'templates/accelerator/hw/common/'

    def HwpeClusterIntf(self):
        print("\n[py] >> HWPE accelerator interface ~ Cluster interface")
        return HwpeClusterIntf(
            temp_type = 'templates/accelerator/hw/hwpe_wrapper/hwpe_cluster_intf/',
            temp_top = 'hwpe_cluster_intf.sv.mako',
            temp_modules = ['hwpe_intf.sv.mako'],
            path_common = self.path_common
        ).top()

    def HwpeTopWrapper(self):
        print("\n[py] >> HWPE accelerator interface ~ HWPE Wrapper (top)")
        return HwpeTopWrapper(
            temp_type = 'templates/accelerator/hw/hwpe_wrapper/hwpe_top_wrapper/',
            temp_top = 'hwpe_top_wrapper.sv.mako',
            temp_modules = [],
            path_common = self.path_common
        ).top()

    def HwpeTop(self):
        print("\n[py] >> HWPE accelerator interface ~ HWPE (top)")
        return HwpeTop(
            temp_type = 'templates/accelerator/hw/hwpe_wrapper/hwpe_top/',
            temp_top = 'hwpe_top.sv.mako',
            temp_modules = ['ctrl.sv.mako', 'streaming.sv.mako'],
            path_common = self.path_common
        ).top()

    def HwpeEngine(self):
        print("\n[py] >> HWPE accelerator interface ~ Engine")
        return HwpeEngine(
            temp_type = 'templates/accelerator/hw/hwpe_wrapper/hwpe_engine/',
            temp_top = 'hwpe_engine.sv.mako',
            temp_modules = ['fsm_synch.sv.mako',
                            'streaming.sv.mako',
                            'map_ctrl_flags.sv.mako',
                            'kernel_adapter_interface/hdl/' + 'pulp_std.sv.mako',
                            'kernel_adapter_interface/hls/' + 'xil_ap_ctrl_hs.sv.mako',
                            'kernel_adapter_interface/hls/' + 'mdc_dataflow.sv.mako',
                            'kernel_adapter_interface/hls/' + 'xil_hls_stream.sv.mako'],
            path_common = self.path_common
        ).top()

    def HwpeKernelAdapter(self):
        print("\n[py] >> HWPE accelerator interface ~ Kernel adapter")
        return HwpeKernelAdapter(
            temp_type = 'templates/accelerator/hw/hwpe_wrapper/hwpe_kernel_adapter/',
            temp_top = 'hwpe_kernel_adapter.sv.mako',
            temp_modules = ['kernel_adapter_interface/streaming.sv.mako',
                            'kernel_adapter_interface/hdl/' + 'pulp_std.sv.mako',
                            'kernel_adapter_interface/hls/' + 'xil_ap_ctrl_hs.sv.mako',
                            'kernel_adapter_interface/hls/' + 'mdc_dataflow.sv.mako',
                            'kernel_adapter_interface/hls/' + 'xil_hls_stream.sv.mako',
                            'kernel_interface/hdl/' + 'pulp_std.sv.mako',
                            'kernel_interface/hls/' + 'xil_ap_ctrl_hs.sv.mako',
                            'kernel_interface/hls/' + 'mdc_dataflow.sv.mako',
                            'kernel_interface/hls/' + 'xil_hls_stream.sv.mako'],
            path_common = self.path_common
        ).top()

    def HwpeStreamer(self):
        print("\n[py] >> HWPE accelerator interface ~ Streamer")
        return HwpeStreamer(
            temp_type = 'templates/accelerator/hw/hwpe_wrapper/hwpe_streamer/',
            temp_top = 'hwpe_streamer.sv.mako',
            temp_modules = ['fifo.sv.mako', 'tcdm.sv.mako', 'streaming.sv.mako'],
            path_common = self.path_common
        ).top()

    def HwpeCtrl(self):
        print("\n[py] >> HWPE accelerator interface ~ Controller")
        return HwpeCtrl(
            temp_type = 'templates/accelerator/hw/hwpe_wrapper/hwpe_ctrl/',
            temp_top = 'hwpe_ctrl.sv.mako',
            temp_modules = [],
            path_common = self.path_common
        ).top()

    def HwpeFsm(self):
        print("\n[py] >> HWPE accelerator interface ~ FSM")
        return HwpeFsm(
            temp_type = 'templates/accelerator/hw/hwpe_wrapper/hwpe_fsm/',
            temp_top = 'hwpe_fsm.sv.mako',
            temp_modules = ['address_generator.sv.mako', 'engine_communication.sv.mako', 'streamer_communication.sv.mako'],
            path_common = self.path_common
        ).top()

    def HwpePackage(self):
        print("\n[py] >> HWPE accelerator interface ~ Package")
        return HwpePackage(
            temp_type = 'templates/accelerator/hw/hwpe_wrapper/hwpe_package/',
            temp_top = 'hwpe_package.sv.mako',
            temp_modules = ['address_generator_regs.sv.mako', 'custom_regs.sv.mako', 'standard_regs.sv.mako', 'tcdm_regs.sv.mako', 'uloop_regs.sv.mako'],
            path_common = self.path_common
        ).top()

    def Bender(self):
        print("\n[py] >> HWPE accelerator interface ~ Bender (Dependency management)")
        return Bender(
            temp_type = 'templates/accelerator/hw/hwpe_wrapper/bender/',
            temp_top = 'bender.yml.mako',
            temp_modules = [],
            path_common = self.path_common
        ).top()

    def SrcFiles(self):
        print("\n[py] >> HWPE accelerator interface ~ src_files (Dependency management, deprecated)")
        return SrcFiles(
            temp_type = 'templates/accelerator/hw/hwpe_wrapper/src_files/',
            temp_top = 'src_files.yml.mako',
            temp_modules = [],
            path_common = self.path_common
        ).top()

    def IpsList(self):
        print("\n[py] >> HWPE accelerator interface ~ ips_list (Dependency management, deprecated)")
        return IpsList(
            temp_type = 'templates/accelerator/hw/hwpe_wrapper/ips_list/',
            temp_top = 'ips_list.yml.mako',
            temp_modules = [],
            path_common = self.path_common
        ).top()
