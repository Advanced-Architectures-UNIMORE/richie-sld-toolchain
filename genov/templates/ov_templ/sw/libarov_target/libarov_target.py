'''
 =====================================================================
 Project:       LibArov class
 Title:         libarov_target.py
 Description:   The LibArov class recalls all the the templates 
                compliant with the generation of the software libraries
                for the accelerator-rich system control.

 Date:          13.7.2022
 ===================================================================== */

 Copyright (C) 2022 University of Modena and Reggio Emilia.

 Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.

'''

#!/usr/bin/env python3

from templates.ov_templ.sw.libarov_target.host.arov_target.top.arov_target_host import ArovTargetHost
from templates.ov_templ.sw.libarov_target.host.makefile.top.makefile_host import MakefileHost
from templates.ov_templ.sw.libarov_target.pulp.arov_target.top.arov_target_pulp import ArovTargetPulp
from templates.ov_templ.sw.libarov_target.pulp.makefile.top.makefile_pulp import MakefilePulp
from templates.ov_templ.sw.libarov_target.inc.arov_target.top.arov_target_header import ArovTargetHeader

class LibArov:
    def __init__(self):
        self.path_common = 'templates/ov_templ/sw/common/'

    def ArovTargetHost(self):
        print("\n[py] >> LibAROV ~ Host APIs")
        return ArovTargetHost(
            temp_type = 'templates/ov_templ/sw/libarov_target/host/arov_target/',
            temp_top = 'arov_target_host.template_c',
            temp_modules = ['arov_api_host.template_c'],
            path_common = self.path_common
        ).top()

    def MakefileHost(self):
        print("\n[py] >> LibAROV ~ Host Makefile")
        return MakefileHost(
            temp_type = 'templates/ov_templ/sw/libarov_target/host/makefile/',
            temp_top = 'makefile_host.template_mk',
            temp_modules = [],
            path_common = self.path_common
        ).top()

    def ArovTargetPulp(self):
        print("\n[py] >> LibAROV ~ PULP APIs")
        return ArovTargetPulp(
            temp_type = 'templates/ov_templ/sw/libarov_target/pulp/arov_target/',
            temp_top = 'arov_target_pulp.template_c',
            temp_modules = ['arov_api_pulp.template_c'],
            path_common = self.path_common
        ).top()

    def MakefilePulp(self):
        print("\n[py] >> LibAROV ~ PULP Makefile")
        return MakefilePulp(
            temp_type = 'templates/ov_templ/sw/libarov_target/pulp/makefile/',
            temp_top = 'makefile_pulp.template_mk',
            temp_modules = [],
            path_common = self.path_common
        ).top()

    def ArovTargetHeader(self):
        print("\n[py] >> LibAROV ~ Header")
        return ArovTargetHeader(
            temp_type = 'templates/ov_templ/sw/libarov_target/inc/arov_target/',
            temp_top = 'arov_target_header.template_c',
            temp_modules = ['arov_api_pulp_inline.template_c'],
            path_common = self.path_common
        ).top()