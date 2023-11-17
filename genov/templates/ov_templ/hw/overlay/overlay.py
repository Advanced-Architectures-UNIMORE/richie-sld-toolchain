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

    Project:        GenOv

    Title:          Overlay

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

    Date:           29.12.2021

    Author:         Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''

#!/usr/bin/env python3

from templates.ov_templ.hw.overlay.bender.top.bender import Bender
from templates.ov_templ.hw.overlay.bender_lock.top.bender_lock import BenderLock
from templates.ov_templ.hw.overlay.pulp_ip.top.pulp_ip import PulpIp

class Overlay:
    def __init__(self):
        self.path_common = 'templates/ov_templ/hw/common/'

    def Bender(self):
        print("\n[py] >> Overlay ~ Bender")
        return Bender(
            temp_type = 'templates/ov_templ/hw/overlay/bender/',
            temp_top = 'bender.template_yml',
            temp_modules = [],
            path_common = self.path_common
        ).top()

    def BenderLock(self):
        print("\n[py] >> Overlay ~ Bender lock")
        return BenderLock(
            temp_type = 'templates/ov_templ/hw/overlay/bender_lock/',
            temp_top = 'bender_lock.template_yml',
            temp_modules = [],
            path_common = self.path_common
        ).top()

    def PulpIp(self):
        print("\n[py] >> Overlay ~ PULP IP")
        return PulpIp(
            temp_type = 'templates/ov_templ/hw/overlay/pulp_ip/',
            temp_top = 'pulp_ip.template_sv',
            temp_modules = ['functions.template_sv'],
            path_common = self.path_common
        ).top()