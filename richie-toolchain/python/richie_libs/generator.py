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

    Title:          Platform Library Generator

    Description:    More information about the Mako rendering operation
                    can be found at:

                        ==> https://docs.makotemplates.org/en/latest/usage.html#mako.template.Template.render


    Date:           8.1.2022

    Author: 		Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''

#!/usr/bin/env python3

from mako.template import Template
import re

class Generator:

    '''
        The generator class is the main responsible for rendering
        the collected templates using the input user specification.

        During the rendering phase. design knobs are read and fed to the Python rendering
        core to process the input templates. This is possible exploiting the 'render' method of
        the 'Template' class defined in the Mako python package.

        The rendered output is a string.
    '''

    def render(self, platform_design_knobs, accelerator_design_knobs, template, cl_id=0, extra_params=[]):
        # prepare input template
        target = Template(template)
        # rendering phase
        string = target.render(
            #############################
            # SYSTEM-ON-CHIP PARAMETERS #
            #############################
            # author
            author                          = platform_design_knobs.author,
            email                           = platform_design_knobs.email,
            # generated HeSoC
            hesoc_name                      = platform_design_knobs.hesoc_name,
            # L2 memory
            n_l2_banks                      = platform_design_knobs.l2[0],
            l2_size                         = platform_design_knobs.l2[1],
            # number of clusters
            n_clusters                      = platform_design_knobs.n_clusters,
            ######################
            # CLUSTER PARAMETERS #
            ######################
            # cluster ID
            cl_id                           = cl_id,
            # cluster cores
            cl_core_name                    = platform_design_knobs.list_cl_cores[cl_id][0],
            cl_n_cores                      = platform_design_knobs.list_cl_cores[cl_id][1],
            # cluster data memory
            cl_n_l1_banks                   = platform_design_knobs.list_cl_l1[cl_id][0],
            cl_l1_size                      = platform_design_knobs.list_cl_l1[cl_id][1],
            # logarithmic interconnect (LIC)
            cl_lic_total_data_ports         = platform_design_knobs.list_cl_lic[cl_id][0],
            cl_lic_acc_names                = platform_design_knobs.list_cl_lic[cl_id][1],
            cl_lic_acc_protocols            = platform_design_knobs.list_cl_lic[cl_id][2],
            cl_lic_acc_n_data_ports         = platform_design_knobs.list_cl_lic[cl_id][3],
            # heterogeneous interconnect (HCI)
            cl_hci_total_data_ports         = platform_design_knobs.list_cl_hci[cl_id][0],
            cl_hci_acc_names                = platform_design_knobs.list_cl_hci[cl_id][1],
            cl_hci_acc_protocols            = platform_design_knobs.list_cl_hci[cl_id][2],
            cl_hci_acc_n_data_ports         = platform_design_knobs.list_cl_hci[cl_id][3],
            ##################################
            # ACCELERATOR WRAPPER PARAMETERS #
            ##################################
            # kernel
            acc_wr_target                   = accelerator_design_knobs.target,
            acc_wr_design_type              = accelerator_design_knobs.design_type,
            acc_wr_is_ap_ctrl_hs            = accelerator_design_knobs.is_ap_ctrl_hs,
            acc_wr_is_mdc_dataflow          = accelerator_design_knobs.is_mdc_dataflow,
            acc_wr_is_hls_stream            = accelerator_design_knobs.is_hls_stream,
            # streaming
            acc_wr_n_sink                   = accelerator_design_knobs.n_sink,
            acc_wr_n_source                 = accelerator_design_knobs.n_source,
            acc_wr_stream_in                = accelerator_design_knobs.stream_in,
            acc_wr_stream_out               = accelerator_design_knobs.stream_out,
            acc_wr_stream_in_dtype          = accelerator_design_knobs.stream_in_dtype,
            acc_wr_stream_out_dtype         = accelerator_design_knobs.stream_out_dtype,
            acc_wr_is_parallel_in           = accelerator_design_knobs.is_parallel_in,
            acc_wr_is_parallel_out          = accelerator_design_knobs.is_parallel_out,
            acc_wr_in_parallelism_factor    = accelerator_design_knobs.in_parallelism_factor,
            acc_wr_out_parallelism_factor   = accelerator_design_knobs.out_parallelism_factor,
            # regfile
            acc_wr_std_reg_num              = accelerator_design_knobs.std_reg_num,
            acc_wr_custom_reg_name          = accelerator_design_knobs.custom_reg_name,
            acc_wr_custom_reg_dtype         = accelerator_design_knobs.custom_reg_dtype,
            acc_wr_custom_reg_dim           = accelerator_design_knobs.custom_reg_dim,
            acc_wr_custom_reg_isport        = accelerator_design_knobs.custom_reg_isport,
            acc_wr_custom_reg_num           = accelerator_design_knobs.custom_reg_num,
            # addressgen
            acc_wr_addr_gen_in_isprogr      = accelerator_design_knobs.addr_gen_in_isprogr,
            acc_wr_addr_gen_out_isprogr     = accelerator_design_knobs.addr_gen_out_isprogr,
            ##############################
            # SOFTWARE DESIGN PARAMETERS #
            ##############################
            # NB: These are not yet exposed to the front-end
            inline_richie_api               = 1,
            ####################
            # EXTRA PARAMETERS #
            ####################
            # additional params
            extra_param_0                   = extra_params[0],
            extra_param_1                   = extra_params[1],
            extra_param_2                   = extra_params[2],
        )
        # Compile a regex to trim trailing whitespaces on lines
        # and multiple consecutive new lines.
        re_trailws = re.compile(r'[ \t\r]+$', re.MULTILINE)
        string = re.sub(r'\n\s*\n', '\n\n', string)
        string = re_trailws.sub("", string)
        return string

'''
    ============================
    Cluster components generator
    ============================
'''

def generation(temp_obj, platform_design_knobs, accelerator_design_knobs, emitter, descr, out_dir, cl_id=0, extra_params=[None for _ in range(3)]):
    template = temp_obj
    out_target = Generator().render(platform_design_knobs, accelerator_design_knobs, template, cl_id, extra_params)
    filename = emitter.get_file_name(descr)
    emitter.out_gen(out_target, filename, out_dir)
