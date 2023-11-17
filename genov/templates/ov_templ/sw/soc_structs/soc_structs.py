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

    Title:          SoC structs

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

from templates.ov_templ.sw.soc_structs.def_struct_perf_eval.top.def_struct_perf_eval import DefStructPerfEval

class SocStructs:
    def __init__(self):
        self.path_common = 'templates/ov_templ/sw/common/'

    def DefStructPerfEval(self):
        print("\n[py] >> SoC structs ~ Performance profiling")
        return DefStructPerfEval(
            temp_type = 'templates/ov_templ/sw/soc_structs/def_struct_perf_eval/',
            temp_top = 'def_struct_perf_eval.template_c',
            temp_modules = [],
            path_common = self.path_common
        ).top()