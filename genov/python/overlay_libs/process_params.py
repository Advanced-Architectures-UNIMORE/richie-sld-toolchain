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

    Title:          Processing Input Specifications

    Description:    Specifications are pre-processed, so as to ease the rendering
                    phase by formatting values, and so on.

    Date:           13.7.2022

    Author: 		Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''

'''
  =====================================================================
  Title:        print_ov_libs_log
  Type:         Function
  Description:  Print overlay libs information.
  =====================================================================
'''

def print_ov_libs_log(overlay_params, verbose=False):

    print("\n# ============================================= #")
    print("# Generation of System-Level Software Libraries #")
    print("# ============================================= #")

    if(verbose is True):

        print("\n")
        print("[py] >> User-defined overlay specification:")

        print("\n\tSoC name:", overlay_params.soc_name)

