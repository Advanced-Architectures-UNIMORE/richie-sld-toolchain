'''
 =====================================================================
 Project:       Matrix Multiplication
 Title:         acc_specs.py
 Description:   Specification file to guide the generation of HW/SW
	            components for hardware wrappers.

 Date:          17.12.2021
 ===================================================================== */

 Copyright (C) 2021 University of Modena and Reggio Emilia.

 Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.

'''

#!/usr/bin/env python3

class acc_specs:

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
        Kernel information:

        - 'target' ~ Acceleration kernel. This the target of the hardware wrapper generator.

        - 'design_type' ~ Design methodology employed to construct the acceleration kernel. 
        Handcrafted HDL (set 'hdl') and HLS-compiled (set 'hls') methods are supported.

        - 'intf_protocol' ~ Selection of interface between acceleration kernel and wrapper. Set 
        the desired interface as 'True', while leaving the others set to 'False'. Now the proposed
        methodology supports:
            
            > 'ap_ctrl_hs' - Xilinx ap_ctrl_hs (refer to UG902)
            > 'mdc_dataflow' - MDC dataflow
            > 'hls_stream' - Xilinx hls::stream object (refer to AMBA 4 AXI4-Stream Protocol)
    '''

    def kernel(self):
        self.target                             = 'mmult_opt'
        self.design_type                        = 'hls'
        self.intf_protocol                      = 'ap_ctrl_hs'
        return self

    '''
        Streaming interface information:

        - 'list_sink_stream' ~ [ name , data-type , reg-dim , is_parallel , parallelism_factor]

        - 'list_source_stream' ~ [ name , data-type , reg-dim , is_parallel , parallelism_factor]
    '''

    def streaming(self):
        self.list_sink_stream   = [ [ 'in1' , 'int32_t' , 32 , False, 1 ] , [ 'in2' , 'int32_t' , 32 , False, 1 ] ]
        self.list_source_stream = [ [ 'out_r' , 'int32_t' , 32 , False, 1 ] ]
        return self

    '''
        Custom register file information:

        - 'std_reg_num' ~ Number of standard registers. Do not modify this unless you have specific
        templates of HWPE that support a different number of standard registers.

        - 'custom_reg' ~ [ name , data-type , reg-dim , is_port ]
    '''

    def regfile(self):
        self.std_reg_num        = 4
        self.custom_reg         = [ ]
        return self

    '''
        Address generator registers information:

        - 'addr_gen_in' ~ Set to 'True' if you want a programmable  address generator for input streams.

        - 'addr_gen_out' ~ Set to 'True' if you want a programmable  address generator for output streams.
    '''

    def addressgen(self):
        self.addr_gen_in        = [ [True] , [True] ]
        self.addr_gen_out       = [ [True] ]
        return self

    # ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

    '''
        Additional parameters taht are derived from the user-defined ones. Do not modify this part.
    '''

    '''
        Derived kernel information
    '''

    def kernel_d(self):
        self.is_ap_ctrl_hs                      = self.intf_protocol[0]
        self.is_mdc_dataflow                    = self.intf_protocol[1]

    '''
        Derived streaming interface information
    '''

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

    '''
        Derived custom register file information
    '''

    def regfile_d(self):    
        self.custom_reg_name                    = [item[0] for item in self.custom_reg]
        self.custom_reg_dtype                   = [item[1] for item in self.custom_reg]
        self.custom_reg_dim                     = [item[2] for item in self.custom_reg]
        self.custom_reg_isport                  = [item[3] for item in self.custom_reg]
        self.custom_reg_num                     = len(self.custom_reg)
        return self

    '''
        Derived address generator registers information
    '''

    def addressgen_d(self):
        self.addr_gen_in_isprogr                = [item[0] for item in self.addr_gen_in]
        self.addr_gen_out_isprogr               = [item[0] for item in self.addr_gen_out]
        return self

    # ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

    def __init__(self):
        # user-defined
        self.author()
        self.kernel()
        self.streaming()
        self.regfile()
        self.addressgen()
        # derived
        self.kernel_d()
        self.streaming_d()
        self.regfile_d()
        self.addressgen_d()

    # ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ #

