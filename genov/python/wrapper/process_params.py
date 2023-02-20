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

'''
  =====================================================================
  Title:        wrapper_params_formetted
  Type:         Class
  Description:  Format accelerator wrapper design parameters. The output 
                content is formatted in a suitable way for template to be 
                easilyrendered.
  =====================================================================
'''

class wrapper_params_formatted:

    def __init__(self, acc_specs):
        self.format_wrapper(acc_specs().wrapper)
        self.format_wrapper_author(acc_specs().author)
        self.format_wrapper_kernel(acc_specs().kernel)
        self.format_wrapper_streaming(acc_specs().streaming)
        self.format_wrapper_regfile(acc_specs().regfile)
        self.format_wrapper_addressgen(acc_specs().addressgen)

    '''
        Format wrapper general information.
    '''

    def format_wrapper(self, acc_specs):
        self.is_third_party                     = acc_specs().is_third_party
        return self

    '''
        Format author information.
    '''

    def format_wrapper_author(self, acc_specs):
        self.author                             = acc_specs().author
        self.email                              = acc_specs().email
        return self

    '''
        Format kernel information.
    '''

    def format_wrapper_kernel(self, acc_specs):
        self.target                             = acc_specs().target
        self.design_type                        = acc_specs().design_type
        self.is_ap_ctrl_hs                      = acc_specs().intf_protocol == 'ap_ctrl_hs'
        self.is_mdc_dataflow                    = acc_specs().intf_protocol == 'mdc_dataflow'
        self.is_hls_stream                      = acc_specs().intf_protocol == 'hls_stream'
        return self

    '''
        Format streaming interface information
    '''

    def format_wrapper_streaming(self, acc_specs):    
        self.n_sink                             = len(acc_specs().list_sink_stream)
        self.n_source                           = len(acc_specs().list_source_stream)
        self.stream_in                          = [item[0] for item in acc_specs().list_sink_stream]
        self.stream_out                         = [item[0] for item in acc_specs().list_source_stream]
        self.stream_in_dtype                    = [item[1] for item in acc_specs().list_sink_stream]
        self.stream_out_dtype                   = [item[1] for item in acc_specs().list_source_stream]
        self.stream_in_dwidth                   = [item[2] for item in acc_specs().list_sink_stream]
        self.stream_out_dwidth                  = [item[2] for item in acc_specs().list_source_stream]
        self.is_parallel_in                     = [item[3] for item in acc_specs().list_sink_stream]
        self.is_parallel_out                    = [item[3] for item in acc_specs().list_source_stream]
        self.in_parallelism_factor              = [item[4] for item in acc_specs().list_sink_stream]
        self.out_parallelism_factor             = [item[4] for item in acc_specs().list_source_stream]
        return self

    '''
        Format custom register file information
    '''

    def format_wrapper_regfile(self, acc_specs):    
        self.std_reg_num                        = acc_specs().std_reg_num
        self.custom_reg_name                    = [item[0] for item in acc_specs().custom_reg]
        self.custom_reg_dtype                   = [item[1] for item in acc_specs().custom_reg]
        self.custom_reg_dim                     = [item[2] for item in acc_specs().custom_reg]
        self.custom_reg_isport                  = [item[3] for item in acc_specs().custom_reg]
        self.custom_reg_num                     = len(acc_specs().custom_reg)
        return self

    '''
        Format address generator registers information
    '''

    def format_wrapper_addressgen(self, acc_specs):
        self.addr_gen_in_isprogr                = [item[0] for item in acc_specs().addr_gen_in]
        self.addr_gen_out_isprogr               = [item[0] for item in acc_specs().addr_gen_out]
        return self

'''
  =====================================================================
  Title:        print_wrapper_log
  Type:         Function
  Description:  Print wrapper information.
  =====================================================================
'''

def print_wrapper_log(wrapper_target, verbose=False):

    print("\n# ================================= #")
    print("# Generation of Accelerator Wrapper #")
    print("# ================================= #")

    if(verbose is True):

        print("\n")
        print("[py] >> User-defined wrapper specification:")

        '''
            Kernel information
        '''

        print("\n\tKernel application:")

        print("\t\tTarget name:", wrapper_target.target)
        print("\t\tDesign Methodology:", wrapper_target.design_type)

        if(wrapper_target.is_ap_ctrl_hs is True):
            print("\t\tInterface: Xilinx ap_ctrl_hs")

        if(wrapper_target.is_mdc_dataflow is True):
            print("\t\tInterface: MDC dataflow")

        '''
            Streamer information
        '''

        print("\n\tInput data streams:")
        
        # scan sink ports
        for s in range(wrapper_target.n_sink):
            print("\t\tPort name:", wrapper_target.stream_in[s])
            if wrapper_target.is_parallel_in[s] is True:
                print("\t\tNumber of ports:", wrapper_target.in_parallelism_factor[s])
            else:
                print("\t\tNumber of ports:", 1)
            print("\t\tConfigurable address generator:", wrapper_target.addr_gen_in_isprogr[s])
            if(s < wrapper_target.n_sink - 1):
                print("")

        print("\n\tOutput data streams:")

        # scan source ports
        for s in range(wrapper_target.n_source):
            print("\t\tPort name:", wrapper_target.stream_out[s])
            if wrapper_target.is_parallel_out[s] is True:
                print("\t\tNumber of ports:", wrapper_target.out_parallelism_factor[s])
            else:
                print("\t\tNumber of ports:", 1)
            print("\t\tConfigurable address generator:", wrapper_target.addr_gen_out_isprogr[s])
            if(s < wrapper_target.n_source - 1):
                print("")

        '''
            Controller information
        '''

        print("\n\tRegister file:")
        print("\t\tCustom register names:", wrapper_target.custom_reg_name)

'''
  =====================================================================
  Title:        print_wrapper_test_log
  Type:         Function
  Description:  Print wrapper test information.
  =====================================================================
'''

def print_wrapper_test_log(wrapper_target, verbose=False):

    print("\n# ===================================================== #")
    print("# Generation of Standalone Test for Accelerator Wrapper #")
    print("# ===================================================== #")

    if(verbose is True):

        print("\n")
        print("[py] >> User-defined wrapper specification:")

        print("\nTarget name:", wrapper_target.target)