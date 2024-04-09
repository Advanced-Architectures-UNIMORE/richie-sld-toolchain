########################################################
## Gianluca Bellocchi <gianluca.bellocchi@unimore.it> ##
########################################################

#!/usr/bin/env python3

from python.collector import collector

# SW testbench HWPE
class tb_hwpe(collector):
    def top(self):
        return self.get_template()

    
