########################################################
## Gianluca Bellocchi <gianluca.bellocchi@unimore.it> ##
########################################################

#!/usr/bin/env python3

# Counter
class counter:
    def __init__(self, hwpe_specs):
        self.common = ''

    def gen(self):
        self.module()
        return self.common

    def module(self):
        with open('templates/hw/hwpe_wrapper/hwpe_engine/modules/counter/counter.template_sv', 'r') as f:
            self.common += f.read()
            self.common += '\n'
            f.close()