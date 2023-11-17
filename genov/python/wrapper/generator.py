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

    Project:        GenOv

    Title:          Accelerator Interface Generator

    Description:    More information about the Mako rendering operation
                    can be found at:

                        ==> https://docs.makotemplates.org/en/latest/usage.html#mako.template.Template.render


    Date:           8.1.2022

    Author: 		Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''

#!/usr/bin/env python3

# Packages - Template
from mako.template import Template
import re

'''
    Accelerator wrapper generator
'''

class Generator:

    '''
        The wrapper generator class is the main responsible for rendering
        the collected cluster templates using the input user specification.

        During the rendering phase. design parameters are read and fed to the Python rendering
        core to process the input templates. This is possible exploiting the 'render' method of
        the 'Template' class defined in the Mako python package.

        The rendered output is a string.
    '''

    def render(self, design_params, template, extra_params=[]):
        # prepare input template
        target = Template(template)
        # rendering phase
        string = target.render(
            # author
            author                  = design_params.author,
            email                   = design_params.email,
            # wrapper
            is_third_party          = design_params.is_third_party,
            # kernel
            target                  = design_params.target,
            design_type             = design_params.design_type,
            is_ap_ctrl_hs           = design_params.is_ap_ctrl_hs,
            is_mdc_dataflow         = design_params.is_mdc_dataflow,
            is_hls_stream           = design_params.is_hls_stream,
            # streaming
            n_sink                  = design_params.n_sink,
            n_source                = design_params.n_source,
            stream_in               = design_params.stream_in,
            stream_out              = design_params.stream_out,
            stream_in_dtype         = design_params.stream_in_dtype,
            stream_out_dtype        = design_params.stream_out_dtype,
            stream_in_dwidth        = design_params.stream_in_dwidth,
            stream_out_dwidth       = design_params.stream_out_dwidth,
            is_parallel_in          = design_params.is_parallel_in,
            is_parallel_out         = design_params.is_parallel_out,
            in_parallelism_factor   = design_params.in_parallelism_factor,
            out_parallelism_factor  = design_params.out_parallelism_factor,
            # regfile
            std_reg_num             = design_params.std_reg_num,
            custom_reg_name         = design_params.custom_reg_name,
            custom_reg_dtype        = design_params.custom_reg_dtype,
            custom_reg_dim          = design_params.custom_reg_dim,
            custom_reg_isport       = design_params.custom_reg_isport,
            custom_reg_num          = design_params.custom_reg_num,
            # addressgen
            addr_gen_in_isprogr     = design_params.addr_gen_in_isprogr,
            addr_gen_out_isprogr    = design_params.addr_gen_out_isprogr,
            # static design components
            kernel_modules          = self.get_kernel_list(design_params),
            num_kernel_modules      = len(self.get_kernel_list(design_params)),
            # additional params
            extra_param_0           = extra_params[0],
            extra_param_1           = extra_params[1],
            extra_param_2           = extra_params[2],
        )
        # Compile a regex to trim trailing whitespaces on lines
        # and multiple consecutive new lines.
        re_trailws = re.compile(r'[ \t\r]+$', re.MULTILINE)
        string = re.sub(r'\n\s*\n', '\n\n', string)
        string = re_trailws.sub("", string)
        return string

    """
    Methods used to retrieve lists of files to feed the scripts
    used for version control. For example, the method 'get_engine'
    retrieves a list of the input RTL files that have to be wrapped,
    then these are used to generate the scripts for the 'bender' tool.
    """

    def get_kernel_list(self, design_params):
        # filename = 'templates/acc_templ/integr_support/rtl_list/engine_list.log'
        filename = 'dev/acc_dev/' + design_params.target + '/kernel_list.log'
        l = []
        with open(filename, 'r') as f:
            for s in f.readlines():
                re_trailws = re.compile(r'[ \t\r]+$', re.MULTILINE)
                s = re.sub(r'\n', '', s)
                s = re_trailws.sub("", s)
                l.append(s)
        f.close()
        return l

'''
    ============================
    Wrapper components generator
    ============================

    Differently from the generic generator, this alternative
    version passes also a "cluster_offset" to target the
    generation of components for a specific cluster
'''

def gen_acc_comps(temp_obj, design_params, emitter, descr, out_dir, extra_params=[None for _ in range(3)]):
    template = temp_obj
    out_target = Generator().render(design_params, template, extra_params)
    filename = emitter.get_file_name(descr)
    emitter.out_gen(out_target, filename, out_dir)
