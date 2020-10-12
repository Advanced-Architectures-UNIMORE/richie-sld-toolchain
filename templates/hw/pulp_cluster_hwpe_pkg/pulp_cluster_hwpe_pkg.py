########################################################
## Gianluca Bellocchi <gianluca.bellocchi@unimore.it> ##
########################################################

#!/usr/bin/env python3

# Packages
from mako.template import Template
import math
import re
import sys

from templates.hw.common.hwpe_common import hwpe_common

# PULP cluster HWPE package
class pulp_cluster_hwpe_pkg:
    def __init__(self, specs):
        
        # Engineer(-s)
        self.author = specs.author
        self.email = specs.email

        # Environment
        self.destdir = specs.dest_dir
        self.module = "pulp_cluster_hwpe_pkg/pulp_cluster_hwpe_pkg"

        # Generic
        self.hwpe_target = specs.hwpe_target

        # HWPE streaming interfaces
        self.n_sink = specs.n_sink
        self.n_source = specs.n_source

        # Common template elements
        self.common     = hwpe_common(specs).gen()

        # Template
        self.template   = self.get_template()

    def gen(self):
        s = self.common + self.template
        pulp_template = Template(s)
        string = pulp_template.render(
            author      = self.author,
            email       = self.email,
            target      = self.hwpe_target, 
            n_sink      = self.n_sink, 
            n_source    = self.n_source,
        )
        s = re.sub(r'\s+$', '', string, flags=re.M)
        return s
    
    def get_template(self):
        with open('templates/hw/'+self.module+'.template_sv', 'r') as f:
            s = f.read()
            f.close()
            return s

