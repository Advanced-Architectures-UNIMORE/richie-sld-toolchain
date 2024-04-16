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

    Title:          Processing Input Specifications

    Description:    Specifications are pre-processed, so as to ease the rendering
                    phase by formatting values, and so on.

    Date:           8.1.2022

    Author: 		Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''

from python.accelerator.import_params import import_accelerator_dev_module
from python.accelerator.process_params import AcceleratorDesignKnobsFormatted

import math

'''
  =====================================================================
  Title:        PlatformDesignKnobsFormatted
  Type:         Class
  Description:  Format design knobs. The output content is formatted
                in a suitable way for template to be easily rendered.
  =====================================================================
'''

class PlatformDesignKnobsFormatted:

    def __init__(self, platform_specs):
        self.format_richie_author(platform_specs().author)
        self.format_richie_hesoc(platform_specs().hesoc)
        self.format_richie_cluster(platform_specs())

    '''
        Format author information.
    '''

    def format_richie_author(self, author_specs):
        self.author                             = author_specs().author
        self.email                              = author_specs().email
        return self

    '''
        Format HeSoC information.
    '''

    def format_richie_hesoc(self, platform_specs):
        self.hesoc_name                         = platform_specs().name
        self.n_clusters                         = get_n_cl(platform_specs())
        self.target_fpga_board                  = platform_specs().board
        self.target_fpga_hesoc                  = get_target_hesoc(platform_specs().board)
        self.l2                                 = platform_specs().l2
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
        return self

    '''
        Format cluster information.
    '''

    def format_richie_cluster(self, platform_specs):
        cl_list = get_cl_targets_list(platform_specs)
        # cores
        self.list_cl_cores = []
        for cl_target in cl_list:
            self.list_cl_cores.append(format_cl_core_params(cl_target().core))
        # DMA
        self.list_cl_dma = []
        for cl_target in cl_list:
            self.list_cl_dma.append(format_cl_dma_params(cl_target().dma))
        # L1 data memory
        self.list_cl_l1 = []
        for cl_target in cl_list:
            self.list_cl_l1.append(format_cl_l1_params(cl_target().l1))
        # hardware accelerators
        self.list_cl_lic = []
        self.list_cl_hci = []
        for cl_target in cl_list:
            self.list_cl_lic.append(format_cl_acc_params(cl_target().lic))
            self.list_cl_hci.append(format_cl_acc_params(cl_target().hci))
        return self

'''
  =====================================================================
  Title:        get_cl_targets_list
  Type:         Function
  Description:  Extract cluster methods.
  =====================================================================
'''

def get_cl_targets_list(platform_specs):
    attribute_list = []
    targets_list = []
    for attribute in dir(platform_specs):
        if attribute not in attribute_list:
            if "cluster_" in attribute:
                attribute_list.append(attribute)
                method = getattr(platform_specs, attribute)
                targets_list.append(method)
    return targets_list

'''
  =====================================================================
  Title:        get_n_cl
  Type:         Function
  Description:  Derive number of clusters.
  =====================================================================
'''

def get_n_cl(platform_specs):
    return len(get_cl_targets_list(platform_specs))

'''
  =====================================================================
  Title:        get_target_hesoc
  Type:         Function
  Description:  Derive number of clusters.
  =====================================================================
'''

def get_target_hesoc(target_board):
    hesoc_dict = {
        "zcu102": "xilzu9eg",
        "zcu104": "xilzu7ev",
        "ultra96_v2": "xilzu3eg",
        "kv260": "xilk26"
        }
    return hesoc_dict[target_board]

'''
  =====================================================================
  Title:        get_acc_info
  Type:         Function
  Description:  Derive information about the accelerator wrapper
                generation process.
  =====================================================================
'''

def get_acc_info(platform_specs):
    target_cl = get_cl_targets_list(platform_specs)
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

def calc_cl_acc_data_ports(wrapper_params):

    # get list of sink/source data ports
    n_sink = wrapper_params.n_sink
    n_source = wrapper_params.n_source

    # calculate number of required data ports
    n_data_ports = 0

    # scan sink ports
    for s in range(n_sink):
        if wrapper_params.is_parallel_in[s] is True:
            n_data_ports += wrapper_params.in_parallelism_factor[s]
        else:
            n_data_ports += 1

    # scan source ports
    for s in range(n_source):
        if wrapper_params.is_parallel_out[s] is True:
            n_data_ports += wrapper_params.out_parallelism_factor[s]
        else:
            n_data_ports += 1

    return n_data_ports

'''
  =====================================================================
  Title:        get_acc_targets
  Type:         Function
  Description:  This function derives the distinct target applications
                that need an accelerator wrapper to be generated. Examples
                of such use can be found both in the generation of the
                accelerator interface between the wrapper and the support
                interconnection, as well as in that of the clsuter source
                management scripts (Bender).
  =====================================================================
'''

def get_acc_targets(design_knobs):

    # list of distinct targsts to be derived
    hwpe_gen_list = []

    for i in range(design_knobs.n_clusters):

        cl_lic_acc_names = design_knobs.list_cl_lic[i][1]
        cl_hci_acc_names = design_knobs.list_cl_hci[i][1]

        cl_lic_acc_protocols = design_knobs.list_cl_lic[i][2]
        cl_hci_acc_protocols = design_knobs.list_cl_hci[i][2]

        # Count number of wrappers
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
  Title:        format_cl_core_params
  Type:         Function
  Description:  Target a specific cluster and extract and format core
                design knobs. The output content is formatted in
                a suitable way for template to be easily rendered.
  =====================================================================
'''

def format_cl_core_params(cl_target_core):
    core_name           = cl_target_core[0]
    n_cores             = cl_target_core[1]
    return core_name, n_cores

'''
  =====================================================================
  Title:        format_cl_dma_params
  Type:         Function
  Description:  Target a specific cluster and extract and format DMA
                design knobs. The output content is formatted in
                a suitable way for template to be easily rendered.
  =====================================================================
'''

def format_cl_dma_params(cl_target_dma):
    n_dma               = cl_target_dma[0]
    max_n_reqs          = cl_target_dma[1]
    max_n_txns          = cl_target_dma[2]
    n_dma_streams       = cl_target_dma[3]
    max_burst_size      = cl_target_dma[4]
    return n_dma, max_n_reqs, max_n_txns, n_dma_streams, max_burst_size

'''
  =====================================================================
  Title:        format_cl_l1_params
  Type:         Function
  Description:  Target a specific L1 setup and extract and format L1
                design knobs. The output content is formatted in a
                suitable way for template to be easily rendered.
  =====================================================================
'''

def format_cl_l1_params(cl_target_l1):
    n_l1_banks        = cl_target_l1[0]
    l1_size           = cl_target_l1[1]
    return n_l1_banks, l1_size

'''
  =====================================================================
  Title:        format_cl_acc_params
  Type:         Function
  Description:  Target a specific cluster interconnection and extract
                and format accelerator design knobs. The output
                content is formatted in a suitable way for template to
                be easily rendered.
  =====================================================================
'''

def format_cl_acc_params(cl_target_interco):
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
        accelerator_specs = import_accelerator_dev_module(acc_names[-1])
        # format accelerator wrapper design knobs
        wrapper_params = AcceleratorDesignKnobsFormatted(accelerator_specs.AcceleratorSpecs)
        # extract data ports
        acc_n_data_ports.append(calc_cl_acc_data_ports(wrapper_params))
    # calculate total number of data ports
    for n in acc_n_data_ports:
        total_data_ports += n

    return total_data_ports, acc_names, acc_protocols, acc_n_data_ports

'''
  =====================================================================
  Title:        clog2
  Type:         Function
  Description:  Returns log2(x).
  =====================================================================
'''

def clog2(x):
    return math.ceil(math.log2(x))

'''
  =====================================================================
  Title:        print_generation_log
  Type:         Function
  Description:  Print generation log.
  =====================================================================
'''

def print_generation_log(design_knobs, verbose=False):

    print("\n# ==================================== #")
    print("# Generation of Accelerator-Rich HeSoC #")
    print("# ==================================== #")

    if(verbose is True):

        print("\n")
        print("[py] >> User-defined Richie specification:")

        print("\n\tSoC name:", design_knobs.hesoc_name)
