########################################################
## Gianluca Bellocchi <gianluca.bellocchi@unimore.it> ##
########################################################

#!/usr/bin/env python3

# HWPE attributes
class hwpe_specs:

    # User knobs

    def author_k(self):
        # Engineer(-s)
        self.author                             = 'Gianluca Bellocchi'    
        self.email                              = '<gianluca.bellocchi@unimore.it>'
        return self

    def kernel_k(self):
        # Generic
        self.target                             = 'fir'
        self.design_type                        = 'hls'
        # Kernel design [ is_ap_ctrl_hs , is_mdc_dataflow ]
        self.intf_protocol                        = [ True , False ]
        return self

    def streaming_k(self):
        # HWPE streaming interfaces [ name , data-type , reg-dim , is_parallel , parallelism_factor]
        self.list_sink_stream                   = [ [ 'x_V' , 'int32_t' , 32 , False, 1 ] ]
        self.list_source_stream                 = [ [ 'y_V' , 'int32_t' , 32 , False, 1 ] ]
        return self

    def regfile_k(self):
        # HWPE standard regfiles
        self.std_reg_num                        = 4       
        # HWPE custom regfiles [ name , data-type , reg-dim , is_port ]
        self.custom_reg                         = [ [ 'c_0_V' , 'uint32_t' , 32 , 1 ] , 
                                                    [ 'c_1_V' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'c_2_V' , 'uint32_t' , 32 , 1 ] , 
                                                    [ 'c_3_V' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'c_4_V' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'c_5_V' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'c_6_V' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'c_7_V' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'c_8_V' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'c_9_V' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'c_10_V' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'c_11_V' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'c_12_V' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'c_13_V' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'c_14_V' , 'uint32_t' , 32 , 1 ] ,
                                                    [ 'c_15_V' , 'uint32_t' , 32 , 1 ] ]
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
        self.is_ap_ctrl_hs                      = self.intf_protocol[0]
        self.is_mdc_dataflow                    = self.intf_protocol[1]

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

