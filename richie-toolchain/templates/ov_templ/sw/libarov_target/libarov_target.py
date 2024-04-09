'''
    =====================================================================

    Copyright (C) 2022 University of Modena and Reggio Emilia

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

    Title:          LibAROV

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

    Date:           13.7.2022

    Author:         Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

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