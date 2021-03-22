########################################################
## Gianluca Bellocchi <gianluca.bellocchi@unimore.it> ##
########################################################

#!/usr/bin/env python3

# Kernel interface
class overlay_waves:
    def __init__(self, hwpe_specs):
        self.author = hwpe_specs.author
        self.email = hwpe_specs.email
        self.common = ''

    def gen(self):
        self.waves_hero_offloading()
        self.waves_release_0_2()
        return self.common

    def waves_hero_offloading(self):
        with open('templates/hw_management/vsim_wave/vsim_overlay_versions/hero_offloading.template_wave_do', 'r') as f:
            self.common += f.read()
            self.common += '\n'
            f.close()

    def waves_release_0_2(self):
        with open('templates/hw_management/vsim_wave/vsim_overlay_versions/release_0_2.template_wave_do', 'r') as f:
            self.common += f.read()
            self.common += '\n'
            f.close()




