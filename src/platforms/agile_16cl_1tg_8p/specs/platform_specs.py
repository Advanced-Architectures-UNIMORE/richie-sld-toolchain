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

    Title:          Platform specification file

    Description:    Specification file to guide the generation of a
                    specialized and optimized Accelerator-Rich HeSoC.

    Platform:       Multi-Cluster Integration of Traffic Generators

    Date:           20.4.2022

    Author: 		Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''

#!/usr/bin/env python3

class PlatformSpecs:

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
        HeSoC

        - 'name' ~ Name of this specific HeSoC instance
        - 'board' ~ Available boards:
            >> "zcu102"
            >> "zcu104"
            >> "ultra96_v2"
            >> "kv260"
        - 'l2' ~ [ n_banks, size (Bytes) ]
    '''

    def hesoc(self):
        self.name                               = 'agile_16cl_1tg_8p'
        self.board                              = 'zcu102'
        self.l2                                 = [ 8 , 128*1024*16]
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
        self.dma                                = [ 4, 32, 8, 1, 2048]
        self.l1                                 = [ 16 , 128*1024]
        self.lic                                = [ [ 'traffic_gen' , 'hwpe']]
        self.hci                                = [ ]
        return self

    def cluster_1(self):
        self.core                               = [ 'riscy', 8 ]
        self.dma                                = [ 4, 32, 8, 1, 2048]
        self.l1                                 = [ 16 , 128*1024]
        self.lic                                = [ [ 'traffic_gen' , 'hwpe']]
        self.hci                                = [ ]
        return self

    def cluster_2(self):
        self.core                               = [ 'riscy', 8 ]
        self.dma                                = [ 4, 32, 8, 1, 2048]
        self.l1                                 = [ 16 , 128*1024]
        self.lic                                = [ [ 'traffic_gen' , 'hwpe']]
        self.hci                                = [ ]
        return self

    def cluster_3(self):
        self.core                               = [ 'riscy', 8 ]
        self.dma                                = [ 4, 32, 8, 1, 2048]
        self.l1                                 = [ 16 , 128*1024]
        self.lic                                = [ [ 'traffic_gen' , 'hwpe']]
        self.hci                                = [ ]
        return self

    def cluster_4(self):
        self.core                               = [ 'riscy', 8 ]
        self.dma                                = [ 4, 32, 8, 1, 2048]
        self.l1                                 = [ 16 , 128*1024]
        self.lic                                = [ [ 'traffic_gen' , 'hwpe']]
        self.hci                                = [ ]
        return self

    def cluster_5(self):
        self.core                               = [ 'riscy', 8 ]
        self.dma                                = [ 4, 32, 8, 1, 2048]
        self.l1                                 = [ 16 , 128*1024]
        self.lic                                = [ [ 'traffic_gen' , 'hwpe']]
        self.hci                                = [ ]
        return self

    def cluster_6(self):
        self.core                               = [ 'riscy', 8 ]
        self.dma                                = [ 4, 32, 8, 1, 2048]
        self.l1                                 = [ 16 , 128*1024]
        self.lic                                = [ [ 'traffic_gen' , 'hwpe']]
        self.hci                                = [ ]
        return self

    def cluster_7(self):
        self.core                               = [ 'riscy', 8 ]
        self.dma                                = [ 4, 32, 8, 1, 2048]
        self.l1                                 = [ 16 , 128*1024]
        self.lic                                = [ [ 'traffic_gen' , 'hwpe']]
        self.hci                                = [ ]
        return self

    def cluster_8(self):
        self.core                               = [ 'riscy', 8 ]
        self.dma                                = [ 4, 32, 8, 1, 2048]
        self.l1                                 = [ 16 , 128*1024]
        self.lic                                = [ [ 'traffic_gen' , 'hwpe']]
        self.hci                                = [ ]
        return self

    def cluster_9(self):
        self.core                               = [ 'riscy', 8 ]
        self.dma                                = [ 4, 32, 8, 1, 2048]
        self.l1                                 = [ 16 , 128*1024]
        self.lic                                = [ [ 'traffic_gen' , 'hwpe']]
        self.hci                                = [ ]
        return self

    def cluster_10(self):
        self.core                               = [ 'riscy', 8 ]
        self.dma                                = [ 4, 32, 8, 1, 2048]
        self.l1                                 = [ 16 , 128*1024]
        self.lic                                = [ [ 'traffic_gen' , 'hwpe']]
        self.hci                                = [ ]
        return self

    def cluster_11(self):
        self.core                               = [ 'riscy', 8 ]
        self.dma                                = [ 4, 32, 8, 1, 2048]
        self.l1                                 = [ 16 , 128*1024]
        self.lic                                = [ [ 'traffic_gen' , 'hwpe']]
        self.hci                                = [ ]
        return self

    def cluster_12(self):
        self.core                               = [ 'riscy', 8 ]
        self.dma                                = [ 4, 32, 8, 1, 2048]
        self.l1                                 = [ 16 , 128*1024]
        self.lic                                = [ [ 'traffic_gen' , 'hwpe']]
        self.hci                                = [ ]
        return self

    def cluster_13(self):
        self.core                               = [ 'riscy', 8 ]
        self.dma                                = [ 4, 32, 8, 1, 2048]
        self.l1                                 = [ 16 , 128*1024]
        self.lic                                = [ [ 'traffic_gen' , 'hwpe']]
        self.hci                                = [ ]
        return self

    def cluster_14(self):
        self.core                               = [ 'riscy', 8 ]
        self.dma                                = [ 4, 32, 8, 1, 2048]
        self.l1                                 = [ 16 , 128*1024]
        self.lic                                = [ [ 'traffic_gen' , 'hwpe']]
        self.hci                                = [ ]
        return self

    def cluster_15(self):
        self.core                               = [ 'riscy', 8 ]
        self.dma                                = [ 4, 32, 8, 1, 2048]
        self.l1                                 = [ 16 , 128*1024]
        self.lic                                = [ [ 'traffic_gen' , 'hwpe']]
        self.hci                                = [ ]
        return self
