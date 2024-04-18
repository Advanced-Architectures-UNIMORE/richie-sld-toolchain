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

    Title:          Richie

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

    Date:           29.12.2021

    Author:         Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''

#!/usr/bin/env python3

from templates.platform.hw.richie.bender.bender import Bender
from templates.platform.hw.richie.bender_lock.bender_lock import BenderLock
from templates.platform.hw.richie.pulp_ip.pulp_ip import PulpIp

class Richie:
    def __init__(self):
        self.path_common = 'templates/platform/hw/common/'

    def Bender(self):
        print("\n[py] >> Richie ~ Bender (Dependency management)")
        return Bender(
            temp_type = 'templates/platform/hw/richie/bender/',
            temp_top = 'bender.yml.mako',
            temp_modules = [],
            path_common = self.path_common
        ).top()

    def BenderLock(self):
        print("\n[py] >> Richie ~ Bender lock  (Dependency management)")
        return BenderLock(
            temp_type = 'templates/platform/hw/richie/bender_lock/',
            temp_top = 'bender_lock.yml.mako',
            temp_modules = [],
            path_common = self.path_common
        ).top()

    def PulpIp(self):
        print("\n[py] >> Richie ~ PULP IP")
        return PulpIp(
            temp_type = 'templates/platform/hw/richie/pulp_ip/',
            temp_top = 'pulp_ip.sv.mako',
            temp_modules = ['functions.sv.mako'],
            path_common = self.path_common
        ).top()
