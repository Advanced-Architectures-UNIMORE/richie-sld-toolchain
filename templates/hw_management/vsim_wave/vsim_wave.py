########################################################
## Gianluca Bellocchi <gianluca.bellocchi@unimore.it> ##
########################################################

#!/usr/bin/env python3

# Packages
from mako.template import Template
import math
import re
import sys

from templates.sw.common.common_c.template_c import template_c
from templates.hw_management.vsim_wave.vsim_overlay_versions.overlay_waves import overlay_waves

# Main function
class vsim_wave:
    def __init__(self, specs):
        
        # Engineer(-s)
        self.author                 = specs.author
        self.email                  = specs.email

        # Environment
        self.destdir                = specs.dest_dir
        self.is_hero_offloading     = specs.overlay_version[0]
        self.is_release_0_2         = specs.overlay_version[1]
        self.module                 = "vsim_wave/vsim_wave"

        # Generic
        self.hwpe_target            = specs.hwpe_target

        # HWPE streaming interfaces
        self.list_sink_stream       = [item[0] for item in specs.list_sink_stream]
        self.list_sink_dtype        = [item[1] for item in specs.list_sink_stream] 
        self.list_sink_dim          = [item[2] for item in specs.list_sink_stream]
        self.list_source_stream     = [item[0] for item in specs.list_source_stream]
        self.list_source_dtype      = [item[1] for item in specs.list_source_stream] 
        self.list_source_dim        = [item[2] for item in specs.list_source_stream]
        self.n_sink                 = specs.n_sink
        self.n_source               = specs.n_source

        # HWPE custom regfiles
        self.custom_reg_name        = [item[0] for item in specs.custom_reg]
        self.custom_reg_dtype       = [item[1] for item in specs.custom_reg]
        self.custom_reg_dim         = [item[2] for item in specs.custom_reg]
        self.custom_reg_isport      = [item[3] for item in specs.custom_reg]
        self.custom_reg_num         = specs.custom_reg_num

        # RISC-V firmware stimuli 
        self.input_stimuli          = specs.input_stimuli
        self.output_result          = specs.output_result

        # Common template elements
        self.common_c               = template_c(specs).gen()
        self.overlay_waves          = overlay_waves(specs).gen()

        # Template
        self.template               = self.get_template()

    def gen(self):
        s = self.common_c + self.overlay_waves + self.template
        pulp_template = Template(s)
        string = pulp_template.render(
            author              = self.author,
            email               = self.email,
            target              = self.hwpe_target, 
            is_hero_offloading  = self.is_hero_offloading,
            is_release_0_2      = self.is_release_0_2,
            n_sink              = self.n_sink, 
            n_source            = self.n_source,
            stream_in           = self.list_sink_stream,
            stream_in_dtype     = self.list_sink_dtype,
            stream_in_dim       = self.list_sink_dim,
            stream_out          = self.list_source_stream,
            stream_out_dtype    = self.list_source_dtype,
            stream_out_dim      = self.list_source_dim,
            custom_reg_name     = self.custom_reg_name, 
            custom_reg_dtype    = self.custom_reg_dtype,
            custom_reg_dim      = self.custom_reg_dim, 
            custom_reg_isport   = self.custom_reg_isport,
            custom_reg_num      = self.custom_reg_num,
            input_stimuli       = self.input_stimuli,
            output_result       = self.output_result,
        )
        s = re.sub(r'\s+$', '', string, flags=re.M)
        return s
    
    def get_template(self):
        with open('templates/hw_management/'+self.module+'.template_wave_do', 'r') as f:
            s = f.read()
            f.close()
            return s

