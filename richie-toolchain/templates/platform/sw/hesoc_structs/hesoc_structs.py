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

    Title:          HeSoC structs

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

    Date:           15.7.2022

    Author:         Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''

#!/usr/bin/env python3

from templates.platform.sw.hesoc_structs.def_struct_perf_eval.def_struct_perf_eval import DefStructPerfEval

class HesocStructs:
    def __init__(self):
        self.path_common = 'templates/platform/sw/common/'

    def DefStructPerfEval(self):
        print("\n[py] >> HeSoC structs ~ Performance profiling")
        return DefStructPerfEval(
            temp_type = 'templates/platform/sw/hesoc_structs/def_struct_perf_eval/',
            temp_top = 'def_struct_perf_eval.c.mako',
            temp_modules = [],
            path_common = self.path_common
        ).top()
