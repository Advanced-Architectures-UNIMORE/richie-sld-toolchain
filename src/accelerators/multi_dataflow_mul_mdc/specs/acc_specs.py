'''
 =====================================================================
 Project:       MUL mdc
 Title:         acc_specs.py
 Description:   Specification file to guide the generation of HW/SW
	            components for hardware wrappers.

 Date:          25.1.2022
 ===================================================================== */

 Copyright (C) 2022 University of Modena and Reggio Emilia.

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
        ==========
        User knobs
        ==========
    '''

    '''
        Wrapper information

        - 'is_third_party' ~ Default value is False. If the wrapper is provided by 
        third-parties and thus not need to be generated, this variable can be set 
        to True. Under this event, the third-party wrapper can be inserted under
        rtl/ and will then be copied in the outer repository.
        
    '''

    def wrapper(self):
        self.is_third_party                     = False
        return self

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
        self.target                             = 'multi_dataflow_mul_mdc'
        self.design_type                        = 'hls'
        self.intf_protocol                      = 'mdc_dataflow'
        return self

    '''
        Streaming interface information:

        - 'list_sink_stream' ~ [ name , data-type , reg-dim , is_parallel , parallelism_factor]

        - 'list_source_stream' ~ [ name , data-type , reg-dim , is_parallel , parallelism_factor]
    '''

    def streaming(self):
        self.list_sink_stream                   = [ [ 'a' , 'int32_t' , 32 , False, 1 ] , [ 'b' , 'int32_t' , 32 , False, 1 ] , [ 'c' , 'int32_t' , 32 , False, 1 ] ]
        self.list_source_stream                 = [ [ 'd' , 'int32_t' , 32 , False, 1 ] ]
        return self

    '''
        Custom register file information:

        - 'std_reg_num' ~ Number of standard registers. Do not modify this unless you have specific
        templates of HWPE that support a different number of standard registers.

        - 'custom_reg' ~ [ name , data-type , reg-dim , is_port ]
    '''

    def regfile(self):
        self.std_reg_num                        = 4       
        self.custom_reg                         = [ [ 'reg_simple_mul' , 'int'     , 1  , 1 ] ,
                                                    [ 'reg_shift'      , 'int8_t'  , 8  , 1 ] ,
                                                    [ 'reg_len'        , 'int16_t' , 16 , 1 ] ]
        return self

    '''
        Address generator registers information:

        - 'addr_gen_in' ~ Set to 'True' if you want a programmable  address generator for input streams.

        - 'addr_gen_out' ~ Set to 'True' if you want a programmable  address generator for output streams.
    '''

    def addressgen(self):
        self.addr_gen_in                        = [ [True] , [True] , [True] ]
        self.addr_gen_out                       = [ [True] ]
        return self