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

    Title:          Generator

    Description:    The generator class is the main responsible for rendering
                    the collected templates using the input user specification.

                    During the rendering phase, design knobs are retrieved, formatted
                    and sourced to the Python Mako rendering engine, which elaborates
                    the templates. This is possible exploiting the 'render' method of
                    the 'Template' class defined in the Mako python package.

                    The rendered artefact is a string, which is further formatted and
                    exported in the output directory.

                    More information about the Mako rendering operation
                    can be found at:

                        ==> https://docs.makotemplates.org/en/latest/usage.html#mako.template.Template.render


    Date:           8.1.2022

    Author: 		Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''

#!/usr/bin/env python3

from mako.template import Template
import re

'''
    ===============
    Generator class
    ===============
'''

class Generator:

    def __init__(self):

        # Design knobs argument for rendering engine
        self.template_knobs = {}

    """
    Map the design knobs to the templates.
    """

    def retrieve_knobs(self, platform_design_knobs, accelerator_design_knobs, cluster_id=0, extra_knobs=[]):

        '''
            ========================
            HeSoC-level design knobs
            ========================
        '''

        if platform_design_knobs is not None:

            self.template_knobs.update({

                # Author
                'author'                            : platform_design_knobs.author,
                'email'                             : platform_design_knobs.email,

                # HeSoC
                'hesoc_name'                        : platform_design_knobs.hesoc_name,

                # FPGA deployment
                'target_fpga_board'                 : platform_design_knobs.target_fpga_board,
                'target_fpga_hesoc'                 : platform_design_knobs.target_fpga_hesoc,

                # AXI interface
                'aw'                                : platform_design_knobs.aw,
                'dw'                                : platform_design_knobs.dw,
                'iw'                                : platform_design_knobs.iw,
                'uw'                                : platform_design_knobs.uw,
                'aw_pl2ps'                          : platform_design_knobs.aw_pl2ps,
                'iw_pl2ps'                          : platform_design_knobs.iw_pl2ps,
                'uw_pl2ps'                          : platform_design_knobs.uw_pl2ps,
                'aw_ps2pl'                          : platform_design_knobs.aw_ps2pl,
                'iw_ps2pl'                          : platform_design_knobs.iw_ps2pl,
                'uw_ps2pl'                          : platform_design_knobs.uw_ps2pl,
                'aw_lite'                           : platform_design_knobs.aw_lite,
                'dw_lite'                           : platform_design_knobs.dw_lite,

                # L2 memory
                'n_l2_banks'                        : platform_design_knobs.l2[0],
                'l2_size'                           : platform_design_knobs.l2[1],

                # Number of clusters
                'n_clusters'                        : platform_design_knobs.n_clusters,
            })

        '''
            =======================
            Tile-level design knobs
            =======================
        '''

        if platform_design_knobs is not None:

            self.template_knobs.update({

                # Cluster ID
                'cl_id'                             : cluster_id,

                # Cluster cores
                'cl_core_name'                      : platform_design_knobs.list_cl_cores[cluster_id][0],
                'cl_n_cores'                        : platform_design_knobs.list_cl_cores[cluster_id][1],

                # Cluster DMA
                'n_dma'                             : platform_design_knobs.list_cl_dma[cluster_id][0],
                'cl_dma_max_n_reqs'                 : platform_design_knobs.list_cl_dma[cluster_id][1],
                'cl_dma_max_n_txns'                 : platform_design_knobs.list_cl_dma[cluster_id][2],
                'cl_dma_n_dma_streams'              : platform_design_knobs.list_cl_dma[cluster_id][3],
                'cl_dma_max_burst_size'             : platform_design_knobs.list_cl_dma[cluster_id][4],

                # Cluster data memory
                'cl_n_l1_banks'                     : platform_design_knobs.list_cl_l1[cluster_id][0],
                'cl_l1_size'                        : platform_design_knobs.list_cl_l1[cluster_id][1],
                #
                # Logarithmic interconnect (LIC)
                'cl_lic_total_data_ports'           : platform_design_knobs.list_cl_lic[cluster_id][0],
                'cl_lic_acc_names'                  : platform_design_knobs.list_cl_lic[cluster_id][1],
                'cl_lic_acc_protocols'              : platform_design_knobs.list_cl_lic[cluster_id][2],
                'cl_lic_acc_n_data_ports'           : platform_design_knobs.list_cl_lic[cluster_id][3],

                # Heterogeneous interconnect (HCI)
                'cl_hci_total_data_ports'           : platform_design_knobs.list_cl_hci[cluster_id][0],
                'cl_hci_acc_names'                  : platform_design_knobs.list_cl_hci[cluster_id][1],
                'cl_hci_acc_protocols'              : platform_design_knobs.list_cl_hci[cluster_id][2],
                'cl_hci_acc_n_data_ports'           : platform_design_knobs.list_cl_hci[cluster_id][3],
            })

        '''
            ==============================
            Accelerator-level design knobs
            ==============================
        '''

        if accelerator_design_knobs is not None:

            self.template_knobs.update({

                # General
                'acc_wr_author'                     : accelerator_design_knobs.author,
                'acc_wr_email'                      : accelerator_design_knobs.email,
                'acc_wr_is_third_party'             : accelerator_design_knobs.is_third_party,

                # Accelerator datapath
                'acc_wr_target'                     : accelerator_design_knobs.target,
                'acc_wr_design_type'                : accelerator_design_knobs.design_type,
                'acc_wr_is_ap_ctrl_hs'              : accelerator_design_knobs.is_ap_ctrl_hs,
                'acc_wr_is_mdc_dataflow'            : accelerator_design_knobs.is_mdc_dataflow,
                'acc_wr_is_hls_stream'              : accelerator_design_knobs.is_hls_stream,

                # Data communication interface
                'acc_wr_n_sink'                     : accelerator_design_knobs.n_sink,
                'acc_wr_n_source'                   : accelerator_design_knobs.n_source,
                'acc_wr_stream_in'                  : accelerator_design_knobs.stream_in,
                'acc_wr_stream_out'                 : accelerator_design_knobs.stream_out,
                'acc_wr_stream_in_dtype'            : accelerator_design_knobs.stream_in_dtype,
                'acc_wr_stream_out_dtype'           : accelerator_design_knobs.stream_out_dtype,
                'acc_wr_stream_in_dwidth'           : accelerator_design_knobs.stream_in_dwidth,
                'acc_wr_stream_out_dwidth'          : accelerator_design_knobs.stream_out_dwidth,
                'acc_wr_is_parallel_in'             : accelerator_design_knobs.is_parallel_in,
                'acc_wr_is_parallel_out'            : accelerator_design_knobs.is_parallel_out,
                'acc_wr_in_parallelism_factor'      : accelerator_design_knobs.in_parallelism_factor,
                'acc_wr_out_parallelism_factor'     : accelerator_design_knobs.out_parallelism_factor,

                # Control interface
                'acc_wr_std_reg_num'                : accelerator_design_knobs.std_reg_num,
                'acc_wr_custom_reg_name'            : accelerator_design_knobs.custom_reg_name,
                'acc_wr_custom_reg_dtype'           : accelerator_design_knobs.custom_reg_dtype,
                'acc_wr_custom_reg_dim'             : accelerator_design_knobs.custom_reg_dim,
                'acc_wr_custom_reg_isport'          : accelerator_design_knobs.custom_reg_isport,
                'acc_wr_custom_reg_num'             : accelerator_design_knobs.custom_reg_num,

                # Address generator (streaming protocol)
                'acc_wr_addr_gen_in_isprogr'        : accelerator_design_knobs.addr_gen_in_isprogr,
                'acc_wr_addr_gen_out_isprogr'       : accelerator_design_knobs.addr_gen_out_isprogr,

                # Static design components
                'acc_wr_datapath_modules'           : self.get_datapath_modules_list(accelerator_design_knobs),
                'acc_wr_num_datapath_modules'       : len(self.get_datapath_modules_list(accelerator_design_knobs)),
            })

        '''
            =======================
            Additional design knobs
            =======================
        '''

        self.template_knobs.update({

            # Generic
            'extra_param_0'                         : extra_knobs[0],
            'extra_param_1'                         : extra_knobs[1],
            'extra_param_2'                         : extra_knobs[2],

            # Software (not yet exposed to the user)
            'inline_richie_api'                     : 1
        })

    """
    Method used to retrieve lists of files to feed the scripts
    used for version control. For example, the method 'get_engine'
    retrieves a list of the input RTL files that have to be wrapped,
    then these are used to generate the scripts for the 'bender' tool.
    """

    def get_datapath_modules_list(self, accelerator_design_knobs):
        filename = 'dev/accelerator_dev/' + accelerator_design_knobs.target + '/datapath_list.log'
        l = []
        with open(filename, 'r') as f:
            for s in f.readlines():
                re_trailws = re.compile(r'[ \t\r]+$', re.MULTILINE)
                s = re.sub(r'\n', '', s)
                s = re_trailws.sub("", s)
                l.append(s)
        f.close()
        return l

    """
    Render the template using the input design knobs.
    """

    def render(self, template, platform_design_knobs, accelerator_design_knobs, emitter, descr, out_dir, cluster_id=0, extra_knobs=[None for _ in range(3)]):
        # Prepare template to render
        target = Template(template)

        # Pass the design knobs to the generator, which will then map them to the template knobs
        self.retrieve_knobs(platform_design_knobs, accelerator_design_knobs, cluster_id, extra_knobs)

        # Launch rendering engine
        string = target.render(**self.template_knobs)

        # Compile a regex to trim trailing whitespaces on lines
        # and multiple consecutive new lines.
        re_trailws = re.compile(r'[ \t\r]+$', re.MULTILINE)
        string = re.sub(r'\n\s*\n', '\n\n', string)
        string = re_trailws.sub("", string)

        # Retrieve filename for generated item
        filename = emitter.get_file_name(descr)

        # Export generated item to the output directory
        emitter.out_gen(string, filename, out_dir)
