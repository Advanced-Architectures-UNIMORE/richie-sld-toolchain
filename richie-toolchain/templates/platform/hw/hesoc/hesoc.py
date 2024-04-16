'''
    =====================================================================

    Copyright (C) 2021 ETH Zurich, University of Modena and Reggio Emilia

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

    Title:          Accelerator-Rich HeSoC

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

    Date:           29.12.2021

    Author:         Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''

#!/usr/bin/env python3

from templates.platform.hw.hesoc.bender.bender import Bender
from templates.platform.hw.hesoc.dmac_wrap_ooc.dmac_wrap_ooc import DmacWrapOOC
from templates.platform.hw.hesoc.hero_axi_mailbox.hero_axi_mailbox import HeroAxiMailbox
from templates.platform.hw.hesoc.l2_mem.l2_mem import L2Mem
from templates.platform.hw.hesoc.pulp.pulp import Pulp
from templates.platform.hw.hesoc.pulp_cluster_ooc.pulp_cluster_ooc import PulpClusterOOC
from templates.platform.hw.hesoc.pulp_ooc.pulp_ooc import PulpOoc
from templates.platform.hw.hesoc.hesoc_interconnect.hesoc_interconnect import HesocInterconnect
from templates.platform.hw.hesoc.hesoc_ctrl_regs.hesoc_ctrl_regs import HesocCtrlRegs
from templates.platform.hw.hesoc.hesoc_cfg_pkg.hesoc_cfg_pkg import HesocCfgPkg
from templates.platform.hw.hesoc.hesoc_peripherals.hesoc_peripherals import HesocPeripherals

class Hesoc:
    def __init__(self):
        self.path_common = 'templates/platform/hw/common/'

    def Bender(self):
        print("\n[py] >> Richie HeSoC ~ Bender (Dependency management)")
        return Bender(
            temp_type = 'templates/platform/hw/hesoc/bender/',
            temp_top = 'bender.yml.mako',
            temp_modules = [],
            path_common = self.path_common
        ).top()

    def DmacWrapOOC(self):
        print("\n[py] >> Richie HeSoC ~ DMA wrapper OOC")
        return DmacWrapOOC(
            temp_type = 'templates/platform/hw/hesoc/dmac_wrap_ooc/',
            temp_top = 'dmac_wrap_ooc.sv.mako',
            temp_modules = [],
            path_common = self.path_common
        ).top()

    def HeroAxiMailbox(self):
        print("\n[py] >> Richie HeSoC ~ HERO AXI mailbox")
        return HeroAxiMailbox(
            temp_type = 'templates/platform/hw/hesoc/hero_axi_mailbox/',
            temp_top = 'hero_axi_mailbox.sv.mako',
            temp_modules = [],
            path_common = self.path_common
        ).top()

    def L2Mem(self):
        print("\n[py] >> Richie HeSoC ~ L2 memory")
        return L2Mem(
            temp_type = 'templates/platform/hw/hesoc/l2_mem/',
            temp_top = 'l2_mem.sv.mako',
            temp_modules = [],
            path_common = self.path_common
        ).top()

    def Pulp(self):
        print("\n[py] >> Richie HeSoC ~ PULP")
        return Pulp(
            temp_type = 'templates/platform/hw/hesoc/pulp/',
            temp_top = 'pulp.sv.mako',
            temp_modules = ['process_params.sv.mako'],
            path_common = self.path_common
        ).top()

    def PulpClusterOOC(self):
        print("\n[py] >> Richie HeSoC ~ PULP cluster OOC")
        return PulpClusterOOC(
            temp_type = 'templates/platform/hw/hesoc/pulp_cluster_ooc/',
            temp_top = 'pulp_cluster_ooc.sv.mako',
            temp_modules = ['hwpe_lic.sv.mako',
                            'hwpe_hci.sv.mako'],
            path_common = self.path_common
        ).top()

    def PulpOoc(self):
        print("\n[py] >> Richie HeSoC ~ PULP OOC")
        return PulpOoc(
            temp_type = 'templates/platform/hw/hesoc/pulp_ooc/',
            temp_top = 'pulp_ooc.sv.mako',
            temp_modules = [],
            path_common = self.path_common
        ).top()

    def HesocInterconnect(self):
        print("\n[py] >> Richie HeSoC ~ HeSoC interconnect")
        return HesocCtrlRegs(
            temp_type = 'templates/platform/hw/hesoc/hesoc_interconnect/',
            temp_top = 'hesoc_interconnect.sv.mako',
            temp_modules = [],
            path_common = self.path_common
        ).top()

    def HesocCtrlRegs(self):
        print("\n[py] >> Richie HeSoC ~ HeSoC control registers")
        return HesocCtrlRegs(
            temp_type = 'templates/platform/hw/hesoc/hesoc_ctrl_regs/',
            temp_top = 'hesoc_ctrl_regs.sv.mako',
            temp_modules = [],
            path_common = self.path_common
        ).top()

    def HesocCfgPkg(self):
        print("\n[py] >> Richie HeSoC ~ HeSoC configuration package")
        return HesocCfgPkg(
            temp_type = 'templates/platform/hw/hesoc/hesoc_cfg_pkg/',
            temp_top = 'hesoc_cfg_pkg.sv.mako',
            temp_modules = [],
            path_common = self.path_common
        ).top()

    def HesocPeripherals(self):
        print("\n[py] >> Richie HeSoC ~ HeSoC peripherals")
        return HesocPeripherals(
            temp_type = 'templates/platform/hw/hesoc/hesoc_peripherals/',
            temp_top = 'hesoc_peripherals.sv.mako',
            temp_modules = [],
            path_common = self.path_common
        ).top()
