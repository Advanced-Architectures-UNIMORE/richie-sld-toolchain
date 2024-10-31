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

    Title:          Logger

    Description:    Print logs at generation-time.

    Date:           17.4.2024

    Author: 		Gianluca Bellocchi <gianluca.bellocchi@unimore.it>

    =====================================================================

'''

'''
  =====================================================================
  Title:        Logger
  Type:         Class
  Description:  Print logs during the generation of diverse platform and
                accelerator components.
  =====================================================================
'''

class Logger:

    def __init__(self, platform_design_knobs, accelerator_design_knobs):
        self.platform_design_knobs      = platform_design_knobs
        self.accelerator_design_knobs   = accelerator_design_knobs

    '''
        ======
        Richie
        ======
    '''

    def richie(self, verbose=False):

        print("\n")
        print("# ======================== #")
        print("# Generation of Richie Top #")
        print("# ======================== #")

    '''
        ======================
        Accelerator-Rich HeSoC
        ======================
    '''

    def hesoc(self, verbose=False):

        print("\n")
        print("# ==================================== #")
        print("# Generation of Accelerator-Rich HeSoC #")
        print("# ==================================== #")

        if(verbose is True):

            print("\n")
            print("[py] >> Platform design knobs for the HeSoC specialization:")

            print("\n\tHeSoC name:", self.platform_design_knobs.hesoc_name)

    '''
        =======
        Cluster
        =======
    '''

    def cluster(self, cluster_id=0, verbose=False):

        print("\n")
        print("# =========================== #")
        print("# Generation of Cluster n.", cluster_id, " #")
        print("# =========================== #")

        if(verbose is True):

            print("\n")
            print("[py] >> Platform design knobs for the cluster specialization:")

            print("\n\tLIC interconnect:")
            print("\t\tAccelerator names:",               self.platform_design_knobs.list_cl_lic[cluster_id][1])
            print("\t\tAccelerator protocols:",           self.platform_design_knobs.list_cl_lic[cluster_id][2])
            print("\t\tAccelerator data ports:",          self.platform_design_knobs.list_cl_lic[cluster_id][3])
            print("\t\tAccelerator data ports (total):",  self.platform_design_knobs.list_cl_lic[cluster_id][0])

            print("\n\tHCI interconnect:")
            print("\t\tAccelerator names:",               self.platform_design_knobs.list_cl_hci[cluster_id][1])
            print("\t\tAccelerator protocols:",           self.platform_design_knobs.list_cl_hci[cluster_id][2])
            print("\t\tAccelerator data ports:",          self.platform_design_knobs.list_cl_hci[cluster_id][3])
            print("\t\tAccelerator data ports (total):",  self.platform_design_knobs.list_cl_hci[cluster_id][0])


    '''
        ================================
        HWPE-based Accelerator interface
        ================================
    '''

    def hwpe_accelerator_interface(self, verbose=False):

        acc_name_len = len(self.accelerator_design_knobs.target)

        print("\n")
        print("# ========================================================================%s #" % ''.join([acc_name_len * c for c in "="]))
        print("# Generation of HWPE-based Accelerator Interface for Accelerator Datapath %s #" % self.accelerator_design_knobs.target.upper())
        print("# ========================================================================%s #" % ''.join([acc_name_len * c for c in "="]))

        if(verbose is True):

            print("\n")
            print("[py] >> Accelerator design knobs for the HWPE specialization:")

            '''
                Datapath information
            '''

            print("\n\tAccelerator datapath:")

            print("\t\tTarget name:", self.accelerator_design_knobs.target)
            print("\t\tDesign Methodology:", self.accelerator_design_knobs.design_type)

            if(self.accelerator_design_knobs.is_ap_ctrl_hs is True):
                print("\t\tInterface: Xilinx ap_ctrl_hs")

            if(self.accelerator_design_knobs.is_mdc_dataflow is True):
                print("\t\tInterface: MDC dataflow")

            '''
                Streamer information
            '''

            print("\n\tInput data streams:")

            # scan sink ports
            for s in range(self.accelerator_design_knobs.n_sink):
                print("\t\tPort name:", self.accelerator_design_knobs.stream_in[s])
                if self.accelerator_design_knobs.is_parallel_in[s] is True:
                    print("\t\tNumbedesign_knobsr of ports:", self.accelerator_design_knobs.in_parallelism_factor[s])
                else:
                    print("\t\tNumber of ports:", 1)
                print("\t\tConfigurable address generator:", self.accelerator_design_knobs.addr_gen_in_isprogr[s])
                if(s < self.accelerator_design_knobs.n_sink - 1):
                    print("")

            print("\n\tOutput data streams:")

            # scan source ports
            for s in range(self.accelerator_design_knobs.n_source):
                print("\t\tPort name:", self.accelerator_design_knobs.stream_out[s])
                if self.accelerator_design_knobs.is_parallel_out[s] is True:
                    print("\t\tNumber of ports:", self.accelerator_design_knobs.out_parallelism_factor[s])
                else:
                    print("\t\tNumber of ports:", 1)
                print("\t\tConfigurable address generator:", self.accelerator_design_knobs.addr_gen_out_isprogr[s])
                if(s < self.accelerator_design_knobs.n_source - 1):
                    print("")

            '''
                Controller information
            '''

            print("\n\tRegister file:")
            print("\t\tCustom register names:", self.accelerator_design_knobs.custom_reg_name)

    '''
        ===========
        Richie test
        ===========
    '''

    def richie_test(self, verbose=False):

        print("\n")
        print("# ============================== #")
        print("# Generation of Richie Testbench #")
        print("# ============================== #")

    '''
        =====================================
        HWPE-based Accelerator interface test
        =====================================
    '''

    def hwpe_accelerator_interface_test(self, verbose=False):

        acc_name_len = len(self.accelerator_design_knobs.target)

        print("\n")
        print("# ==================================================================%s #" % ''.join([acc_name_len * c for c in "="]))
        print("# Generation of HWPE-based Standalone Test for Accelerator Datapath %s #" % self.accelerator_design_knobs.target.upper())
        print("# ==================================================================%s #" % ''.join([acc_name_len * c for c in "="]))

        if(verbose is True):

            print("\n")
            print("[py] >> Accelerator design knobs for the HWPE test specialization:")

            print("\nTarget name:", self.accelerator_design_knobs.target)

    '''
        ===================
        Richie SW libraries
        ===================
    '''

    def richie_libs(self, verbose=False):

        print("\n")
        print("# ======================================================= #")
        print("# Generation of Accelerator-Rich HeSoC Software Libraries #")
        print("# ======================================================= #")
