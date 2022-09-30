'''
 =====================================================================
 Project:      Accelerator-Rich Overlay Generator
 Title:        process_params.py
 Description:  Processing of overlay libraries design parameters.

 Date:         13.7.2022
 ===================================================================== */

 Copyright (C) 2021 University of Modena and Reggio Emilia.

 Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.

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

