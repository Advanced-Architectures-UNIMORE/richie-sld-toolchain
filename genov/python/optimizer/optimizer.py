'''
    =====================================================================

    Copyright (C) 2021 University of Modena and Reggio Emilia

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

    Title:          Collector

    Description:    The Optimizer class is responsible of deriving system-level
                    optimization parameters on the basis of the accelerator
                    kernel specifications. This process is transparent to the
                    user that defines the accelerator and overlay specifications
                    themselves. At the end, derived system-level parameters are
                    added up to the user-defined ones.

                    The '__init__' method imports the input specification parameters
                    from its parent class 'ov_specs'.

    Date:           23.11.2021

    Author: 		Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''

#!/usr/bin/env python3

# Packages
from importlib import import_module
import pickle
import os.path
import sys

# Design specification packages
from dev.ov_dev.specs.ov_specs import ov_specs

'''
    ===============
    Optimizer class
    ===============
'''

class Optimizer(ov_specs):

    def __init__(self):
        super().__init__()

        # kernel offset
        self.offset = 0

        # list of clusters
        self.list_clusters = []

        # number of clusters
        self.n_clusters = 0

    def log(self):
        print("\t- Number of clusters:", self.n_clusters)
        for cl in self.list_clusters:
            print("\t- Cluster #", self.list_clusters.index(cl), ":")
            print("\t\tInterconnect topology:", cl[0])
            print("\t\tAccelerator names:", cl[2])
            print("\t\tAccelerator protocols:", cl[4])
            print("\t\tAccelerator data ports:", cl[3])
            print("\t\tAccelerator data ports (total):", cl[1])

    '''
        Obtain user-defined system-level specification concerning the target accelerator kernel.

        - 'acc_target' ~ Name of target accelerator kernel.
    '''

    def get_acc_specs_method(self, acc_target):
        for t in self.get_targets_list():
            if str(self.offset) in t.__name__:
                if acc_target is t().target:
                    return t()

    '''
        Scan list of clusters in search for shared interconnect topologies.
    '''

    def is_first_shared_cl(self, acc_interco_type):
        for cl in self.list_clusters:
            if(cl[0] == acc_interco_type):
                return [False, cl]
        return [True, '']

    '''
        Calculate required number of accelerator data ports.
    '''

    def calc_data_ports(self, standalone_acc_specs):

        # get list of sink/source data ports
        n_sink = standalone_acc_specs.n_sink
        n_source = standalone_acc_specs.n_source

        # calculate number of required data ports
        n_data_ports = 0

        # scan sink ports
        for s in range(n_sink):
            if standalone_acc_specs.is_parallel_in[s] is True:
                n_data_ports += standalone_acc_specs.in_parallelism_factor[s]
            else:
                n_data_ports += 1

        # scan source ports
        for s in range(n_source):
            if standalone_acc_specs.is_parallel_out[s] is True:
                n_data_ports += standalone_acc_specs.out_parallelism_factor[s]
            else:
                n_data_ports += 1

        return n_data_ports

    '''
        Optimize accelerator clustering.
    '''

    def opt_clustering(self, overlay_acc_specs, standalone_acc_specs):

        # extract specifications concerning system-level accelerator interconnection
        acc_to_cluster          = overlay_acc_specs.target
        acc_interco_type        = overlay_acc_specs.connection_type
        acc_protocol_type       = overlay_acc_specs.protocol_type

        # calculate number of required data ports
        acc_n_data_ports        = self.calc_data_ports(standalone_acc_specs)

        # derive how many clusters are needed

        # 1) shared LIC clusters
        if(acc_interco_type is 'shared_lic'):

            print("[py] >> Interconnection method ~  Shared LIC")
            [is_first, shared_cl] = self.is_first_shared_cl(acc_interco_type)

            if(is_first is False):
                shared_cl[1] += acc_n_data_ports
                shared_cl[2].append(acc_to_cluster)
                shared_cl[3].append(acc_n_data_ports)
                shared_cl[4].append(acc_protocol_type)
            else:
                self.list_clusters.append([acc_interco_type, acc_n_data_ports, [acc_to_cluster], [acc_n_data_ports], [acc_protocol_type]])

        # 2) private LIC clusters
        elif(acc_interco_type is 'private_lic'):

            print("[py] >> Interconnection method ~  Dedicated LIC")
            self.list_clusters.append([acc_interco_type, acc_n_data_ports, [acc_to_cluster], [acc_n_data_ports], [acc_protocol_type]])

        # 3) shared HCI clusters
        elif(acc_interco_type is 'shared_hci'):

            print("[py] >> Interconnection method ~  Shared HCI")
            [is_first, shared_cl] = self.is_first_shared_cl(acc_interco_type)

            if(is_first is False):
                shared_cl[1] += acc_n_data_ports
                shared_cl[2].append(acc_to_cluster)
                shared_cl[3].append(acc_n_data_ports)
                shared_cl[4].append(acc_protocol_type)
            else:
                self.list_clusters.append([acc_interco_type, acc_n_data_ports, [acc_to_cluster], [acc_n_data_ports], [acc_protocol_type]])

        # 4) unknown topology
        else:

            print("[py] >> Interconnection method ~  NOT KNOWN")

        # count number of clusters
        self.n_clusters = len(self.list_clusters)

    '''
        Format optimized specifications in a simplified form to ease the templating stage.
    '''

    def formatting(self):
        self.clusters_formatted()

    '''
        Format cluster information.
    '''

    def clusters_formatted(self):
        '''
            Each of the following elements refer to a different cluster.
            This is achieved with lists where element offsets are associated
            to different clusters.
        '''
        # interconnect type
        self.cl_interco = []
        # overall number of accelerator data ports
        self.cl_n_data_ports = []
        # names associated with single clustered accelerators
        self.cl_acc_names = []
        # communication protocols of clustered accelerators
        self.cl_acc_protocols = []
        # number of data ports of clustered accelerators
        self.cl_acc_n_data_ports = []
        # extract parameters from methods
        for t in self.list_clusters:
            self.cl_interco.append(t[0])
            self.cl_n_data_ports.append(t[1])
            self.cl_acc_names.append(t[2])
            self.cl_acc_n_data_ports.append(t[3])
            self.cl_acc_protocols.append(t[4])

'''
    ========================================
    Retrieve optimized overlay specification
    ========================================
'''

def get_opt_cluster_params(filename):
    if os.path.isfile(filename):
        print("[py] >> Retrieving optimizer state")
        with open(filename, 'rb') as inp:
            obj_opt = pickle.load(inp)
        return obj_opt
    else:
        print("[py] >> No optimizer has been retrieved")
        sys.exit(1)

'''
    ==========================================
    Procedure to retrieve optimized parameters
    ==========================================

    # File where to save optimizer state.

file_opt = 'state_optimizer.obj'

    # Initialize or resume optimization from checkpoint.

opt_ov_specs = get_opt_specs(file_opt)

'''
