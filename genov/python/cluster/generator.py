'''
    =====================================================================

    Copyright (C) 2022 ETH Zurich, University of Modena and Reggio Emilia

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

    Project:        GenOv

    Title:          Cluster Generator

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

        During the rendering phase. design parameters are read and fed to the Python rendering
        core to process the input templates. This is possible exploiting the 'render' method of
        the 'Template' class defined in the Mako python package.

        The rendered output is a string.
    '''

    def render(self, design_params, template, cl_id=0, extra_params=[]):
        # prepare input template
        target = Template(template)
        # rendering phase
        string = target.render(
            # author
            author                          = design_params.author,
            email                           = design_params.email,
            # generated SoC
            soc_name                        = design_params.soc_name,
            # number of clusters
            n_clusters                      = design_params.n_clusters,
            # cluster ID
            cl_id                           = cl_id,
            # cluster cores
            cl_core_name                    = design_params.list_cl_cores[cl_id][0],
            cl_n_cores                      = design_params.list_cl_cores[cl_id][1],
            # dma
            n_dma                           = design_params.list_cl_dma[cl_id][0],
            cl_dma_max_n_reqs               = design_params.list_cl_dma[cl_id][1],
            cl_dma_max_n_txns               = design_params.list_cl_dma[cl_id][2],
            cl_dma_n_dma_streams            = design_params.list_cl_dma[cl_id][3],
            cl_dma_max_burst_size           = design_params.list_cl_dma[cl_id][4],
            # cluster data memory
            cl_n_l1_banks                   = design_params.list_cl_l1[cl_id][0],
            cl_l1_size                      = design_params.list_cl_l1[cl_id][1],
            # logarithmic interconnect (LIC)
            cl_lic_total_data_ports         = design_params.list_cl_lic[cl_id][0],
            cl_lic_acc_names                = design_params.list_cl_lic[cl_id][1],
            cl_lic_acc_protocols            = design_params.list_cl_lic[cl_id][2],
            cl_lic_acc_n_data_ports         = design_params.list_cl_lic[cl_id][3],
            # heterogeneous interconnect (HCI)
            cl_hci_total_data_ports         = design_params.list_cl_hci[cl_id][0],
            cl_hci_acc_names                = design_params.list_cl_hci[cl_id][1],
            cl_hci_acc_protocols            = design_params.list_cl_hci[cl_id][2],
            cl_hci_acc_n_data_ports         = design_params.list_cl_hci[cl_id][3],
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

def gen_cl_comps(temp_obj, design_params, emitter, descr, out_dir, cl_id=0, extra_params=[None for _ in range(3)]):
    template = temp_obj
    out_target = Generator().render(design_params, template, cl_id, extra_params)
    filename = emitter.get_file_name(descr)
    emitter.out_gen(out_target, filename, out_dir)
