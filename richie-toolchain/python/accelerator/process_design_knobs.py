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

    Title:          Processing Accelerator Design Knobs

    Description:    Accelerator Design Knobs are formatted to streamline
                    the subsequent rendering phase, where a specialized
                    HW/SW accelerator interface is generated.

    Date:           8.1.2022

    Author: 		Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''

'''
  =====================================================================
  Title:        AcceleratorDesignKnobsFormatted
  Type:         Class
  Description:  Format the design knobs of the accelerator interface.
                The output content is formatted to streamline the
                subsequent rendering phase.
  =====================================================================
'''

class AcceleratorDesignKnobsFormatted:

    def __init__(self, accelerator_specs):
        self.format_wrapper(accelerator_specs().wrapper)
        self.format_wrapper_author(accelerator_specs().author)
        self.format_wrapper_kernel(accelerator_specs().kernel)
        self.format_wrapper_streaming(accelerator_specs().streaming)
        self.format_wrapper_regfile(accelerator_specs().regfile)
        self.format_wrapper_addressgen(accelerator_specs().addressgen)

    '''
        Format wrapper general information.
    '''

    def format_wrapper(self, accelerator_specs):
        self.is_third_party                     = accelerator_specs().is_third_party
        return self

    '''
        Format author information.
    '''

    def format_wrapper_author(self, accelerator_specs):
        self.author                             = accelerator_specs().author
        self.email                              = accelerator_specs().email
        return self

    '''
        Format kernel information.
    '''

    def format_wrapper_kernel(self, accelerator_specs):
        self.target                             = accelerator_specs().target
        self.design_type                        = accelerator_specs().design_type
        self.is_ap_ctrl_hs                      = accelerator_specs().intf_protocol == 'ap_ctrl_hs'
        self.is_mdc_dataflow                    = accelerator_specs().intf_protocol == 'mdc_dataflow'
        self.is_hls_stream                      = accelerator_specs().intf_protocol == 'hls_stream'
        return self

    '''
        Format streaming interface information
    '''

    def format_wrapper_streaming(self, accelerator_specs):
        self.n_sink                             = len(accelerator_specs().list_sink_stream)
        self.n_source                           = len(accelerator_specs().list_source_stream)
        self.stream_in                          = [item[0] for item in accelerator_specs().list_sink_stream]
        self.stream_out                         = [item[0] for item in accelerator_specs().list_source_stream]
        self.stream_in_dtype                    = [item[1] for item in accelerator_specs().list_sink_stream]
        self.stream_out_dtype                   = [item[1] for item in accelerator_specs().list_source_stream]
        self.stream_in_dwidth                   = [item[2] for item in accelerator_specs().list_sink_stream]
        self.stream_out_dwidth                  = [item[2] for item in accelerator_specs().list_source_stream]
        self.is_parallel_in                     = [item[3] for item in accelerator_specs().list_sink_stream]
        self.is_parallel_out                    = [item[3] for item in accelerator_specs().list_source_stream]
        self.in_parallelism_factor              = [item[4] for item in accelerator_specs().list_sink_stream]
        self.out_parallelism_factor             = [item[4] for item in accelerator_specs().list_source_stream]
        return self

    '''
        Format custom register file information
    '''

    def format_wrapper_regfile(self, accelerator_specs):
        self.std_reg_num                        = accelerator_specs().std_reg_num
        self.custom_reg_name                    = [item[0] for item in accelerator_specs().custom_reg]
        self.custom_reg_dtype                   = [item[1] for item in accelerator_specs().custom_reg]
        self.custom_reg_dim                     = [item[2] for item in accelerator_specs().custom_reg]
        self.custom_reg_isport                  = [item[3] for item in accelerator_specs().custom_reg]
        self.custom_reg_num                     = len(accelerator_specs().custom_reg)
        return self

    '''
        Format address generator registers information
    '''

    def format_wrapper_addressgen(self, accelerator_specs):
        self.addr_gen_in_isprogr                = [item[0] for item in accelerator_specs().addr_gen_in]
        self.addr_gen_out_isprogr               = [item[0] for item in accelerator_specs().addr_gen_out]
        return self

'''
  =====================================================================
  Title:        print_wrapper_log
  Type:         Function
  Description:  Print wrapper information.
  =====================================================================
'''

def print_wrapper_log(design_knobs, verbose=False):

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

        print("\t\tTarget name:", design_knobs.target)
        print("\t\tDesign Methodology:", design_knobs.design_type)

        if(design_knobs.is_ap_ctrl_hs is True):
            print("\t\tInterface: Xilinx ap_ctrl_hs")

        if(design_knobs.is_mdc_dataflow is True):
            print("\t\tInterface: MDC dataflow")

        '''
            Streamer information
        '''

        print("\n\tInput data streams:")

        # scan sink ports
        for s in range(design_knobs.n_sink):
            print("\t\tPort name:", design_knobs.stream_in[s])
            if design_knobs.is_parallel_in[s] is True:
                print("\t\tNumbedesign_knobsr of ports:", design_knobs.in_parallelism_factor[s])
            else:
                print("\t\tNumber of ports:", 1)
            print("\t\tConfigurable address generator:", design_knobs.addr_gen_in_isprogr[s])
            if(s < design_knobs.n_sink - 1):
                print("")

        print("\n\tOutput data streams:")

        # scan source ports
        for s in range(design_knobs.n_source):
            print("\t\tPort name:", design_knobs.stream_out[s])
            if design_knobs.is_parallel_out[s] is True:
                print("\t\tNumber of ports:", design_knobs.out_parallelism_factor[s])
            else:
                print("\t\tNumber of ports:", 1)
            print("\t\tConfigurable address generator:", design_knobs.addr_gen_out_isprogr[s])
            if(s < design_knobs.n_source - 1):
                print("")

        '''
            Controller information
        '''

        print("\n\tRegister file:")
        print("\t\tCustom register names:", design_knobs.custom_reg_name)

'''
  =====================================================================
  Title:        print_generation_log
  Type:         Function
  Description:  Print generation log.
  =====================================================================
'''

def print_generation_log(design_knobs, verbose=False):

    print("\n# ===================================================== #")
    print("# Generation of Standalone Test for Accelerator Wrapper #")
    print("# ===================================================== #")

    if(verbose is True):

        print("\n")
        print("[py] >> User-defined wrapper specification:")

        print("\nTarget name:", design_knobs.target)
