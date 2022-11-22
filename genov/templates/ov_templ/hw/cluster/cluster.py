'''
 =====================================================================
 Project:       Cluster class
 Title:         cluster.py
 Description:   The Cluster class recalls all the the templates 
                compliant with the generation of an overlay cluster tailored 
                to an use in the aim of accelerator-rich architectures and
                supporting different accelerator interconnection strategies.

 Date:          29.12.2021
 ===================================================================== */

 Copyright (C) 2021 University of Modena and Reggio Emilia.

 Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.

'''

#!/usr/bin/env python3

from templates.ov_templ.hw.cluster.bender.top.bender import Bender
from templates.ov_templ.hw.cluster.lic_acc_region.top.lic_acc_region import LicAccRegion
from templates.ov_templ.hw.cluster.periph_acc_intf.top.periph_acc_intf import PeriphAccIntf
from templates.ov_templ.hw.cluster.pulp_cluster_cfg_pkg.top.pulp_cluster_cfg_pkg import PulpClusterCfgPkg
from templates.ov_templ.hw.cluster.pulp_cluster_defines.top.pulp_cluster_defines import PulpClusterDefines

class Cluster:
    def __init__(self):
        self.path_common = 'templates/ov_templ/hw/common/'

    def Bender(self):
        print("\n[py] >> Cluster ~ Bender")
        return Bender(
            temp_type = 'templates/ov_templ/hw/cluster/bender/',
            temp_top = 'bender.template_yml',
            temp_modules = [],
            path_common = self.path_common
        ).top()

    def LicAccRegion(self):
        print("\n[py] >> Cluster ~ LIC accelerator region")
        return LicAccRegion(
            temp_type = 'templates/ov_templ/hw/cluster/lic_acc_region/',
            temp_top = 'lic_acc_region.template_sv',
            temp_modules = ['acc_region.template_sv', 
                            'hwpe_intf.template_sv'],
            path_common = self.path_common
        ).top()

    def PeriphAccIntf(self):
        print("\n[py] >> Cluster ~ Peripheral accelerator interface")
        return PeriphAccIntf(
            temp_type = 'templates/ov_templ/hw/cluster/periph_acc_intf/',
            temp_top = 'periph_acc_intf.template_sv',
            temp_modules = [],
            path_common = self.path_common
        ).top()

    def PulpClusterCfgPkg(self):
        print("\n[py] >> Cluster ~ PULP cluster configuration package")
        return PulpClusterCfgPkg(
            temp_type = 'templates/ov_templ/hw/cluster/pulp_cluster_cfg_pkg/',
            temp_top = 'pulp_cluster_cfg_pkg.template_sv',
            temp_modules = ['hwpe_lic.template_sv',
                            'hwpe_hci.template_sv'],
            path_common = self.path_common
        ).top()

    def PulpClusterDefines(self):
        print("\n[py] >> Cluster ~ PULP cluster macros")
        return PulpClusterCfgPkg(
            temp_type = 'templates/ov_templ/hw/cluster/pulp_cluster_defines/',
            temp_top = 'pulp_cluster_defines.template_sv',
            temp_modules = [],
            path_common = self.path_common
        ).top()