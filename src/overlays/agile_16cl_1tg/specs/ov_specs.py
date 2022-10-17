'''
 =====================================================================
 Project:       GenOv
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
        self.name                               = 'agile_16cl_1tg'
        self.board                              = 'zcu102'
        self.l2                                 = [ 1 , 128*1024*128]
        return self

    '''
        Clusters

        - 'core' ~ [ core_name, n_cores ]
        - 'l1' ~ [ n_banks, size (Bytes) ]
        - 'lic' ~ [ acc_name , wrapper_protocol ]
        - 'hci' ~ [ acc_name , wrapper_protocol ]
    '''

    def cluster_0(self):
        self.core                               = [ 'riscy', 8 ]
        self.l1                                 = [ 16 , 128*1024]
        self.lic                                = [ [ 'traffic_gen' , 'hwpe']]
        self.hci                                = [ ]
        return self

    def cluster_1(self):
        self.core                               = [ 'riscy', 8 ]
        self.l1                                 = [ 16 , 128*1024]
        self.lic                                = [ [ 'traffic_gen' , 'hwpe']]
        self.hci                                = [ ]
        return self

    def cluster_2(self):
        self.core                               = [ 'riscy', 8 ]
        self.l1                                 = [ 16 , 128*1024]
        self.lic                                = [ [ 'traffic_gen' , 'hwpe']]
        self.hci                                = [ ]
        return self

    def cluster_3(self):
        self.core                               = [ 'riscy', 8 ]
        self.l1                                 = [ 16 , 128*1024]
        self.lic                                = [ [ 'traffic_gen' , 'hwpe']]
        self.hci                                = [ ]
        return self

    def cluster_4(self):
        self.core                               = [ 'riscy', 8 ]
        self.l1                                 = [ 16 , 128*1024]
        self.lic                                = [ [ 'traffic_gen' , 'hwpe']]
        self.hci                                = [ ]
        return self

    def cluster_5(self):
        self.core                               = [ 'riscy', 8 ]
        self.l1                                 = [ 16 , 128*1024]
        self.lic                                = [ [ 'traffic_gen' , 'hwpe']]
        self.hci                                = [ ]
        return self

    def cluster_6(self):
        self.core                               = [ 'riscy', 8 ]
        self.l1                                 = [ 16 , 128*1024]
        self.lic                                = [ [ 'traffic_gen' , 'hwpe']]
        self.hci                                = [ ]
        return self

    def cluster_7(self):
        self.core                               = [ 'riscy', 8 ]
        self.l1                                 = [ 16 , 128*1024]
        self.lic                                = [ [ 'traffic_gen' , 'hwpe']]
        self.hci                                = [ ]
        return self

    def cluster_8(self):
        self.core                               = [ 'riscy', 8 ]
        self.l1                                 = [ 16 , 128*1024]
        self.lic                                = [ [ 'traffic_gen' , 'hwpe']]
        self.hci                                = [ ]
        return self

    def cluster_9(self):
        self.core                               = [ 'riscy', 8 ]
        self.l1                                 = [ 16 , 128*1024]
        self.lic                                = [ [ 'traffic_gen' , 'hwpe']]
        self.hci                                = [ ]
        return self

    def cluster_10(self):
        self.core                               = [ 'riscy', 8 ]
        self.l1                                 = [ 16 , 128*1024]
        self.lic                                = [ [ 'traffic_gen' , 'hwpe']]
        self.hci                                = [ ]
        return self

    def cluster_11(self):
        self.core                               = [ 'riscy', 8 ]
        self.l1                                 = [ 16 , 128*1024]
        self.lic                                = [ [ 'traffic_gen' , 'hwpe']]
        self.hci                                = [ ]
        return self

    def cluster_12(self):
        self.core                               = [ 'riscy', 8 ]
        self.l1                                 = [ 16 , 128*1024]
        self.lic                                = [ [ 'traffic_gen' , 'hwpe']]
        self.hci                                = [ ]
        return self

    def cluster_13(self):
        self.core                               = [ 'riscy', 8 ]
        self.l1                                 = [ 16 , 128*1024]
        self.lic                                = [ [ 'traffic_gen' , 'hwpe']]
        self.hci                                = [ ]
        return self

    def cluster_14(self):
        self.core                               = [ 'riscy', 8 ]
        self.l1                                 = [ 16 , 128*1024]
        self.lic                                = [ [ 'traffic_gen' , 'hwpe']]
        self.hci                                = [ ]
        return self

    def cluster_15(self):
        self.core                               = [ 'riscy', 8 ]
        self.l1                                 = [ 16 , 128*1024]
        self.lic                                = [ [ 'traffic_gen' , 'hwpe']]
        self.hci                                = [ ]
        return self