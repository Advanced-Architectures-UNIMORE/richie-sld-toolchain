'''
    =====================================================================

    Copyright (C) 2022 ETH Zurich, University of Modena and Reggio Emilia

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

    Title:          Processing Input Specifications

    Description:    Platform Design Knobs are formatted to streamline
                    the subsequent rendering phase, where a specialized
                    Accelerator-Rich HeSoC is generated.

    Date:           8.1.2022

    Author: 		Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''

# import python functions
from python.accelerator.process_design_knobs import AcceleratorDesignKnobsFormatted

'''
  =====================================================================
  Title:        print_generation_log
  Type:         Function
  Description:  Print generation log.
  =====================================================================
'''

def print_generation_log(design_knobs, cl_id=0, verbose=False):

    print("\n# =========================== #")
    print("# Generation of Cluster n.", cl_id, " #")
    print("# =========================== #")

    if(verbose is True):

      print("\n")
      print("[py] >> User-defined cluster specification:")

      print("\n\tLIC interconnect:")
      print("\t\tAccelerator names:",               design_knobs.list_cl_lic[cl_id][1])
      print("\t\tAccelerator protocols:",           design_knobs.list_cl_lic[cl_id][2])
      print("\t\tAccelerator data ports:",          design_knobs.list_cl_lic[cl_id][3])
      print("\t\tAccelerator data ports (total):",  design_knobs.list_cl_lic[cl_id][0])

      print("\n\tHCI interconnect:")
      print("\t\tAccelerator names:",               design_knobs.list_cl_hci[cl_id][1])
      print("\t\tAccelerator protocols:",           design_knobs.list_cl_hci[cl_id][2])
      print("\t\tAccelerator data ports:",          design_knobs.list_cl_hci[cl_id][3])
      print("\t\tAccelerator data ports (total):",  design_knobs.list_cl_hci[cl_id][0])
