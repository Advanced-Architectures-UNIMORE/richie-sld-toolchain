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

    Title:          PULP Cluster

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

from templates.platform.hw.cluster.bender.bender import Bender
from templates.platform.hw.cluster.lic_acc_region.lic_acc_region import LicAccRegion
from templates.platform.hw.cluster.periph_acc_intf.periph_acc_intf import PeriphAccIntf
from templates.platform.hw.cluster.pulp_cluster_cfg_pkg.pulp_cluster_cfg_pkg import PulpClusterCfgPkg
from templates.platform.hw.cluster.pulp_cluster_defines.pulp_cluster_defines import PulpClusterDefines

class Cluster:
    def __init__(self):
        self.path_common = 'templates/platform/hw/common/'

    def Bender(self):
        print("\n[py] >> Richie Cluster ~ Bender (Dependency management)")
        return Bender(
            temp_type = 'templates/platform/hw/cluster/bender/',
            temp_top = 'bender.yml.mako',
            temp_modules = [],
            path_common = self.path_common
        ).top()

    def LicAccRegion(self):
        print("\n[py] >> Richie Cluster ~ LIC accelerator region")
        return LicAccRegion(
            temp_type = 'templates/platform/hw/cluster/lic_acc_region/',
            temp_top = 'lic_acc_region.sv.mako',
            temp_modules = ['acc_region.sv.mako',
                            'hwpe_intf.sv.mako'],
            path_common = self.path_common
        ).top()

    def PeriphAccIntf(self):
        print("\n[py] >> Richie Cluster ~ Peripheral accelerator interface")
        return PeriphAccIntf(
            temp_type = 'templates/platform/hw/cluster/periph_acc_intf/',
            temp_top = 'periph_acc_intf.sv.mako',
            temp_modules = [],
            path_common = self.path_common
        ).top()

    def PulpClusterCfgPkg(self):
        print("\n[py] >> Richie Cluster ~ PULP cluster configuration package")
        return PulpClusterCfgPkg(
            temp_type = 'templates/platform/hw/cluster/pulp_cluster_cfg_pkg/',
            temp_top = 'pulp_cluster_cfg_pkg.sv.mako',
            temp_modules = ['hwpe_lic.sv.mako',
                            'hwpe_hci.sv.mako'],
            path_common = self.path_common
        ).top()

    def PulpClusterDefines(self):
        print("\n[py] >> Richie Cluster ~ PULP cluster macros")
        return PulpClusterCfgPkg(
            temp_type = 'templates/platform/hw/cluster/pulp_cluster_defines/',
            temp_top = 'pulp_cluster_defines.sv.mako',
            temp_modules = [],
            path_common = self.path_common
        ).top()
