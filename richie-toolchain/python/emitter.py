'''
    =====================================================================

    Copyright (C) 2022 University of Modena and Reggio Emilia

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

    Title:          Emitter

    Description:    The emitter class is responsible of creating the ouput
                    environment, to assemble the associated repository, as
                    well as its file components.

    Date:           9.2.2022

    Author: 		Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''

#!/usr/bin/env python3

'''
    Import Python packages
'''
import numpy as np
import sys
import struct
import shutil
from distutils.dir_util import copy_tree
import os

'''
    =============
    Emitter class
    =============
'''

class Emitter:

    def __init__(self, platform_design_knobs, accelerator_design_knobs, dir_out_platform, dir_out_accelerator):

        '''
            Design knobs
        '''
        self.platform_design_knobs          = platform_design_knobs
        self.accelerator_design_knobs       = accelerator_design_knobs

        '''
            Output environment
        '''
        self.out_dir                        = 'output'

        '''
            =======================================
            Output environment ~ Generated platform
            =======================================

            This set of parameters describe the output environment
            where the generated platform components are inserted. The
            parameters should match to the hierarchy of directories
            defined in the tool script "out_gen_out_env.sh".
        '''

        if platform_design_knobs is not None and dir_out_platform is not None:

            self.out_platform                               = dir_out_platform

            # IP
            self.out_platform_ip                            = self.out_platform + '/ip'

            # HeSoC
            self.out_platform_hesoc                         = self.out_platform + '/hesoc'
            self.out_platform_hesoc_pkg                     = self.out_platform_hesoc + '/packages'
            self.out_platform_hesoc_rtl                     = self.out_platform_hesoc + '/rtl'
            self.out_platform_hesoc_ooc                     = self.out_platform_hesoc_rtl + '/out-of-context'

            # Cluster
            self.out_platform_cl                            = self.out_platform + '/cluster'
            self.out_platform_cl_pkg                        = self.out_platform_cl + '/packages'
            self.out_platform_cl_rtl                        = self.out_platform_cl + '/rtl'

            # Libs
            self.out_platform_libs                          = self.out_platform + '/libs'
            self.out_platform_libhwpe                       = self.out_platform_libs + '/libhwpe'
            self.out_platform_librichie_target              = self.out_platform_libs + '/librichie-target'
            self.out_platform_hwpe_structs                  = self.out_platform_libs + '/hwpe_structs'
            self.out_platform_hesoc_structs                 = self.out_platform_libs + '/hesoc_structs'

            # Test
            self.out_platform_test                          = self.out_platform + '/test'
            self.out_platform_test_waves                    = self.out_platform_test + '/waves'

            # Software test runtime
            self.out_platform_test_sw                       = self.out_platform_test + '/sw'
            self.out_platform_test_inc                      = self.out_platform_test + '/sw/inc'
            self.out_platform_test_hwpe_lib                 = self.out_platform_test + '/sw/inc/hwpe_lib'

        '''
            ==========================================
            Output environment ~ Generated accelerator
            ==========================================

            This set of parameters describe the output environment
            where the generated accelerator wrapper is inserted. The
            parameters should match to the hierarchy of directories
            defined in the tool script "acc_gen_out_env.sh".
        '''

        if accelerator_design_knobs is not None and dir_out_accelerator is not None:

            self.out_accelerator                            = os.path.join(dir_out_accelerator, accelerator_design_knobs.target)

            # Hardware
            self.out_accelerator_wrapper                    = self.out_accelerator + '/wrap'
            self.out_accelerator_rtl                        = self.out_accelerator + '/rtl'
            self.out_accelerator_acc_kernel                 = self.out_accelerator + '/rtl/acc_kernel'

            # Test
            self.out_accelerator_test                       = self.out_accelerator + '/test'

            # Standalone test - Hardware
            self.out_accelerator_standalone_test_hw         = self.out_accelerator_test + '/hw'

            # Standalone test - Software
            self.out_accelerator_standalone_test_sw         = self.out_accelerator_test + '/sw'
            self.out_accelerator_standalone_test_hwpe_lib   = self.out_accelerator_test + '/sw/inc/hwpe_lib'

            # System test - Software
            self.out_accelerator_system_test_hwpe_lib       = self.out_accelerator + '/../../test/sw/inc/wrappers/' + accelerator_design_knobs.target + '/hwpe_lib'

    """
    The 'out_gen' method is in charge of physically setting up the output
    repository moving generated files to their target positions. The term
    'gen' is used to denote files that are the targets of the rendering phase.
    The input arguments are:

    - 'out_target' ~ Generated design component. Typically an output string from
    a generator item.

    - 'filename' ~ Name of generated design component. Typically an output string from
    an emitter item.

    - 'filedir' ~ Target directory. Either a custom string or one of those defined
    in the emitter constructor.
    """
    def out_gen(self, out_target, filename, filedir):
        try:
            if(os.path.isdir(filename)):
                source = filename
                destination = filedir
                shutil.copytree(source, destination)
            else:
                destination_file = os.path.join(filedir, filename)
                with open(destination_file, "w") as f:
                    f.write(out_target)
            # print("\nExporting generated item (", filename, ") to target destination (", filedir, ")")
        except shutil.Error as err:
            print("\nGenerated item (", filename, ") already exists at target destination (", filedir, ")")

    """
    The 'get_file_name' method gets information about the features of the
    generated IP, support file, SW component, etc. and constructs the name
    of the export file with the aid of the following methods:

    - 'construct_file_name' ~ it offers a dictionary that associates the supported
    device types (at accelerator- and platform-level) with a particular file_name constructor;

    - 'hwpe_file_name' ~ an exemplary file_name constructor targeting HWPE devices;

    - 'get_dict_file_ext' ~ it offers a dictionary to derive the file_name extension.

    The input 'target' argument is a list of information about the target whose name
    has to be obtained. The input list is constructed in the following way:

    - Item 0 = Device type ~ the first list item aims at defining the type of the device
    the generated component is devoted to (Accelerator-level? Platform-level?). Each device
    has its rules about filename construction, so a particular filename constructor is needed
    in most of cases. Thus, this input parameter changes the way the file_name is constructed.
    For more information, take a look at the method 'construct_file_name' and the python
    dictionary that is used to choose the proper constructor.

    - Item 1 = Design name ~ this item defines the the name of the generated design item in the
    filename. Thus, this defines the use the generated file is used for.

    - Item 2 = Design type ~ this item is a sub-list that is employed to solve the choice of the
    proper file extension. For more information about how file extensions are retrieved, see
    method 'get_dict_file_ext'. The latter defines two nested dictionaries to associate the
    design type information with a proper file extension.
    """
    def get_file_name(self, target):
        # #
        self.device_type = target[0]
        self.design_name = target[1]
        self.design_type = target[2]
        # get file extension
        self.file_ext = self.get_dict_file_ext()
        # construct file name
        return self.construct_file_name()

    '''
    Defines a dictionary that associates the supported device types (at accelerator- and platform-level)
    with a particular file_name constructor.
    '''
    def construct_file_name(self):
        # dictionary for file extensions
        dict_file_ext = {}
        # add file extensions for platform components
        if self.platform_design_knobs is not None:
            dict_file_ext.update({
                'hesoc'             : self.hesoc_file_name(),
                'cl'                : self.cl_file_name(),
                'tb'                : self.tb_file_name(),
                'integr_support'    : self.integr_support_file_name(),
                'sw'                : self.sw_file_name(),
            })
        # add file extensions for platform components
        if self.accelerator_design_knobs is not None:
            dict_file_ext.update({
                'hwpe'              : self.hwpe_file_name(),
                'tb'                : self.tb_file_name(),
                'integr_support'    : self.integr_support_file_name(),
                'sw'                : self.sw_file_name()
            })
        return dict_file_ext[self.device_type]

    '''
    Constructor of file names targeting the HeSoC.
    '''
    def hesoc_file_name(self):
        file_name = self.design_name + self.file_ext
        return file_name

    '''
    Constructor of file names targeting HWPE devices.
    '''
    def hwpe_file_name(self):
        file_name = self.accelerator_design_knobs.target + '_' + self.design_name + self.file_ext
        return file_name

    '''
    Constructor of file names targeting the cluster.
    '''
    def cl_file_name(self):
        file_name = 'pulp_cluster_' + self.design_name + self.file_ext
        return file_name

    '''
    Constructor of file names targeting the testbench.
    '''
    def tb_file_name(self):
        file_name = self.design_name + self.file_ext
        return file_name

    '''
    Constructor of file names for support during integration.
    '''
    def integr_support_file_name(self):
        file_name = self.design_name + self.file_ext
        return file_name

    '''
    Constructor of file names for softare testbench.
    '''
    def sw_file_name(self):
        file_name = self.design_name + self.file_ext
        return file_name

    '''
    Create dictionary with the output file extensions.
    '''
    def get_dict_file_ext(self):
        dict_file_ext = {
            'hw'                : { "sv": ".sv", "v": ".v" } ,
            'integr_support'    : { "yml": ".yml", "lock": ".lock", "vsim_wave": ".tcl", "mk": "" } ,
            'sw'                : { "archi": ".h", "hal": ".h", "tb": ".c", "app": ".c", "API": ".c", "header": ".h" }
        }
        return dict_file_ext[self.design_type[0]][self.design_type[1]]
