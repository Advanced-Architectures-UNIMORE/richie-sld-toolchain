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

    Title:          Formatter

    Description:    Platform and Accelerator Design Knobs are formatted
                    to streamline the subsequent rendering phase, where
                    a specialized Accelerator-Rich HeSoC is generated.

    Date:           8.1.2022

    Author: 		Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''

import math
from importlib import import_module

'''
    =====================================================================
    Title:        Formatter
    Type:         Class
    Description:  Format the design knobs and retrieve additional parameters
                  to perform the subsequent rendering phase.
    =====================================================================
'''

class Formatter:

    '''
        Top methods that return formatted design knobs.
    '''

    def platform(self, platform_specs_raw):
        self.format_platform_author(platform_specs_raw().author)
        self.format_platform_hesoc(platform_specs_raw().hesoc)
        self.format_platform_cluster(platform_specs_raw())
        return self

    def accelerator(self, accelerator_specs_raw):
        self.format_accelerator_wrapper(accelerator_specs_raw().wrapper)
        self.format_accelerator_author(accelerator_specs_raw().author)
        self.format_accelerator_datapath(accelerator_specs_raw().datapath)
        self.format_accelerator_streaming(accelerator_specs_raw().streaming)
        self.format_accelerator_regfile(accelerator_specs_raw().regfile)
        self.format_accelerator_addressgen(accelerator_specs_raw().addressgen)
        return self

    '''
        Methods to format platform design knobs.
    '''

    def format_platform_author(self, author_specs_raw):
        self.author                             = author_specs_raw().author
        self.email                              = author_specs_raw().email

    def format_platform_hesoc(self, hesoc_specs_raw):
        self.hesoc_name                         = hesoc_specs_raw().name
        self.n_clusters                         = get_n_cl(hesoc_specs_raw())
        self.target_fpga_board                  = hesoc_specs_raw().board
        self.target_fpga_hesoc                  = get_target_hesoc(hesoc_specs_raw().board)
        self.l2                                 = hesoc_specs_raw().l2
        self.aw                                 = 64
        self.dw                                 = 128
        self.iw                                 = 3 + clog2(self.n_clusters+1)
        self.uw                                 = 4
        self.aw_pl2ps                           = 49
        self.iw_pl2ps                           = 5
        self.uw_pl2ps                           = 1
        self.aw_ps2pl                           = 40
        self.iw_ps2pl                           = 17
        self.uw_ps2pl                           = 16
        self.aw_lite                            = 32
        self.dw_lite                            = 32

    def format_platform_cluster(self, platform_specs_raw):
        cl_list = get_cl_targets_list(platform_specs_raw)
        # cores
        self.list_cl_cores = []
        for cl_target in cl_list:
            self.list_cl_cores.append(format_cl_core_design_knobs(cl_target().core))
        # DMA
        self.list_cl_dma = []
        for cl_target in cl_list:
            self.list_cl_dma.append(format_cl_dma_design_knobs(cl_target().dma))
        # L1 data memory
        self.list_cl_l1 = []
        for cl_target in cl_list:
            self.list_cl_l1.append(format_cl_l1_design_knobs(cl_target().l1))
        # hardware accelerators
        self.list_cl_lic = []
        self.list_cl_hci = []
        for cl_target in cl_list:
            self.list_cl_lic.append(self.format_cl_acc_design_knobs(cl_target().lic))
            self.list_cl_hci.append(self.format_cl_acc_design_knobs(cl_target().hci))

    '''
        Methods to format accelerator design knobs.
    '''

    def format_accelerator_wrapper(self, accelerator_specs_raw):
        self.is_third_party                     = accelerator_specs_raw().is_third_party
        return self

    def format_accelerator_author(self, author_specs_raw):
        self.author                             = author_specs_raw().author
        self.email                              = author_specs_raw().email
        return self

    def format_accelerator_datapath(self, datapath_specs_raw):
        self.target                             = datapath_specs_raw().target
        self.design_type                        = datapath_specs_raw().design_type
        self.is_ap_ctrl_hs                      = datapath_specs_raw().intf_protocol == 'ap_ctrl_hs'
        self.is_mdc_dataflow                    = datapath_specs_raw().intf_protocol == 'mdc_dataflow'
        self.is_hls_stream                      = datapath_specs_raw().intf_protocol == 'hls_stream'
        return self

    def format_accelerator_streaming(self, streaming_specs_raw):
        self.n_sink                             = len(streaming_specs_raw().list_sink_stream)
        self.n_source                           = len(streaming_specs_raw().list_source_stream)
        self.stream_in                          = [item[0] for item in streaming_specs_raw().list_sink_stream]
        self.stream_out                         = [item[0] for item in streaming_specs_raw().list_source_stream]
        self.stream_in_dtype                    = [item[1] for item in streaming_specs_raw().list_sink_stream]
        self.stream_out_dtype                   = [item[1] for item in streaming_specs_raw().list_source_stream]
        self.stream_in_dwidth                   = [item[2] for item in streaming_specs_raw().list_sink_stream]
        self.stream_out_dwidth                  = [item[2] for item in streaming_specs_raw().list_source_stream]
        self.is_parallel_in                     = [item[3] for item in streaming_specs_raw().list_sink_stream]
        self.is_parallel_out                    = [item[3] for item in streaming_specs_raw().list_source_stream]
        self.in_parallelism_factor              = [item[4] for item in streaming_specs_raw().list_sink_stream]
        self.out_parallelism_factor             = [item[4] for item in streaming_specs_raw().list_source_stream]
        return self

    def format_accelerator_regfile(self, regfile_specs_raw):
        self.std_reg_num                        = regfile_specs_raw().std_reg_num
        self.custom_reg_name                    = [item[0] for item in regfile_specs_raw().custom_reg]
        self.custom_reg_dtype                   = [item[1] for item in regfile_specs_raw().custom_reg]
        self.custom_reg_dim                     = [item[2] for item in regfile_specs_raw().custom_reg]
        self.custom_reg_isport                  = [item[3] for item in regfile_specs_raw().custom_reg]
        self.custom_reg_num                     = len(regfile_specs_raw().custom_reg)
        return self

    def format_accelerator_addressgen(self, addressgen_specs_raw):
        self.addr_gen_in_isprogr                = [item[0] for item in addressgen_specs_raw().addr_gen_in]
        self.addr_gen_out_isprogr               = [item[0] for item in addressgen_specs_raw().addr_gen_out]
        return self

    '''
        =====================================================================
        Title:          get_acc_targets
        Type:           Method
        Description:    This method derives the information concerning the
                        accelerator datapaths for which an interface is to be
                        generated (and of which type, e.g., HWPE-based).
        =====================================================================
    '''

    def get_acc_targets(self, platform_design_knobs):

        # list of distinct targsts to be derived
        hwpe_gen_list = []

        for i in range(platform_design_knobs.n_clusters):

            cl_lic_acc_names = platform_design_knobs.list_cl_lic[i][1]
            cl_hci_acc_names = platform_design_knobs.list_cl_hci[i][1]

            cl_lic_acc_protocols = platform_design_knobs.list_cl_lic[i][2]
            cl_hci_acc_protocols = platform_design_knobs.list_cl_hci[i][2]

            # Count number of accelerator interfaces
            n_acc_cl_lic = len(cl_lic_acc_names)
            n_acc_cl_hci = len(cl_hci_acc_names)

            # Define accelerator list to keep track of generated
            # accelerator interfaces and avoid duplicated definitions
            is_hwpe_duplicate = False

            # check accelerators connected to LIC interconnect
            for i in range(n_acc_cl_lic):

                # Search for duplicates
                for hwpe_gen in hwpe_gen_list:
                    if (cl_lic_acc_names[i]==hwpe_gen):
                        is_hwpe_duplicate = True

                # If no duplicates are found, then insert
                # the accelerator interface that will be
                # soon generated in the list
                if (is_hwpe_duplicate==False):
                    if (cl_lic_acc_protocols[i] == "hwpe"):
                        hwpe_gen_list.append(cl_lic_acc_names[i])

                is_hwpe_duplicate = False

            # check accelerators connected to HCI interconnect

            for i in range(n_acc_cl_hci):

                # Search for duplicates

                for hwpe_gen in hwpe_gen_list:
                    if (cl_hci_acc_names[i]==hwpe_gen):
                        is_hwpe_duplicate = True

                # If no duplicates are found, then insert
                # the accelerator interface that will be
                # soon generated in the list

                if (is_hwpe_duplicate==False):
                    if (cl_hci_acc_protocols[i] == "hwpe"):
                        hwpe_gen_list.append(cl_hci_acc_names[i])

                is_hwpe_duplicate = False

        return hwpe_gen_list

    '''
        =====================================================================
        Title:        import_accelerator_design_knobs
        Type:         Method
        Description:  Import accelerator design knobs for the generator to
                      generate a specialized HW/SW accelerator interface.
        =====================================================================
    '''

    def import_accelerator_design_knobs(self, target_acc):
        module_name = "dev.accelerator_dev." + target_acc + ".specs.accelerator_specs"
        accelerator_specs = import_module(module_name)
        return accelerator_specs

    '''
        =====================================================================
        Title:        format_cl_acc_design_knobs
        Type:         Method
        Description:  Target a specific cluster interconnection and extract
                      and format accelerator design knobs. The output
                      content is formatted in a suitable way for template to
                      be easily rendered.
        =====================================================================
    '''

    def format_cl_acc_design_knobs(self, cl_target_interco):
        total_data_ports    = 0
        acc_names           = []
        acc_protocols       = []
        acc_n_data_ports    = []

        for acc in cl_target_interco:
            # retrieve accelerator name
            acc_names.append(acc[0])
            # retrieve accelerator communication protocol
            acc_protocols.append(acc[1])
            # retrieve number of accelerator data ports
            accelerator_specs_raw_module = self.import_accelerator_design_knobs(acc_names[-1])
            accelerator_specs_raw = accelerator_specs_raw_module.AcceleratorSpecs
            # format accelerator design knobs
            accelerator_specs = Formatter().accelerator(accelerator_specs_raw)
            # accelerator_specs_raw = AcceleratorDesignKnobsFormatted(accelerator_specs.AcceleratorSpecs)
            # extract data ports
            acc_n_data_ports.append(calc_cl_acc_data_ports(accelerator_specs))
        # calculate total number of data ports
        for n in acc_n_data_ports:
            total_data_ports += n

        return total_data_ports, acc_names, acc_protocols, acc_n_data_ports

'''
    =====================================================================
    Title:        get_cl_targets_list
    Type:         Function
    Description:  Extract cluster methods.
    =====================================================================
'''

def get_cl_targets_list(platform_specs_raw):
    attribute_list = []
    targets_list = []
    for attribute in dir(platform_specs_raw):
        if attribute not in attribute_list:
            if "cluster_" in attribute:
                attribute_list.append(attribute)
                method = getattr(platform_specs_raw, attribute)
                targets_list.append(method)
    return targets_list

'''
    =====================================================================
    Title:        get_n_cl
    Type:         Function
    Description:  Derive number of clusters.
    =====================================================================
'''

def get_n_cl(hesoc_specs_raw):
    return len(get_cl_targets_list(hesoc_specs_raw))

'''
    =====================================================================
    Title:        get_target_hesoc
    Type:         Function
    Description:  Derive number of clusters.
    =====================================================================
'''

def get_target_hesoc(target_hesoc_board):
    hesoc_dict = {
        "zcu102": "xilzu9eg",
        "zcu104": "xilzu7ev",
        "ultra96_v2": "xilzu3eg",
        "kv260": "xilk26"
        }
    return hesoc_dict[target_hesoc_board]

'''
    =====================================================================
    Title:        get_acc_info
    Type:         Function
    Description:  Derive information concerning the generation of the
                  accelerator interfaces.
    =====================================================================
'''

def get_acc_info(platform_specs_raw):
    target_cl = get_cl_targets_list(platform_specs_raw)
    target_acc = []
    n_acc = 0
    for m in target_cl:
        for acc in m().lic:
            acc_name = acc[0]
            if (acc_name not in target_acc):
                n_acc += 1
                target_acc.append(acc_name)
        for acc in m().hci:
            acc_name = acc[0]
            if (acc_name not in target_acc):
                n_acc += 1
                target_acc.append(acc_name)
    return [target_acc, n_acc]

'''
    =====================================================================
    Title:        calc_cl_acc_data_ports
    Type:         Function
    Description:  Calculate required number of accelerator data ports.
    =====================================================================
'''

def calc_cl_acc_data_ports(accelerator_specs):

    # get list of sink/source data ports
    n_sink = accelerator_specs.n_sink
    n_source = accelerator_specs.n_source

    # calculate number of required data ports
    n_data_ports = 0

    # scan sink ports
    for s in range(n_sink):
        if accelerator_specs.is_parallel_in[s] is True:
            n_data_ports += accelerator_specs.in_parallelism_factor[s]
        else:
            n_data_ports += 1

    # scan source ports
    for s in range(n_source):
        if accelerator_specs.is_parallel_out[s] is True:
            n_data_ports += accelerator_specs.out_parallelism_factor[s]
        else:
            n_data_ports += 1

    return n_data_ports

'''
    =====================================================================
    Title:        format_cl_core_design_knobs
    Type:         Function
    Description:  Target a specific cluster and extract and format core
                    design knobs. The output content is formatted in
                    a suitable way for template to be easily rendered.
    =====================================================================
'''

def format_cl_core_design_knobs(cl_target_core):
    core_name           = cl_target_core[0]
    n_cores             = cl_target_core[1]
    return core_name, n_cores

'''
    =====================================================================
    Title:        format_cl_dma_design_knobs
    Type:         Function
    Description:  Target a specific cluster and extract and format DMA
                    design knobs. The output content is formatted in
                    a suitable way for template to be easily rendered.
    =====================================================================
'''

def format_cl_dma_design_knobs(cl_target_dma):
    n_dma               = cl_target_dma[0]
    max_n_reqs          = cl_target_dma[1]
    max_n_txns          = cl_target_dma[2]
    n_dma_streams       = cl_target_dma[3]
    max_burst_size      = cl_target_dma[4]
    return n_dma, max_n_reqs, max_n_txns, n_dma_streams, max_burst_size

'''
    =====================================================================
    Title:        format_cl_l1_design_knobs
    Type:         Function
    Description:  Target a specific L1 setup and extract and format L1
                    design knobs. The output content is formatted in a
                    suitable way for template to be easily rendered.
    =====================================================================
'''

def format_cl_l1_design_knobs(cl_target_l1):
    n_l1_banks        = cl_target_l1[0]
    l1_size           = cl_target_l1[1]
    return n_l1_banks, l1_size

'''
    =====================================================================
    Title:        clog2
    Type:         Function
    Description:  Returns log2(x).
    =====================================================================
'''

def clog2(x):
    return math.ceil(math.log2(x))
