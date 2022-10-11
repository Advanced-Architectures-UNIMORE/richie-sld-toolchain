'''
 =====================================================================
 Project:       QuestaSim waves
 Title:         vsim_wave_wrapper.py
 Description:   QuestaSim waves to simplify validation phase of accelerator  
                wrapper components.

 Date:          19.1.22
 ===================================================================== */

 Copyright (C) 2021 University of Modena and Reggio Emilia.

 Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.

'''

#!/usr/bin/env python3

from python.collector import collector

class VsimWaveWrapper(collector):
    def top(self):
        return self.get_template()