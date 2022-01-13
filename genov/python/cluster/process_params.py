'''
 =====================================================================
 Project:      Accelerator-Rich Overlay Generator
 Title:        process_params.py
 Description:  Processing of cluster design parameters.

 Date:         8.1.2022
 ===================================================================== */

 Copyright (C) 2021 University of Modena and Reggio Emilia.

 Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.

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

def print_cl_log(overlay_params, cl_offset=0):

    print("\n# =========================== #")
    print("# Generation of Cluster n.", cl_offset, " #")
    print("# =========================== #\n")

    print("[py] >> User-defined cluster specification:")

    print("\n\tLIC interconnect:")
    print("\t\tAccelerator names:",               overlay_params.list_cl_lic[cl_offset][0])
    print("\t\tAccelerator protocols:",           overlay_params.list_cl_lic[cl_offset][1])
    print("\t\tAccelerator data ports:",          overlay_params.list_cl_lic[cl_offset][2])
    print("\t\tAccelerator data ports (total):",  overlay_params.list_cl_lic[cl_offset][3])

    print("\n\tHCI interconnect:")
    print("\t\tAccelerator names:",               overlay_params.list_cl_hci[cl_offset][0])
    print("\t\tAccelerator protocols:",           overlay_params.list_cl_hci[cl_offset][1])
    print("\t\tAccelerator data ports:",          overlay_params.list_cl_hci[cl_offset][2])
    print("\t\tAccelerator data ports (total):",  overlay_params.list_cl_hci[cl_offset][3])