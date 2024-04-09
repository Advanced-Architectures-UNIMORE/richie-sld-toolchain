'''
 =====================================================================
 Project:       Richie Toolchain
 Title:         ov_specs.py
 Description:   Specification file to guide the generation of HW/SW
	            components for accelerator-rich overlays.

 Date:          2.2.2023
 ===================================================================== */

 Copyright (C) 2023 University of Modena and Reggio Emilia.

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
        self.name                               = 'color_detect_4stg_4acc_4cl_16l1p'
        self.board                              = 'zcu102'
        self.l2                                 = [ 1 , 8*1024*1024]
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
        self.core                               = [ 'riscy', 8 ]
        self.dma                                = [ 4, 512, 8, 1, 2048]
        self.l1                                 = [ 16 , 128*1024]
        self.lic                                = [ [ 'rgb2hsv_cv' , 'hwpe'],
                                                    [ 'threshold_cv' , 'hwpe'],
                                                    [ 'erode_cv' , 'hwpe'],
                                                    [ 'dilate_cv' , 'hwpe']]
        self.hci                                = [ ]
        return self

    def cluster_1(self):
        self.core                               = [ 'riscy', 8 ]
        self.dma                                = [ 4, 512, 8, 1, 2048]
        self.l1                                 = [ 16 , 128*1024]
        self.lic                                = [ [ 'rgb2hsv_cv' , 'hwpe'],
                                                    [ 'threshold_cv' , 'hwpe'],
                                                    [ 'erode_cv' , 'hwpe'],
                                                    [ 'dilate_cv' , 'hwpe']]
        self.hci                                = [ ]
        return self

    def cluster_2(self):
        self.core                               = [ 'riscy', 8 ]
        self.dma                                = [ 4, 512, 8, 1, 2048]
        self.l1                                 = [ 16 , 128*1024]
        self.lic                                = [ [ 'rgb2hsv_cv' , 'hwpe'],
                                                    [ 'threshold_cv' , 'hwpe'],
                                                    [ 'erode_cv' , 'hwpe'],
                                                    [ 'dilate_cv' , 'hwpe']]
        self.hci                                = [ ]
        return self

    def cluster_3(self):
        self.core                               = [ 'riscy', 8 ]
        self.dma                                = [ 4, 512, 8, 1, 2048]
        self.l1                                 = [ 16 , 128*1024]
        self.lic                                = [ [ 'rgb2hsv_cv' , 'hwpe'],
                                                    [ 'threshold_cv' , 'hwpe'],
                                                    [ 'erode_cv' , 'hwpe'],
                                                    [ 'dilate_cv' , 'hwpe']]
        self.hci                                = [ ]
        return self

    def cluster_4(self):
        self.core                               = [ 'riscy', 8 ]
        self.dma                                = [ 4, 512, 8, 1, 2048]
        self.l1                                 = [ 16 , 128*1024]
        self.lic                                = [ [ 'rgb2hsv_cv' , 'hwpe'],
                                                    [ 'threshold_cv' , 'hwpe'],
                                                    [ 'erode_cv' , 'hwpe'],
                                                    [ 'dilate_cv' , 'hwpe']]
        self.hci                                = [ ]
        return self

    def cluster_5(self):
        self.core                               = [ 'riscy', 8 ]
        self.dma                                = [ 4, 512, 8, 1, 2048]
        self.l1                                 = [ 16 , 128*1024]
        self.lic                                = [ [ 'rgb2hsv_cv' , 'hwpe'],
                                                    [ 'threshold_cv' , 'hwpe'],
                                                    [ 'erode_cv' , 'hwpe'],
                                                    [ 'dilate_cv' , 'hwpe']]
        self.hci                                = [ ]
        return self

    def cluster_6(self):
        self.core                               = [ 'riscy', 8 ]
        self.dma                                = [ 4, 512, 8, 1, 2048]
        self.l1                                 = [ 16 , 128*1024]
        self.lic                                = [ [ 'rgb2hsv_cv' , 'hwpe'],
                                                    [ 'threshold_cv' , 'hwpe'],
                                                    [ 'erode_cv' , 'hwpe'],
                                                    [ 'dilate_cv' , 'hwpe']]
        self.hci                                = [ ]
        return self

    def cluster_7(self):
        self.core                               = [ 'riscy', 8 ]
        self.dma                                = [ 4, 512, 8, 1, 2048]
        self.l1                                 = [ 16 , 128*1024]
        self.lic                                = [ [ 'rgb2hsv_cv' , 'hwpe'],
                                                    [ 'threshold_cv' , 'hwpe'],
                                                    [ 'erode_cv' , 'hwpe'],
                                                    [ 'dilate_cv' , 'hwpe']]
        self.hci                                = [ ]
        return self