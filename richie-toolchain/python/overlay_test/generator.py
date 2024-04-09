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

    Title:          Platform Tests Generator

    Description:    More information about the Mako rendering operation
                    can be found at:

                        ==> https://docs.makotemplates.org/en/latest/usage.html#mako.template.Template.render


    Date:           19.1.2022

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

        During the rendering phase. design parameters are read and fed to the Python rendering
        core to process the input templates. This is possible exploiting the 'render' method of
        the 'Template' class defined in the Mako python package.

        The rendered output is a string.
    '''

    def render(self, ov_design_params, template, cl_id=0, extra_params=[]):
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
    =================================
    Overlay test components generator
    =================================
'''

def gen_ov_test_comps(temp_obj, ov_design_params, emitter, descr, out_dir, cl_id=0, extra_params=[None for _ in range(3)]):
    template = temp_obj
    out_target = Generator().render(ov_design_params, template, cl_id, extra_params)
    filename = emitter.get_file_name(descr)
    emitter.out_gen(out_target, filename, out_dir)
