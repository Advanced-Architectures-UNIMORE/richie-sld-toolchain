'''
 =====================================================================
 Project:       Cluster package
 Title:         pulp_cluster_defines.py
 Description:   Packages compliant with hardware accelerator parameters.

 Date:          23.11.2022
 ===================================================================== */

 Copyright (C) 2022 University of Modena and Reggio Emilia.

 Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.

'''
#!/usr/bin/env python3

from python.collector import collector

class PulpClusterDefines(collector):
    def top(self):
        return self.get_template()