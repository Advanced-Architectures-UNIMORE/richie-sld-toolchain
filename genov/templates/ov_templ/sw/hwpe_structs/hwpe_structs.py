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

    Title:          Accelerator structs

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

    Date:           15.7.2022

    Author:         Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''

#!/usr/bin/env python3

from templates.ov_templ.sw.hwpe_structs.def_struct_common.top.def_struct_common import DefStructCommon
from templates.ov_templ.sw.hwpe_structs.def_struct_hwpe.top.def_struct_hwpe import DefStructHwpe

class HwpeStructs:
    def __init__(self):
        self.path_common = 'templates/ov_templ/sw/common/'

    def DefStructCommon(self):
        print("\n[py] >> HWPE structs ~ Common")
        return DefStructCommon(
            temp_type = 'templates/ov_templ/sw/hwpe_structs/def_struct_common/',
            temp_top = 'def_struct_common.template_c',
            temp_modules = [],
            path_common = self.path_common
        ).top()

    def DefStructHwpe(self, name):
        print("\n[py] >> HWPE structs ~ %s" % name)
        return DefStructHwpe(
            temp_type = 'templates/ov_templ/sw/hwpe_structs/def_struct_hwpe/',
            temp_top = 'def_struct_hwpe.template_c',
            temp_modules = [],
            path_common = self.path_common
        ).top()