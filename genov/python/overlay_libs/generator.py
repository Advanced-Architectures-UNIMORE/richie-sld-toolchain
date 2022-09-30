'''
 =====================================================================
 Project:      Accelerator-Rich Overlay Generator
 Title:        generator.py
 Description:  Generator of cluster components.

 Date:         8.1.2022
 ===================================================================== */

 Copyright (C) 2021 University of Modena and Reggio Emilia.

 Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.

'''

#!/usr/bin/env python3

from mako.template import Template
import re

'''
    Cluster generator
'''

class Generator:
    '''
        The generator class is the main responsible for rendering
        the collected templates using the input user specification.
         
        During the rendering phase. design parameters are read and fed to the Python rendering
        core to process the input templates. This is possible exploiting the 'render' method of 
        the 'Template' class defined in the Mako python package.

        The rendered output is a string.
    '''
        
    def render(self, ov_design_params, acc_design_params, template, cl_id=0, extra_params=[]):
        # prepare input template
        target = Template(template)
        # rendering phase
        string = target.render(
            #############################
            # SYSTEM-ON-CHIP PARAMETERS #
            #############################
            # author
            author                          = ov_design_params.author,
            email                           = ov_design_params.email,
            # generated SoC
            soc_name                        = ov_design_params.soc_name,
            # L2 memory
            n_l2_banks                      = ov_design_params.l2[0],
            l2_size                         = ov_design_params.l2[1],
            # number of clusters
            n_clusters                      = ov_design_params.n_clusters,
            ######################
            # CLUSTER PARAMETERS #
            ######################
            # cluster ID
            cl_id                           = cl_id,
            # cluster cores
            cl_core_name                    = ov_design_params.list_cl_cores[cl_id][0],
            cl_n_cores                      = ov_design_params.list_cl_cores[cl_id][1],
            # cluster data memory
            cl_n_l1_banks                   = ov_design_params.list_cl_l1[cl_id][0],
            cl_l1_size                      = ov_design_params.list_cl_l1[cl_id][1],
            # logarithmic interconnect (LIC)
            cl_lic_total_data_ports         = ov_design_params.list_cl_lic[cl_id][0],
            cl_lic_acc_names                = ov_design_params.list_cl_lic[cl_id][1],
            cl_lic_acc_protocols            = ov_design_params.list_cl_lic[cl_id][2],
            cl_lic_acc_n_data_ports         = ov_design_params.list_cl_lic[cl_id][3],
            # heterogeneous interconnect (HCI)
            cl_hci_total_data_ports         = ov_design_params.list_cl_hci[cl_id][0],
            cl_hci_acc_names                = ov_design_params.list_cl_hci[cl_id][1],
            cl_hci_acc_protocols            = ov_design_params.list_cl_hci[cl_id][2],
            cl_hci_acc_n_data_ports         = ov_design_params.list_cl_hci[cl_id][3],
            ##################################
            # ACCELERATOR WRAPPER PARAMETERS #
            ##################################
            # kernel
            acc_wr_target                   = acc_design_params.target,
            acc_wr_design_type              = acc_design_params.design_type,
            acc_wr_is_ap_ctrl_hs            = acc_design_params.is_ap_ctrl_hs,
            acc_wr_is_mdc_dataflow          = acc_design_params.is_mdc_dataflow,
            # streaming
            acc_wr_n_sink                   = acc_design_params.n_sink, 
            acc_wr_n_source                 = acc_design_params.n_source,
            acc_wr_stream_in                = acc_design_params.stream_in,
            acc_wr_stream_out               = acc_design_params.stream_out,
            acc_wr_stream_in_dtype          = acc_design_params.stream_in_dtype,
            acc_wr_stream_out_dtype         = acc_design_params.stream_out_dtype,
            acc_wr_is_parallel_in           = acc_design_params.is_parallel_in,
            acc_wr_is_parallel_out          = acc_design_params.is_parallel_out,
            acc_wr_in_parallelism_factor    = acc_design_params.in_parallelism_factor,
            acc_wr_out_parallelism_factor   = acc_design_params.out_parallelism_factor,
            # regfile
            acc_wr_std_reg_num              = acc_design_params.std_reg_num,
            acc_wr_custom_reg_name          = acc_design_params.custom_reg_name, 
            acc_wr_custom_reg_dtype         = acc_design_params.custom_reg_dtype,
            acc_wr_custom_reg_dim           = acc_design_params.custom_reg_dim,
            acc_wr_custom_reg_isport        = acc_design_params.custom_reg_isport, 
            acc_wr_custom_reg_num           = acc_design_params.custom_reg_num,
            # addressgen
            acc_wr_addr_gen_in_isprogr      = acc_design_params.addr_gen_in_isprogr,
            acc_wr_addr_gen_out_isprogr     = acc_design_params.addr_gen_out_isprogr,
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

def gen_ov_libs_comps(temp_obj, ov_design_params, acc_design_params, emitter, descr, out_dir, cl_id=0, extra_params=[None for _ in range(3)]):
    template = temp_obj
    out_target = Generator().render(ov_design_params, acc_design_params, template, cl_id, extra_params)
    filename = emitter.get_file_name(descr)
    emitter.out_gen(out_target, filename, out_dir)