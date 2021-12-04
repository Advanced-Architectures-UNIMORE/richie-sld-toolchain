'''
 =====================================================================
 Project:      Traffic Generator
 Title:        hwpe_specs.py
 Description:  Specification file to guide the generation of HW/SW
	           components for hardware wrappers.

 Date:        12.11.2021
 ===================================================================== */

 Copyright (C) 2021 University of Modena and Reggio Emilia..

 Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.

'''

#!/usr/bin/env python3

# HWPE attributes
class acc_specs:

    # User knobs

    def author_k(self):
        # Engineer(-s)
        self.author                             = 'Gianluca Bellocchi'    
        self.email                              = '<gianluca.bellocchi@unimore.it>'
        return self

    def kernel_k(self):
        # Generic
        self.target                             = 'traffic_gen'
        self.design_type                        = 'hls'
        # Kernel design [ is_ap_ctrl_hs , is_mdc_dataflow ]
        self.intf_kernel                        = [ True , False ]
        return self

    def streaming_k(self):
        # HWPE streaming interfaces [ name , data-type , reg-dim , is_parallel , parallelism_factor]
        self.list_sink_stream                   = [ [ 'stream_in_V' , 'int32_t' , 32 , False , 1] ]
        self.list_source_stream                 = [ [ 'stream_out_V' , 'int32_t' , 32 , False , 1] ]
        return self

    def regfile_k(self):
        # HWPE standard regfiles
        self.std_reg_num                        = 4       
        # HWPE custom regfiles [ name , data-type , reg-dim , is_port ]
        self.custom_reg                         = [ [ 'n_trans' , 'int32_t' , 32 , 1 ] ,
                                                    [ 'prob_req' , 'int32_t' , 32 , 1 ] ]
        return self

    def addressgen_k(self):
        # Address generation [ is_programmable ]
        self.addr_gen_in                        = [ [True] ]
        self.addr_gen_out                       = [ [True] ]
        return self

    # ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

    # Additional parameters

    def kernel_d(self):
        # Kernel interface
        self.is_ap_ctrl_hs                      = self.intf_kernel[0]
        self.is_mdc_dataflow                    = self.intf_kernel[1]

    def streaming_d(self):    
        self.n_sink                             = len(self.list_sink_stream)
        self.n_source                           = len(self.list_source_stream)
        self.stream_in                          = [item[0] for item in self.list_sink_stream]
        self.stream_out                         = [item[0] for item in self.list_source_stream]
        self.stream_in_dtype                    = [item[1] for item in self.list_sink_stream]
        self.stream_out_dtype                   = [item[1] for item in self.list_source_stream]
        self.is_parallel_in                     = [item[3] for item in self.list_sink_stream]
        self.is_parallel_out                    = [item[3] for item in self.list_source_stream]
        self.in_parallelism_factor              = [item[4] for item in self.list_sink_stream]
        self.out_parallelism_factor             = [item[4] for item in self.list_source_stream]
        return self

    def regfile_d(self):    
        # HWPE custom regfiles
        self.custom_reg_name                    = [item[0] for item in self.custom_reg]
        self.custom_reg_dtype                   = [item[1] for item in self.custom_reg]
        self.custom_reg_dim                     = [item[2] for item in self.custom_reg]
        self.custom_reg_isport                  = [item[3] for item in self.custom_reg]
        self.custom_reg_num                     = len(self.custom_reg)
        return self

    def addressgen_d(self):
        # Address generation
        self.addr_gen_in_isprogr                = [item[0] for item in self.addr_gen_in]
        self.addr_gen_out_isprogr               = [item[0] for item in self.addr_gen_out]
        return self

    # ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

    def __init__(self):
        # user-defined
        self.author_k()
        self.kernel_k()
        self.streaming_k()
        self.regfile_k()
        self.addressgen_k()
        # derived
        self.kernel_d()
        self.streaming_d()
        self.regfile_d()
        self.addressgen_d()

    # ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

