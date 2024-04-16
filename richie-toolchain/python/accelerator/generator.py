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

        During the rendering phase. design knobs are read and fed to the Python rendering
        core to process the input templates. This is possible exploiting the 'render' method of
        the 'Template' class defined in the Mako python package.

        The rendered output is a string.
    '''

    def render(self, accelerator_design_knobs, template, extra_params=[]):
        # prepare input template
        target = Template(template)
        # rendering phase
        string = target.render(
            # author
            author                  = accelerator_design_knobs.author,
            email                   = accelerator_design_knobs.email,
            # wrapper
            is_third_party          = accelerator_design_knobs.is_third_party,
            # kernel
            target                  = accelerator_design_knobs.target,
            design_type             = accelerator_design_knobs.design_type,
            is_ap_ctrl_hs           = accelerator_design_knobs.is_ap_ctrl_hs,
            is_mdc_dataflow         = accelerator_design_knobs.is_mdc_dataflow,
            is_hls_stream           = accelerator_design_knobs.is_hls_stream,
            # streaming
            n_sink                  = accelerator_design_knobs.n_sink,
            n_source                = accelerator_design_knobs.n_source,
            stream_in               = accelerator_design_knobs.stream_in,
            stream_out              = accelerator_design_knobs.stream_out,
            stream_in_dtype         = accelerator_design_knobs.stream_in_dtype,
            stream_out_dtype        = accelerator_design_knobs.stream_out_dtype,
            stream_in_dwidth        = accelerator_design_knobs.stream_in_dwidth,
            stream_out_dwidth       = accelerator_design_knobs.stream_out_dwidth,
            is_parallel_in          = accelerator_design_knobs.is_parallel_in,
            is_parallel_out         = accelerator_design_knobs.is_parallel_out,
            in_parallelism_factor   = accelerator_design_knobs.in_parallelism_factor,
            out_parallelism_factor  = accelerator_design_knobs.out_parallelism_factor,
            # regfile
            std_reg_num             = accelerator_design_knobs.std_reg_num,
            custom_reg_name         = accelerator_design_knobs.custom_reg_name,
            custom_reg_dtype        = accelerator_design_knobs.custom_reg_dtype,
            custom_reg_dim          = accelerator_design_knobs.custom_reg_dim,
            custom_reg_isport       = accelerator_design_knobs.custom_reg_isport,
            custom_reg_num          = accelerator_design_knobs.custom_reg_num,
            # addressgen
            addr_gen_in_isprogr     = accelerator_design_knobs.addr_gen_in_isprogr,
            addr_gen_out_isprogr    = accelerator_design_knobs.addr_gen_out_isprogr,
            # static design components
            kernel_modules          = self.get_kernel_list(accelerator_design_knobs),
            num_kernel_modules      = len(self.get_kernel_list(accelerator_design_knobs)),
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

    def get_kernel_list(self, accelerator_design_knobs):
        # filename = 'templates/accelerator/integr_support/rtl_list/engine_list.log'
        filename = 'dev/accelerator_dev/' + accelerator_design_knobs.target + '/kernel_list.log'
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

def generation(temp_obj, accelerator_design_knobs, emitter, descr, out_dir, extra_params=[None for _ in range(3)]):
    template = temp_obj
    out_target = Generator().render(accelerator_design_knobs, template, extra_params)
    filename = emitter.get_file_name(descr)
    emitter.out_gen(out_target, filename, out_dir)
