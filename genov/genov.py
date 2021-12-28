'''
 =====================================================================
 Project:      Accelerator-Rich Overlay Generator (AROG)
 Title:        genov.py
 Description:  Generation of accelerator-rich overlay components.

 Date:         23.11.2021
 ===================================================================== */

 Copyright (C) 2021 University of Modena and Reggio Emilia.

 Author: Gianluca Bellocchi, University of Modena and Reggio Emilia.

'''

#!/usr/bin/env python3

# Packages - Template
from mako.template import Template
import re
import pickle
import os.path
import sys

from optimizer import Optimizer
from emitter import emit_ov

from dev.ov_dev.specs.ov_specs import ov_specs

'''
    ================
    Import templates
    ================
'''

# HW packages
from templates.ov_templ.hw.overlay.overlay import overlay
from templates.ov_templ.hw.overlay_tb.overlay_tb import overlay_tb

# Integration support packages
from templates.ov_templ.integr_support.integr_support import integr_support

# SW packages
from templates.ov_templ.sw.hwpe_ov_tb.hwpe_ov_tb import hwpe_ov_tb as hwpe_ov_tb_sw

'''
    Generator class
    ===============
'''

class Generator(ov_specs):
    '''
        The overlay generator class is the main responsible for rendering
        the collected templates using the input user specification. 
        
        Technically speaking, the generator is derived (child class) from 'ov_specs'. 
        The latter comprises the input user parameters to guide the rendering phase. 
        The generator adds up to the functionality of its parent class methods to render
        the input templates. This is possible exploiting the 'render' method of the 'Template' 
        class defined in the Mako python package.

        The method 'gen' takes a 'template' input. This comprises all the template components 
        (top, modules, common) pertaining to a specific design components.

        The rendered output is a string.
    '''

    def __init__(self, opt_ov_specs):
        super().__init__()

        '''
            This step is necessary to pass to the "render" method
            the parameters that have been derived at run-time using 
            the optimizer.
        '''
        
        self.n_clusters                 = opt_ov_specs.n_clusters
        self.cl_interco                 = opt_ov_specs.cl_interco
        self.cl_n_data_ports            = opt_ov_specs.cl_n_data_ports
        self.cl_acc_names               = opt_ov_specs.cl_acc_names
        self.cl_acc_n_data_ports        = opt_ov_specs.cl_acc_n_data_ports

        print("\n[py] >> HIGH-LEVEL ARCHITECTURAL VIEW:")
        opt_ov_specs.log()
        
    def render(self, template):
        # prepare input template
        target = Template(template)
        # rendering phase
        string = target.render(
            # author
            author                  = self.author,
            email                   = self.email,
            # overall number of clusters
            n_clusters              = self.n_clusters,
            # interconnect type
            cl_interco              = self.cl_interco,
            # overall number of accelerator data ports 
            cl_n_data_ports         = self.cl_n_data_ports, 
            # names of clustered accelerators 
            cl_acc_names            = self.cl_acc_names,
            # number of data ports of clustered accelerators
            cl_acc_n_data_ports     = self.cl_acc_n_data_ports,
            # n_acc                   = self.n_acc,
            # acc_names               = self.acc_names,     
            # acc_protocol            = self.acc_protocol,  
            # acc_connection          = self.acc_connection,
        )
        # Compile a regex to trim trailing whitespaces on lines
        # and multiple consecutive new lines.
        re_trailws = re.compile(r'[ \t\r]+$', re.MULTILINE)
        string = re.sub(r'\n\s*\n', '\n\n', string) 
        string = re_trailws.sub("", string)
        return string

'''
    ========================================
    Retrieve optimized overlay specification
    ========================================
'''

def get_opt_specs(filename):
    if os.path.isfile(filename):
        print("[py] >> Retrieving optimizer state")
        with open(filename, 'rb') as inp:
            obj_opt = pickle.load(inp)
        return obj_opt
    else:
        print("[py] >> No optimizer has been retrieved")
        sys.exit(1)

'''
    ====================
    Components generator
    ====================
'''

def gencomps(temp_obj, descr, out_dir):
    template = temp_obj
    out_target = generator.render(template)
    filename = emitter.get_file_name(descr)
    emitter.out_gen(out_target, filename, out_dir)


'''
    File where to save optimizer state.
'''
 
filename = 'state_optimizer.obj'

'''
    Initialize or resume optimization from checkpoint.
'''

opt_ov_specs = get_opt_specs(filename)

'''
    Format parameters that are to be exposed to templates.
'''

opt_ov_specs.formatting()

'''
    =================
    Overlay generator
    =================

    Instantiate generator item
'''
generator = Generator(opt_ov_specs)

'''
    =======
    Emitter
    =======

    Instantiate export item
'''
emitter = emit_ov()

'''
    =====================================================================
    Component:      Accelerator-rich overlay

    Description:    Generation of components for the accelerator-rich
                    overlay. These permit the agile specification and 
                    optimization of architectural components to support
                    the operations of hardware accelerators.
    ===================================================================== */
'''

'''
    Instantiate overlay item
''' 
overlay = overlay()

'''
    Generate design components ~ Overlay accelerator package
''' 
gencomps(
    overlay.cl_pkg(),
    ['ov', 'cl_pkg', ['hw', 'rtl']],
    emitter.out_hw_ov
)

# '''
#     Generate design components ~ Overlay accelerator interface
# ''' 
# gencomps(
#     overlay.acc_intf(),
#     ['ov', 'acc_intf', ['hw', 'rtl']],
#     emitter.out_hw_ov
# )

# '''
#     =====================================================================
#     Component:      Hardware support

#     Description:    Generation of integration support components, such as
#                     scripts for source management tools, simulations, etc.
#     ===================================================================== */
# '''

# '''
#     Instantiate integration support item
# ''' 
# integr_support = integr_support()

# '''
#     Generate design components ~ QuestaSim waves
# ''' 
# gencomps(
#     integr_support.vsim_wave(),
#     ['integr_support', 'pulp_tb', ['integr_support', 'vsim_wave']],
#     emitter.ov_gen_acc_int
# )

'''
    =====================================================================
    Component:      Overlay testbench - Hardware

    Description:    Generation of hardware components for overlay testbench. 
    ===================================================================== */
'''

'''
    Instantiate HW testbench item
''' 
overlay_tb = overlay_tb()

'''
    Generate design components ~ hardware testbench
    Basic standalone testbench that instantiates the DUT
    (generated accelerator), a RISC-V processor and some
    dummy memories to implement instruction, stack and data
    memories.
''' 
gencomps(
    overlay_tb.tb_ov(),
    ['tb', 'tb_ov', ['hw', 'rtl']],
    emitter.out_hw_tb_ov
)


'''
    =====================================================================
    Component:      Overlay testbench - Software

    Description:    Generation of software components for overlay testbench. 
    ===================================================================== */
'''

# '''
#     Instantiate SW testbench item
# ''' 
# hwpe_ov_tb_sw = hwpe_ov_tb_sw()

# '''
#     Generate design components ~ archi
#     Retrieve memory-mapped hardware accelerator registers.
# ''' 
# gencomps(
#     hwpe_ov_tb_sw.archi_hwpe(),
#     ['sw', 'archi_hwpe', ['sw', 'archi']],
#     emitter.out_sw_ov_hwpe_lib
# )

# '''
#     Generate design components ~ hardware abstraction layer (HAL)
#     Retrieve Hardware Abstraction Layer with functions that permit 
#     to create an interaction between the RISC-V processor and the 
#     hardware accelerator.
# ''' 
# gencomps(
#     hwpe_ov_tb_sw.hal_hwpe(),
#     ['sw', 'hal_hwpe', ['sw', 'hal']],
#     emitter.out_sw_ov_hwpe_lib
# )

# '''
#     Generate design components ~ software testbench 
#     Retrieve software testbench to assess HWPE functionality. This 
#     is a pure baremetal test running on the riscv proxy core comprised 
#     in the overlay system. This tb can be used as a starting point for 
#     additional platform testing.
# ''' 
# gencomps(
#     hwpe_ov_tb_sw.tb_hwpe(),
#     ['sw', 'tb_hwpe', ['sw', 'tb']],
#     emitter.out_sw_ov
# )