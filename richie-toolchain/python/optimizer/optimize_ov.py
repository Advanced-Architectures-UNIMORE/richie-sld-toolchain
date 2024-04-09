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

    Project:        Richie Toolchain

    Title:          Import Input Specifications

    Description:    This routine is invoked during generation of application-specific
                    accelerators to extract system-level optimization parameters from
                    the kernel specifications. The derived parameters are iteratively
                    saved into an "Optimizer" class (defined in optimizer.py) that gets
                    saved (see use of package "pickle") and re-invoked at each routine
                    invocation. Once allkernels are investigated, the overlay specification
                    class is updated with the derived parameters.

    Date:           7.12.2021

    Author: 		Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''

#!/usr/bin/env python3

# Packages
from importlib import import_module
import pickle
import os.path

from optimizer import Optimizer

from dev.ov_dev.specs.ov_specs import ov_specs

'''
    Import application-specific accelerator specification.
    'TARGET_ACC' is a shell variable defined by the script "acc_gen_config.sh".
'''

acc_target = os.environ['TARGET_ACC']
module_name = "dev.acc_dev." + acc_target + ".specs.acc_specs"
acc_specs = import_module(module_name)

'''
    ========================
    Open optimizer chekpoint
    ========================
'''

def get_checkpoint(filename):

    if os.path.isfile(filename):

        '''
            Resume optimizer.
        '''

        print("[py] >> Resuming optimizer state")
        with open(filename, 'rb') as inp:
            obj_opt = pickle.load(inp)

    else:

        '''
            Invoke optimizer for the first time.
        '''

        print("[py] >> First invocation of optimizer state")
        obj_opt = Optimizer()

    return obj_opt

'''
    ========================
    Save optimizer chekpoint
    ========================
'''

def save_checkpoint(filename, obj_opt):

    '''
        Save optimizer state.
    '''

    print("[py] >> Saving optimizer state")
    with open(filename, 'wb') as outp:
        pickle.dump(obj_opt, outp, pickle.HIGHEST_PROTOCOL)

# ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~  #

'''
    ====================
    Optimization routine
    ====================
'''

'''
    Obtain accelerator offset.
    'OFFSET_ACC' is a shell variable defined by the script "acc_gen_config.sh".
    it is the pointer to the i-th accelerator in the generation process.
'''

acc_offset = os.environ['OFFSET_ACC']
acc_number = os.environ['N_ACC']

'''
    File where to save optimizer state.
'''

filename = 'state_optimizer.obj'

'''
    Initialize or resume optimization from checkpoint.
'''

obj_optimizer = get_checkpoint(filename)

'''
    Update optimizer offset.
'''

obj_optimizer.offset = int(acc_offset)

'''
    Obtain accelerator wrapper specification.
'''

print("\n[py] >> ACCELERATOR TARGET", obj_optimizer.offset + 1, "OUT OF", acc_number)

print("[py] >> Fetching user-defined wrapper specification")
standalone_acc_specs = acc_specs.acc_specs()

'''
    Obtain system-level accelerator specification.
'''

print("[py] >> Fetching user-defined and partially optimized system specification")
overlay_acc_specs = obj_optimizer.get_acc_specs_method(standalone_acc_specs.target)

'''
    Optimizing accelerator clustering. This optimization phase permits
    to gather:

        1) A list of clusters with attached information about:

            - Interconnect topology
            - Number of data ports (hp: 32b)

        2) Overall number of clusters
'''

obj_optimizer.opt_clustering(overlay_acc_specs, standalone_acc_specs)

'''
    Save optimization checkpoint.
'''

save_checkpoint(filename, obj_optimizer)

'''
    Final log.
'''

if obj_optimizer.offset is (int(acc_number)-1):
    print("\n[py] >> END OF OPTIMIZATION")
    print("\n[py] >> Optimizer has derived the following system specifications:")
    obj_optimizer.log()
