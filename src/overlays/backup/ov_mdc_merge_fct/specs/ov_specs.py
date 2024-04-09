'''
 =====================================================================
 Project:       Richie Toolchain
 Title:         ov_specs.py
 Description:   Specification file to guide the generation of HW/SW
	            components for accelerator-rich overlays.

 Date:          17.2.2022
 ===================================================================== */

 Copyright (C) 2022 University of Modena and Reggio Emilia.

 Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.

'''

#!/usr/bin/env python3

class ov_specs:

    '''
        ==========
        User knobs
        ==========
    '''

    '''
        Author information
    '''

    def author(self):
        self.author                             = 'Gianluca Bellocchi'    
        self.email                              = '<gianluca.bellocchi@unimore.it>'
        return self

    '''
        SoC

        - 'name' ~ Name of this specific SoC instance
        - 'board' ~ Available boards: 
            >> "zcu102" 
            >> "zcu104"
            >> "ultra96_v2"
            >> "kv260"
        - 'l2' ~ [ n_banks, size (Bytes) ]
    '''

    def soc(self):
        self.name                               = 'ov_mdc_merge_fct'
        self.board                              = 'zcu102'
        self.l2                                 = [ 1 , 256*1024]
        return self

    '''
        Clusters

        - 'core' ~ [ core_name, n_cores ]
        - 'dma' ~ [ n_dma, max_n_reqs, max_n_txns, n_dma_streams, max_burst_size ]
        - 'l1' ~ [ n_banks, size (Bytes) ]
        - 'lic' ~ [ acc_name , wrapper_protocol ]
        - 'hci' ~ [ acc_name , wrapper_protocol ]
    '''

    def cluster_0(self):
        self.core                               = [ 'riscy', 2 ]
        self.dma                                = [ 4, 16, 8, 1, 2048]
        self.l1                                 = [ 16 , 128*1024]
        self.lic                                = [ ['multi_dataflow_fir_64_128_conv_mdc' , 'hwpe'],
                                                    ['multi_dataflow_mac_mul_mmult_opt_mdc' , 'hwpe'],
                                                    ['multi_dataflow_sobel_roberts_mdc' , 'hwpe']]
        self.hci                                = [ ]
        return self