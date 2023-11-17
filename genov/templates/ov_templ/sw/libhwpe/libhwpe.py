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

    Project:        GenOv

    Title:          LibHWPE

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

    Date:           13.7.2022

    Author:         Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''

#!/usr/bin/env python3

from templates.ov_templ.sw.libhwpe.host.hwpe_cl_lic.top.hwpe_cl_lic_host import HwpeClLicHost
from templates.ov_templ.sw.libhwpe.host.makefile.top.makefile_host import MakefileHost
from templates.ov_templ.sw.libhwpe.pulp.hwpe_cl_lic.top.hwpe_cl_lic_pulp import HwpeClLicPulp
from templates.ov_templ.sw.libhwpe.pulp.makefile.top.makefile_pulp import MakefilePulp
from templates.ov_templ.sw.libhwpe.inc.hwpe_cl_lic.top.hwpe_cl_lic_header import HwpeClLicHeader

class LibHwpe:
    def __init__(self):
        self.path_common = 'templates/ov_templ/sw/common/'

    def HwpeClLicHost(self, name):
        print("\n[py] >> LibHWPE ~ %s (Host APIs)" % name)
        return HwpeClLicHost(
            temp_type = 'templates/ov_templ/sw/libhwpe/host/hwpe_cl_lic/',
            temp_top = 'hwpe_cl_lic_host.template_c',
            temp_modules = [],
            path_common = self.path_common
        ).top()

    def MakefileHost(self, name):
        print("\n[py] >> LibHWPE ~ %s (Host Makefile)" % name)
        return MakefileHost(
            temp_type = 'templates/ov_templ/sw/libhwpe/host/makefile/',
            temp_top = 'makefile_host.template_mk',
            temp_modules = [],
            path_common = self.path_common
        ).top()

    def HwpeClLicPulp(self, name):
        print("\n[py] >> LibHWPE ~ %s (PULP APIs)" % name)
        return HwpeClLicPulp(
            temp_type = 'templates/ov_templ/sw/libhwpe/pulp/hwpe_cl_lic/',
            temp_top = 'hwpe_cl_lic_pulp.template_c',
            temp_modules = [],
            path_common = self.path_common
        ).top()

    def MakefilePulp(self, name):
        print("\n[py] >> LibHWPE ~ %s (PULP Makefile)" % name)
        return MakefilePulp(
            temp_type = 'templates/ov_templ/sw/libhwpe/pulp/makefile/',
            temp_top = 'makefile_pulp.template_mk',
            temp_modules = [],
            path_common = self.path_common
        ).top()

    def HwpeClLicHeader(self, name):
        print("\n[py] >> LibHWPE ~ %s (Header)" % name)
        return HwpeClLicHeader(
            temp_type = 'templates/ov_templ/sw/libhwpe/inc/hwpe_cl_lic/',
            temp_top = 'hwpe_cl_lic_header.template_c',
            temp_modules = [],
            path_common = self.path_common
        ).top()