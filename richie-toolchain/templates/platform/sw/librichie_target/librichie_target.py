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

    Title:          LibRICHIE

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

    Date:           13.7.2022

    Author:         Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''

#!/usr/bin/env python3

from templates.platform.sw.librichie_target.host.richie_target_host.richie_target_host import RichieTargetHost
from templates.platform.sw.librichie_target.host.makefile_host.makefile_host import MakefileHost
from templates.platform.sw.librichie_target.pulp.richie_target_pulp.richie_target_pulp import RichieTargetPulp
from templates.platform.sw.librichie_target.pulp.makefile_pulp.makefile_pulp import MakefilePulp
from templates.platform.sw.librichie_target.inc.richie_target_header.richie_target_header import RichieTargetHeader

class LibRichie:
    def __init__(self):
        self.path_common = 'templates/platform/sw/common/'

    def RichieTargetHost(self):
        print("\n[py] >> LibRICHIE ~ Host APIs")
        return RichieTargetHost(
            temp_type = 'templates/platform/sw/librichie_target/host/richie_target_host/',
            temp_top = 'richie_target_host.c.mako',
            temp_modules = ['richie_api_host.c.mako'],
            path_common = self.path_common
        ).top()

    def MakefileHost(self):
        print("\n[py] >> LibRICHIE ~ Host Makefile")
        return MakefileHost(
            temp_type = 'templates/platform/sw/librichie_target/host/makefile_host/',
            temp_top = 'makefile_host.mk.mako',
            temp_modules = [],
            path_common = self.path_common
        ).top()

    def RichieTargetPulp(self):
        print("\n[py] >> LibRICHIE ~ PULP APIs")
        return RichieTargetPulp(
            temp_type = 'templates/platform/sw/librichie_target/pulp/richie_target_pulp/',
            temp_top = 'richie_target_pulp.c.mako',
            temp_modules = ['richie_api_pulp.c.mako'],
            path_common = self.path_common
        ).top()

    def MakefilePulp(self):
        print("\n[py] >> LibRICHIE ~ PULP Makefile")
        return MakefilePulp(
            temp_type = 'templates/platform/sw/librichie_target/pulp/makefile_pulp/',
            temp_top = 'makefile_pulp.mk.mako',
            temp_modules = [],
            path_common = self.path_common
        ).top()

    def RichieTargetHeader(self):
        print("\n[py] >> LibRICHIE ~ Header")
        return RichieTargetHeader(
            temp_type = 'templates/platform/sw/librichie_target/inc/richie_target_header/',
            temp_top = 'richie_target_header.c.mako',
            temp_modules = ['richie_api_pulp_inline.c.mako'],
            path_common = self.path_common
        ).top()
