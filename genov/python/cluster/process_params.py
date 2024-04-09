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

    Project:        GenOv

    Title:          Processing Input Specifications

    Description:    Specifications are pre-processed, so as to ease the rendering
                    phase by formatting values, and so on.

    Date:           8.1.2022

    Author: 		Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''

# import python functions
from python.wrapper.import_params import import_acc_dev_module
from python.wrapper.process_params import wrapper_params_formatted

'''
  =====================================================================
  Title:        print_cl_log
  Type:         Function
  Description:  Print cluster information.
  =====================================================================
'''

def print_cl_log(overlay_params, cl_id=0, verbose=False):

    print("\n# =========================== #")
    print("# Generation of Cluster n.", cl_id, " #")
    print("# =========================== #")

    if(verbose is True):

      print("\n")
      print("[py] >> User-defined cluster specification:")

      print("\n\tLIC interconnect:")
      print("\t\tAccelerator names:",               overlay_params.list_cl_lic[cl_id][1])
      print("\t\tAccelerator protocols:",           overlay_params.list_cl_lic[cl_id][2])
      print("\t\tAccelerator data ports:",          overlay_params.list_cl_lic[cl_id][3])
      print("\t\tAccelerator data ports (total):",  overlay_params.list_cl_lic[cl_id][0])

      print("\n\tHCI interconnect:")
      print("\t\tAccelerator names:",               overlay_params.list_cl_hci[cl_id][1])
      print("\t\tAccelerator protocols:",           overlay_params.list_cl_hci[cl_id][2])
      print("\t\tAccelerator data ports:",          overlay_params.list_cl_hci[cl_id][3])
      print("\t\tAccelerator data ports (total):",  overlay_params.list_cl_hci[cl_id][0])
