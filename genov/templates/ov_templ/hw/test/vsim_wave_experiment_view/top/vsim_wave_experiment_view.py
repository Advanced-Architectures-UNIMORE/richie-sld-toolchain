'''
 =====================================================================
 Project:       QuestaSim waves
 Title:         vsim_wave_experiment_view.py
 Description:   QuestaSim waves to simplify validation phase of experiments.

 Date:          19.1.22
 ===================================================================== */

 Copyright (C) 2021 University of Modena and Reggio Emilia.

 Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.

'''

#!/usr/bin/env python3

from python.collector import collector

class VsimWaveExperimentView(collector):
    def top(self):
        return self.get_template()